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
  // final _formKey = GlobalKey<FormState>();
  TextEditingController _item_name = TextEditingController();
  TextEditingController _item_price= TextEditingController();
  TextEditingController _item_category = TextEditingController();
  TextEditingController _item_deal = TextEditingController();
  TextEditingController _item_description = TextEditingController();
  XFile? pickedFile = XFile("");
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                reusableTextBox("Item Price", false, _item_price),
          
                SizedBox(height: 10,),
                reusableTextBox("Item Category", false, _item_category),
          
                SizedBox(height: 30,),
                reusableTextBox("Item deal (optional)", false, _item_deal),
          
                SizedBox(height: 10,),
                reusableTextBox("Item description", false, _item_description),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    categoryDropDown(),


                    SizedBox(width: 30,),
                    ElevatedButton(
                      onPressed: (){
                  
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
                ElevatedButton(
                  onPressed: () async {
                    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

                    // Create a reference to the location you want to upload to in Firebase Storage
                    // String fileName = basename(pickedFile.path);
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
  List<String> items = ['Item 1', 'Item 2', 'Item 40', 'Item 3', 'Item 4', 'Item 5'];
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


