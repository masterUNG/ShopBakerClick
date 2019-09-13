import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  // Explicit


  // Method
  @override
  void initState() { 
    super.initState();
    readFireStore();
  }

  

  Future<void> readFireStore() async{

    Firestore firestore = Firestore.instance;
    await firestore.collection('Shop').snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.documents;
      for (var snapshot in snapshots) {
        String nameDocument = snapshot.documentID;
        print('nameDocument = $nameDocument');
        String title = snapshot.data['Title'];
        print('title = $title');
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),body: Text('body'),
    );
  }
}
