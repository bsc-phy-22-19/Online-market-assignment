import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_online_market/database/firebase_db.dart';
import 'package:student_online_market/pages/payment_options.dart';

class DetailedView extends StatefulWidget {
  final String itemName;
  final double itemPrice;
  final String description;
  final String itemPictureUrl; 

  const DetailedView({Key? key, required this.itemName, required this.itemPrice, required this.description, required this.itemPictureUrl}) : super(key: key);

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.itemName,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${widget.itemPrice}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                  Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:CachedNetworkImage(
                          imageUrl: widget.itemPictureUrl,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          height: 140,
                        ),
                      ),
                ]
              ),
              
              const SizedBox(height: 50),
              const Column(
                children: [
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text("200 Ratings"),
                          Text("4.0")
                        ],
                      ),
                      VerticalDivider(
                        thickness: 2,
                        color: Colors.black,
                      ),

                      Column(
                        children: [
                          Text("Items Available"),
                          Text("58")
                        ],
                      ),
                      VerticalDivider(
                        thickness: 2,
                        color: Colors.black,
                      ),

                      Column(
                        children: [
                          Text("Colors Available"),
                          Text("Green and Red")
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(widget.description),
                ],
              ),

              Row(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PaymentMethod()),
                        );
                    },
                    child: const Text("Buy Now"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      User user = FirebaseAuth.instance.currentUser!;

                      FirestoreCart db = FirestoreCart();
                      db.createItem(widget.itemName, user.uid, widget.itemPrice, widget.itemPictureUrl);
                    },
                    child: const Text("Add to Cart"),
                  )
                ],
              ),
              
            ],
          ),
        ),
      
      ),
    );
  }
}
