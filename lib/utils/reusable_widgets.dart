import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_online_market/database/firebase_db.dart';
import 'package:student_online_market/item_view/category_view.dart';
import 'package:student_online_market/pages/cart.dart';
import 'package:student_online_market/pages/home.dart';

TextField reusableTextField(String text, bool isPassword, TextEditingController controller){
  return TextField(
    controller: controller,
    obscureText: isPassword,
    enableSuggestions: !isPassword,
    autocorrect: !isPassword,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      labelText: text,
      
      enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF29953A),
        width: 2.0,
      ),
    ),
    ),
    keyboardType: isPassword? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}

TextField reusableTextBox(String text, bool isNumber, TextEditingController controller){
  return TextField(
    controller: controller,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.green.withOpacity(0.9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0.3),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none)
      ),
   ),
    keyboardType: isNumber? TextInputType.number : TextInputType.text,
  );
}






class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onSortPressed;
  final Function onProfilePressed;
  final Function onSearchPressed;
  final Function onCartPressed;

  const ReusableAppBar({
    Key? key,
    required this.title,
    required this.onSortPressed,
    required this.onProfilePressed,
    required this.onSearchPressed,
    required this.onCartPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: IconButton(
      //   icon: Icon(Icons.arrow_back_ios), // replace with your own icon data
      //   onPressed: () {
      //     Navigator.of(context).pop();
      //   },
      // ),
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(Icons.category),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage(showSimpleView: false,)),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.sort),
          onPressed: onSortPressed(),
        ),
        if(title.toLowerCase() != "profile")
          IconButton(
            icon: Icon(Icons.person),
            splashColor: Colors.transparent,
            onPressed: (){
              onProfilePressed();
            },
          ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: onSearchPressed(),
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: (){










            FirestoreCart db = FirestoreCart();
            User user = FirebaseAuth.instance.currentUser!;

            Scaffold(
              body: StreamBuilder<QuerySnapshot>(
                stream: db.readItems(user.uid),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text('Loading'));
                  }

                    return Column(
                      children: (snapshot.data?.docs ?? []).map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CartView(itemName: data['itemName'], itemPrice: data['price'], description: data['itemsSelected'],),
                        );
                      }).toList() 
                    );

                },
              ),
            );





  
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}





