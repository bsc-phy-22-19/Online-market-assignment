import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_online_market/database/firebase_db.dart';
import 'package:student_online_market/utils/reusable_widgets.dart';

class PostBusiness extends StatefulWidget {
  const PostBusiness({super.key});

  @override 
  State<PostBusiness> createState() => _PostBusinessState();
}

class _PostBusinessState extends State<PostBusiness>{
  bool _showOverlay = false;

  void _toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }
  // final _formKey = GlobalKey<FormState>();
  TextEditingController _item_name = TextEditingController();
  TextEditingController _item_price= TextEditingController();
  TextEditingController _item_category = TextEditingController();
  TextEditingController _item_deal = TextEditingController();
  TextEditingController _item_description = TextEditingController();
  XFile? pickedFile = XFile("");
  
  TextEditingController _category_name = TextEditingController();
  XFile? pickedCategoryFile = XFile("");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 172, 166, 166),
        body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image.asset("assets/static_images/online_market.png", height: 70),
                
                SizedBox(height: 50,),
                reusableTextBox("Item Name", false, _item_name),
          
                SizedBox(height: 10,),
                reusableTextBox("Item Price", true, _item_price),
          
                SizedBox(height: 10,),
                if (_showOverlay)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.black54,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            height: 300,
                            color: Colors.white,
                            child: Column(
                              children: [
                                TextField(
                                  controller: _category_name,
                                  decoration: InputDecoration(
                                    hintText: 'Enter category name',
                                  ),
                                ),

                                ElevatedButton(
                                  onPressed: () async {
                                    pickedCategoryFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                  }, child: const Text("Choose Picture")),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      child: const Text('Save'),
                                      onPressed: () async {
                                        final database = FirestoreCategory();
                                        await database.createItem(
                                          _category_name.text,
                                          File(pickedCategoryFile!.path)
                                        );
                                        _toggleOverlay();
                                    }
                                    ),
                                    ElevatedButton(
                                      child: Text('Cancel'),
                                      onPressed: _toggleOverlay,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Select Category: "),

                    SizedBox(width: 30,),
                    categoryDropDown(),

                    SizedBox(width: 30,),
                    ElevatedButton(
                      onPressed: (){
                        _toggleOverlay();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20/4),
                      ),
                      child: Center(
                            child: Icon(Icons.add, color: Colors.white)
                          )
                    ),
                  ],
                ),
          
                SizedBox(height: 10,),
                reusableTextBox("Item description", false, _item_description),

                SizedBox(height: 30,),
                reusableTextBox("Item deal (optional)", false, _item_deal),
                
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () async {
                    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  }, 
                  child: Text("choose item picture ...")),

                SizedBox(height: 20,),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 200,),
                    ElevatedButton( 
                      onPressed: () async {
                        final database = FirestoreDatabase();
                        await database.addItemToCollection(
                          _item_category.text,
                          _item_name.text,
                          double.parse(_item_price.text),
                          _item_deal.text,
                          _item_description.text,
                          File(pickedFile!.path)
                        );
                        Navigator.pop(context);
                  }, child: Text("Post")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}


Widget categoryDropDown() {
  final FirestoreCategory db = FirestoreCategory();
  void getData() async {
    List<List<String>> listOfLists = await db.getListOfLists();

    // Now you can iterate through the listOfLists to access each item
    print(listOfLists);
    print("Im here");
    for (List<String> innerList in listOfLists) {
      print(innerList);
      for (String item in innerList) {
        print(item);
      }
    }
  }
  
  List<String> items = ['Stationary', 'Food', 'Suit', 'Clothing', 'Books', 'Kitchen ware', 'Medicine', 'Electronics'];
  String selectedItem = items[0];

  items.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

  return Container(
    
    child: DropdownButton<String>(
      value: selectedItem,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {
        // selectedItem = value;
        print(value);
      },
    ),
  );
}






// Widget searchableDropdown() {
//   List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
//   String selectedItem = items[0];

//   return Container(
//     child: SelectSearchableList<String>(
//       items: items,
//       selectedValue: selectedItem,
//       onChanged: (value) {
//         selectedItem = value;
//       },
//       searchBoxDecoration: InputDecoration(
//         hintText: 'Search for an item',
//         border: OutlineInputBorder(),
//       ),
//       label: 'Select an item',
//       showSelectedItemAsLabel: true,
//       itemBuilder: (context, item, isSelected) {
//         return ListTile(
//           title: Text(item),
//           selected: isSelected,
//         );
//       },
//     ),
//   );
// }


