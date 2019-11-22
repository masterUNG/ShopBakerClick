import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shop_bakerclick/screens/marketplate.dart';
import 'package:shop_bakerclick/utility/my_style.dart';
import 'package:shop_bakerclick/widget/information.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String nameLogin = '';
  double mySizeIcon = 36.0;
  double myH1 = 24.0;
  double myH2 = 18.0;
  Widget myWidget = Marketplate();
  String titleAppBar = 'Marketplate';


  // Method

  @override
  void initState() {
    super.initState();
    findNameLogin();
  }

  Widget myDivider() {
    return Divider();
  }

  Future<void> findNameLogin() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      nameLogin = firebaseUser.displayName;
    });
    print('name = $nameLogin');
  }

  Widget titleSignOut() {
    return ListTile(
      leading: Icon(
        Icons.exit_to_app,
        size: mySizeIcon,
        color: Colors.blue,
      ),
      title: Text(
        'Sign Out & Exit',
        style: TextStyle(
          fontSize: myH2,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Backer Supply',
      style: TextStyle(
          color: Colors.red[700], fontSize: 24.0, fontFamily: 'Playball'),
    );
  }

  Widget showLogBy() {
    return Text('Login by $nameLogin');
  }

  Widget headMyDrawer() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, Colors.yellow[700]],
          radius: 1.2,
          center: Alignment.center,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            showLogo(),
            showAppName(),
            showLogBy(),
          ],
        ),
      ),
    );
  }

  Widget myDrawerMenu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          headMyDrawer(),
          showHomeMenu(),
          myDivider(),
          showInfoMenu(),
          myDivider(),
          titleSignOut(),
          myDivider(),
        ],
      ),
    );
  }

  Widget signOutButton() {
    return Container(
      // margin: EdgeInsets.only(right: 80.0),
      child: IconButton(
        tooltip: 'Sign Out',
        icon: Icon(Icons.exit_to_app),
        onPressed: () {
          print('You Click SignOut');
          mySignOut();
        },
      ),
    );
  }

  Future<void> mySignOut() async {
    await firebaseAuth.signOut().then((response) {
      exit(0);
    });
  }

  Widget showHomeMenu() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: mySizeIcon,
        color: Color.fromARGB(255, 140, 0, 50),
      ),
      title: Text(
        'Marketplate',
        style:
            TextStyle(fontSize: myH2, color: Color.fromARGB(255, 140, 0, 50)),
      ),onTap: (){
        setState(() {
          myWidget = Marketplate();
          titleAppBar = 'Marketplate';
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget showInfoMenu() {
    return ListTile(
      leading: Icon(
        Icons.info,
        size: mySizeIcon,
        color: Colors.green,
      ),
      title: Text(
        'Information',
        style: TextStyle(
          fontSize: myH2,
          color: Colors.green,
        ),
      ),onTap: (){
        setState(() {
          myWidget = Information();
          titleAppBar = 'Information';
        });
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyStyle().mainColor,
        title: Text(titleAppBar),
        actions: <Widget>[signOutButton()],
      ),
      body: myWidget,
      drawer: myDrawerMenu(),
    );
  }
}
