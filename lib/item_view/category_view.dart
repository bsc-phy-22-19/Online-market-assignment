import 'package:flutter/material.dart';
import 'package:student_online_market/pages/home.dart';

class CategoryView extends StatefulWidget {
  final String categoryName;
  final String description;

  const CategoryView({Key? key, required this.categoryName, required this.description}) : super(key: key);

  @override 
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView>{  

  @override
  Widget build(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width * 0.50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12),
                ),

              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(showSimpleView: true, currentCategory: widget.categoryName,)),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    


                    Image.asset("assets/static_images/sample_item.png", height: 50),
                    
                    const SizedBox(width: 10),
                    Text(
                      widget.categoryName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(width: 14),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 14,
                        // fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );

    }
}

