import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_bakerclick/models/promotion_model.dart';

class Marketplate extends StatefulWidget {
  @override
  _MarketplateState createState() => _MarketplateState();
}

class _MarketplateState extends State<Marketplate> {
  // Explicit
  double myH1 = 24.0;
  double myH2 = 18.0;
  double mySpace = 16.0;
  Color myColorText = Colors.blue[900];
  List<PromotionModel> promotionModels = [];

  // Method
  @override
  void initState() {
    super.initState();
    readPromotion();
  }

  Future<void> readPromotion() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Promotion');
    StreamSubscription<QuerySnapshot> subscription =
        await collectionReference.snapshots().listen((querySanpshot) {
      List<DocumentSnapshot> documentSnapshots = querySanpshot.documents;

      for (var snapshot in documentSnapshots) {
        String namePromotion = snapshot.data['NamePromotion'];
        String urlImage = snapshot.data['PathImage'];
        print('name = $namePromotion');

        PromotionModel promotionModel = PromotionModel(namePromotion, urlImage);
        setState(() {
          promotionModels.add(promotionModel);
        });
      }
    });
  }

  Widget titleBanner() {
    return Container(
      padding: EdgeInsets.only(
        left: mySpace,
        top: mySpace,
        bottom: mySpace,
      ),
      alignment: Alignment.topLeft,
      child: Text(
        'What News ?',
        style: TextStyle(
          fontSize: myH1,
          color: myColorText,
        ),
      ),
    );
  }



  Widget imageBanner() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 200.0,
      child: ListView.builder(scrollDirection: Axis.horizontal,
        itemCount: promotionModels.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(promotionModels[index].pathImage);
        },
      ),
    );
  }

  Widget showBanner() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        titleBanner(),
        imageBanner(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        showBanner(),
      ],
    );
  }
}
