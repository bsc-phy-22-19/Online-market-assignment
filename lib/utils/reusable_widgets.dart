import 'package:flutter/material.dart';
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
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      hintText: text,
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: false,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      fillColor: Colors.green.withOpacity(0.9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 1, style: BorderStyle.solid)
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
            
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => allCartItems()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}







