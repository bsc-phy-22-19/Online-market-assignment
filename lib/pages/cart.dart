import 'package:flutter/material.dart';
import 'package:student_online_market/item_view/detailed_view.dart';
import 'package:student_online_market/pages/payment_options.dart';

class CartView extends StatefulWidget {
  final String itemName;
  final int itemPrice;
  final String description;

  const CartView({Key? key, required this.itemName, required this.itemPrice, required this.description}) : super(key: key);

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
                      MaterialPageRoute(builder: (context) => DetailedView(itemName: widget.itemName, itemPrice: widget.itemPrice, description: widget.description,)),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/static_images/sample_item.png", height: 70),
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
                          minimumSize: const Size(40, 40),
                        ),
                        child: const Text(
                          'Buy',
                          style: TextStyle(
                            fontSize: 19,
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
