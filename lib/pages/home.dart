import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_online_market/database/firebase_db.dart';
import 'package:student_online_market/item_view/category_view.dart';
import 'package:student_online_market/item_view/simple_view.dart';
import 'package:student_online_market/pages/profile.dart';
import 'package:student_online_market/utils/reusable_widgets.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final bool showSimpleView;
  final String currentCategory;

  const MyHomePage({super.key, this.showSimpleView = true, this.currentCategory = 'all'});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _database = FirestoreDatabase();
  List<String> _collections = [];

  @override
  void initState() {
    super.initState();
    _getAllCollections();
  }

  Future<void> _getAllCollections() async {
    final collections = await _database.getAllCollections();
    setState(() {
      _collections = collections;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        title: "Online Market", 
        onSortPressed: (){}, 
        onProfilePressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserProfile()),
          );
        }, 
        onSearchPressed: (){}, 
        onCartPressed: (){}
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Stationary').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading'));
          }

          if(widget.showSimpleView){
            return Column(
              children: (snapshot.data?.docs ?? []).map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SimpleView(itemName: data['name'], itemPrice: data['price'], deal: data['deal'], description: data['desc'],),
                );
              }).toList() 
            );

          } else {
            return GridView.count(
              crossAxisCount: 2,
              children: (snapshot.data?.docs ?? []).map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CategoryView(categoryName: data['category'], description: data['desc'],),
                );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}

