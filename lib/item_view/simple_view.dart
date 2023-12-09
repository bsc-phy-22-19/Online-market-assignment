import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:student_online_market/item_view/detailed_view.dart';
import 'package:student_online_market/utils/ratings.dart';

class SimpleView extends StatefulWidget {
  final String itemName;
  final double itemPrice;
  final String deal;
  final String description;
  final String itemPictureUrl; 

  const SimpleView({Key? key, required this.itemName, required this.itemPrice, required this.deal, required this.description, required this.itemPictureUrl}) : super(key: key);

  @override
  State<SimpleView> createState() => _SimpleViewState();
}

class _SimpleViewState extends State<SimpleView> {
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
                      MaterialPageRoute(builder: (context) => DetailedView(itemName: widget.itemName, itemPrice: widget.itemPrice, description: widget.description, itemPictureUrl: widget.itemPictureUrl)),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text(
                            "${widget.itemPrice}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),


                          StarRating(rating: 1),



                        ],
                      ),
                    ],
                  ),
                ),
              ),
    
    
              Positioned(
                top: 10,
                right: 5,
                child: Transform.rotate(
                  angle: 3.14 / 5,
                  child: Text(
                    widget.deal,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
    
    
              
              ]
              ),
    );
}
}
