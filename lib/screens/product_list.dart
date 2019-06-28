import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  // Explicit

  // Method
  Widget signOutButton() {
    return Container(
      margin: EdgeInsets.only(right: 80.0),
      child: IconButton(tooltip: 'Sign Out',
        icon: Icon(Icons.exit_to_app),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: <Widget>[signOutButton()],
      ),
      body: Text('body'),
    );
  }
}
