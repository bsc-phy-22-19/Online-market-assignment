import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addItemToCollection(String collectionName, String itemName, double price, String deal, String desc, File itemPicture) async {
    DateTime dateTime = DateTime.now();

    final ref = _storage.ref().child('images/${itemName}_${dateTime.toString()}.jpg');
    await ref.putFile(itemPicture);
    final itemPictureUrl = await ref.getDownloadURL();
  
    await _firestore.collection(collectionName).add({
      'category': collectionName,
      'name': itemName,
      'deal': deal,
      'desc': desc,
      'price': price,
      'picture': itemPictureUrl,
    });
  }

  Future<List> getData() async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('Stationary');
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    List allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<List<String>> getAllCollections() async {
    final collections = await _firestore.collectionGroup('').get();



    return collections.docs.map((doc) => doc.reference.path).toList();
  }
}






class FirestoreCart {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collectionName = 'cart';

  Future<void> createItem(String itemName, String userId, double price) async {
    await _db.collection(_collectionName).doc(itemName).set({
      'userId': userId,
      'itemName': itemName,
      'price': price,
      'itemsSelected': 1,
    });
  }

  Stream<QuerySnapshot<Object?>> readItems(String userId) {
  return _db
      .collection(_collectionName)
      .where('userId', isEqualTo: userId)
      .snapshots();
  }



//   Stream<List<Map<String, dynamic>>> readItems(String userId) {
//   return _db
//       .collection(_collectionName)
//       .where('userId', isEqualTo: userId)
//       .snapshots()
//       .map((snapshot) => snapshot.docs
//           .map((doc) => {
//                 'itemName': doc.data()['itemName'].toString(),
//                 'price': doc.data()['price'].toString(),
//                 'itemsSelected': doc.data()['itemsSelected'].toString(),
//               })
//           .toList());
// }


  Future<void> updateItem(String itemName, String userId) async {
    await _db.collection(_collectionName).doc(itemName).update({
      'userId': userId,
      'itemName': itemName,
    });
  }

  Future<void> deleteItem(String itemName) async {
    await _db.collection(_collectionName).doc(itemName).delete();
  }
}



















// class _AllCollectionsScreenState extends State<AllCollectionsScreen> {
//   final _database = FirestoreDatabase();
//   List<String> _collections = [];

//   @override
//   void initState() {
//     super.initState();
//     _getAllCollections();
//   }

//   Future<void> _getAllCollections() async {
//     final collections = await _database.getAllCollections();
//     setState(() {
//       _collections = collections;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Collections'),
//       ),
//       body: ListView.builder(
//         itemCount: _collections.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(_collections[index]),
//           );
//         },
//       ),
//     );
//   }
// }




// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreDatabase {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   Future<void> addItemToCollection(
//       String collectionName, String itemName, File itemPicture) async {
//     final ref = _storage.ref().child('images/$itemName.jpg');
//     await ref.putFile(itemPicture);
//     final itemPictureUrl = await ref.getDownloadURL();
//     await _firestore.collection(collectionName).add({
//       'name': itemName,
//       'picture': itemPictureUrl,
//     });
//   }
// }
