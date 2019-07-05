import 'package:flutter/material.dart';
import 'package:shop_bakerclick/screens/product_list.dart';
import 'package:shop_bakerclick/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auten extends StatefulWidget {
  @override
  _AutenState createState() => _AutenState();
}

class _AutenState extends State<Auten> {
// Create Field
  String appName = 'Bakerclick Shop';
  final formKey = GlobalKey<FormState>();
  String emailString, passwordString;

// Method
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future checkStatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      moveToProduct();
    }
  }

  void moveToProduct() {
    var productRoute =
        MaterialPageRoute(builder: (BuildContext context) => ProductList());
    Navigator.of(context)
        .pushAndRemoveUntil(productRoute, (Route<dynamic> route) => false);
  }

  Widget showLogo() {
    return Image.asset('images/logo.png');
  }

  Widget showAppName() {
    return Text(
      appName,
      style: TextStyle(
          fontFamily: 'Playball',
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue[900]),
    );
  }

  Widget userTextFromField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Your User :',
        hintText: 'User not Blank',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Email in Blank';
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget passwordFromField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Your Password',
        hintText: 'More 6 charactor',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Password';
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  Widget signIn() {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: Colors.blue[900],
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        print('Click SignIn');
        checkSpace();
      },
    );
  }

  void checkSpace() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print('email = $emailString, password = $passwordString');
    }
  }

  Widget signUp(BuildContext context) {
    return OutlineButton(
      borderSide: BorderSide(color: Colors.blue[900]),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text(
        'Sign Up',
        style: TextStyle(color: Colors.blue[900]),
      ),
      onPressed: () {
        print('You Click SignUp');

        // Create Route
        var registerRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(registerRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.only(top: 120.0),
        color: Colors.yellow,
        alignment: Alignment(0, -1),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints.expand(width: 200.0, height: 200.0),
                child: showLogo(),
              ),
              Container(
                child: showAppName(),
              ),
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0),
                child: userTextFromField(),
              ),
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0),
                child: passwordFromField(),
              ),
              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 2.5),
                        child: signIn(),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 2.5),
                        child: signUp(context),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
