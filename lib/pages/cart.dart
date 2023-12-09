import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_online_market/database/firebase_db.dart';
import 'package:student_online_market/item_view/detailed_view.dart';
import 'package:student_online_market/pages/payment_options.dart';

class CartView extends StatefulWidget {
  final String itemName;
  final double itemPrice;
  final int itemsSelected;
  final String itemPictureUrl; 

  const CartView({Key? key, required this.itemName, required this.itemPrice, required this.itemsSelected, required this.itemPictureUrl}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
              children: [
                Container(
                width: MediaQuery.of(context).size.width * 0.98,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailedView(itemName: widget.itemName, itemPrice: widget.itemPrice, description: "${widget.itemsSelected} items selected", itemPictureUrl: widget.itemPictureUrl,)),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:CachedNetworkImage(
                          imageUrl: widget.itemPictureUrl,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          height: 70,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.itemName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("5 items selected"),
                              SizedBox(
                                width: 32,
                                height: 27,
                                child: ElevatedButton(
                                  onPressed: (){
                              
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: ContinuousRectangleBorder(),
                                    padding: EdgeInsets.all(20/4),
                                  ),
                                  child: Center(
                                        child: Icon(Icons.add, color: Colors.white)
                                      )
                                ),
                              ),

                              SizedBox(width: 4),
                              SizedBox(
                                width: 32,
                                height: 27,
                                child: ElevatedButton(
                                  onPressed: (){
                              
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: ContinuousRectangleBorder(),
                                    padding: EdgeInsets.all(20/4),
                                  ),
                                  child: Center(
                                        child: Icon(Icons.remove, color: Colors.white)
                                      )
                                ),
                              ),

                            ],
                          ),

                          






                          Text(
                            "${widget.itemPrice}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          
                          
                        ],
                      ),
                    
                    
                    
                    
                    VerticalDivider(
                      width: 10,
                      thickness: 2,
                      color: Colors.black,
                    ),

                    
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 37, 161, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          minimumSize: const Size(30, 40),
                        ),
                        child: const Text(
                          'Buy',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PaymentMethod()),
                          );
                        },
                      ),
                    
                    ],
                  ),
                ),
              ),



              // Align(
              //           alignment: Alignment.bottomRight,
              //           child: FloatingActionButton(
              //             onPressed: () {
              //               // OnPressed Logic
              //             },
              //             child: Icon(Icons.add),
              //             backgroundColor: Colors.blue,
              //           ),
              //         ),
              
              ]
              ),
    );
}
}

Scaffold allCartItems() {
  FirestoreCart db = FirestoreCart();
  User user = FirebaseAuth.instance.currentUser!;

  return Scaffold(
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
              child: CartView(itemName: data['itemName'], itemPrice: data['price'], itemsSelected: data['itemsSelected'], itemPictureUrl: data['itemPictureUrl']),
            );
          }).toList() 
        );
      },
    ),
  );
}