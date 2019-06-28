import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_bakerclick/screens/product_list.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Variable and Constant
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString, uidString;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Method
  Widget passwordTextFromField() {
    return TextFormField(
      decoration: InputDecoration(
        errorStyle: TextStyle(fontWeight: FontWeight.bold),
        labelText: 'Password :',
        helperText: 'More 6 Charactor',
        labelStyle: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900]),
        helperStyle:
            TextStyle(color: Colors.blue[400], fontStyle: FontStyle.italic),
        icon: Icon(
          Icons.lock,
          size: 36.0,
          color: Colors.blue[900],
        ),
      ),
      validator: (String value) {
        if (value.length <= 5) {
          return 'Password Must More 5 Charactor';
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  Widget emailTextFromField() {
    return TextFormField(
      decoration: InputDecoration(
        errorStyle: TextStyle(fontWeight: FontWeight.bold),
        labelText: 'Email :',
        helperText: 'you@email.com',
        labelStyle: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.green[900]),
        helperStyle:
            TextStyle(color: Colors.green[400], fontStyle: FontStyle.italic),
        icon: Icon(
          Icons.email,
          color: Colors.green[900],
          size: 36.0,
        ),
      ),
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Email Format Only => you@email.com';
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget nameTextFromField() {
    return TextFormField(
      decoration: InputDecoration(
        errorStyle: TextStyle(fontWeight: FontWeight.bold),
        labelText: 'Name :',
        helperText: 'First Name Only',
        labelStyle: TextStyle(
            color: Colors.red[900],
            fontSize: 25.0,
            fontWeight: FontWeight.bold),
        helperStyle:
            TextStyle(color: Colors.red[400], fontStyle: FontStyle.italic),
        icon: Icon(
          Icons.face,
          color: Colors.red[900],
          size: 36.0,
        ),
      ),
      validator: (String value) {
        value = value.trim();
        if (value.length == 0) {
          return 'Please Fill Name in Blank';
        }
      },
      onSaved: (String value) {
        nameString = value;
      },
    );
  }

  Widget uploadButton() {
    return Container(
      margin: EdgeInsets.only(right: 80.0),
      child: IconButton(
        icon: Icon(
          Icons.cloud_upload,
          size: 36.0,
        ),
        onPressed: () {
          print('You Click upload');
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            uploadToFirebase();
          }
        },
      ),
    );
  }

  Future uploadToFirebase() async {
    print('Name = $nameString, Email = $emailString, Pass = $passwordString');

    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((objValue) {
      print('Register Success');
      findUidAndSetupDisplayName();
    }).catchError((objError) {
      String error = objError.message;
      print('error ==> $error');
      myShowDialog(error);
    });
  }

  Future findUidAndSetupDisplayName() async {
    // Find Uid
    FirebaseUser firebaseUser =
        await firebaseAuth.currentUser().then((objValue) {
      // Setup DisplayName
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nameString;
      objValue.updateProfile(userUpdateInfo);

      // Move To ProductList
      var productRoute =
          MaterialPageRoute(builder: (BuildContext context) => ProductList());
      Navigator.of(context)
          .pushAndRemoveUntil(productRoute, (Route<dynamic> route) => false);
    });
    uidString = firebaseUser.uid;
    print('uid ==> $uidString');
  }

  Widget alertButton(BuildContext context) {
    return FlatButton(
      child: Text('Close'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  void myShowDialog(String messageString) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Have Error'),
          content: Text(messageString),
          actions: <Widget>[alertButton(context)],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text('Register'),
        actions: <Widget>[uploadButton()],
      ),
      body: Form(
        key: formKey,
        child: Container(
          alignment: Alignment(0, -1),
          padding: EdgeInsets.only(top: 60.0, left: 50.0, right: 50.0),
          child: Column(
            children: <Widget>[
              nameTextFromField(),
              emailTextFromField(),
              passwordTextFromField()
            ],
          ),
        ),
      ),
    );
  }
}
