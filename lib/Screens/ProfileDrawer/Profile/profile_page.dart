import 'dart:async';

import 'package:WE/Resources/components/or_divider.dart';
import 'package:WE/Resources/components/pop_up.dart';
import 'package:WE/Screens/ProfileDrawer/Badges/badges_page.dart';
import 'package:WE/Screens/ProfileDrawer/Profile/edit_profile.dart';
import 'package:WE/Services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:WE/Resources/constants.dart';
import 'package:WE/Resources/SizeConfig.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var firebaseUser = FirebaseAuth.instance.currentUser;

  final Map<int, int> expTable = {
    1: 50,
    2: 150,
    3: 300,
    4: 500,
    5: 750,
    6: 1050,
    7: 1400,
    8: 1800,
    9: 2250,
    10: 2750,
    11: 3300,
    12: 3900,
    13: 4550,
    14: 5250,
    15: 6000,
    16: 6800,
    17: 7650,
    18: 8550,
    19: 9500,
    20: 10500,
    21: 11550,
    22: 12650,
    23: 13800,
    24: 15000,
  };

  @override
  void initState() {
    super.initState();
    calculateLevel(firebaseUser.uid);

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(firebaseUser.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot?.data.data() ?? {};

            return Scaffold(
              backgroundColor: Color(0xFFF8F8F8),
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditProfile();
                            },
                          ),
                        );
                        //getImage(true);
                      },
                      icon: Icon(Icons.settings))
                ],
                centerTitle: true,
                title: Text(
                  "Profil Sayfası",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              body: Column(
                children: <Widget>[
                  Container(
                    color: Color(0xFFF8F8F8),
                    width: MediaQuery.of(context).size.width,
                    height: 260,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              data["avatar"] != null
                                  ? Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(data["avatar"] == null
                                                  ? "assets/Icons/account.png"
                                                  : data["avatar"]),
                                        )),
                                    )
                                  : Icon(
                                      Icons.account_circle_rounded,
                                      size: 120,
                                      color: Colors.grey,
                                    ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      data["name"] ?? '',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/Icons/supermanicon.png",
                                          scale: 0.2,
                                          color: Colors.black,
                                          height: 30,
                                          width: 30,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          data["superhero"] ?? '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),

                                      ],
                                    ),


                                  ],
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    data["coins"].toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "WE coin",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    data["recycled"].toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Geri dönüştürülen",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          EditProfile(),
                                    ),

                                  );
                                  //getImage(true);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black54),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "PROFİLİ DÜZENLE",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if(data["exp"] != null)
                  Align(
                    alignment: Alignment(0.5, 0.5),
                    child: Container(
                        color: Color(0xFFF8F8F8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        height: size.height * 0.3,
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Container(
                                    margin: EdgeInsets.only(right: 11),
                                    child: SizedBox(
                                        height: 190,
                                        width: 190,
                                        child: LiquidCircularProgressIndicator(
                                          value: data["exp"],
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.lightBlue[200]),
                                          backgroundColor: Colors.white,
                                          borderColor: kPrimaryColor,
                                          borderWidth: 10.0,
                                          direction: Axis.vertical,
                                          center: Text(
                                              "Seviye ${data['level'].toString()} "), //text inside it
                                        ))),

                                Expanded(
                                  child: Container(
                                    child: IconButton(
                                        iconSize: MediaQuery.of(context).size.width * 0.125,
                                        onPressed: () {
                                          popUp(
                                            context,
                                            (data["recycled"] * 5.774)
                                                .toStringAsFixed(0)
                                                .length ==
                                                4
                                                ? ((data["recycled"] * 5.774) / 1000)
                                                .toStringAsFixed(2) +
                                                " kWh elektrik tasarrufu yaptın."
                                                : (data["recycled"] * 5.774)
                                                .toStringAsFixed(2) +
                                                " Wh elektrik tasarrufu yaptın.",
                                            true,
                                          );
                                        },
                                        icon: Image.asset("assets/question-mark.png")),
                                  ),
                                )

                              ],
                            ),
                          ],
                        )),
                  ),
                  OrDivider(text: "Rozetler"),
                  if(data['badges'] != null)
                  SizedBox(
                    height: size.height * 0.1,
                    child: InkWell(
                      onTap: ()=> Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BadgePage();
                          },
                        ),
                      ),
                      child: ListView(
                        itemExtent: 100,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[

                          Image.asset(
                            data["badges"]["badge1"]
                                ? allBadges[0][0]
                                : allBadges[0][1],
                          ),
                          Image.asset(
                            data["badges"]["badge2"]
                                ? allBadges[1][0]
                                : allBadges[1][1],
                            scale: 8,
                          ),
                          Image.asset(
                            data["badges"]["badge3"]
                                ? allBadges[2][0]
                                : allBadges[2][1],
                            scale: 8,
                          ),
                          Image.asset(
                            data["forbadgecount"] >= 3
                                ? allBadges[3][0]
                                : allBadges[3][1],
                            scale: 8,
                          ),
                          Image.asset(
                            data["recycled"] >= 800
                                ? allBadges[4][0]
                                : allBadges[4][1],
                            scale: 8,
                          ),
                          Image.asset(
                            data["badges"]["badge6"]
                                ? allBadges[5][0]
                                : allBadges[5][1],
                            scale: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

List<List<String>> allBadges = [
  [
    "assets/Images/Badges/Unlocked/activeBadge1.png",
    "assets/Images/Badges/Locked/inactiveBadge1.png"
  ],
  [
    "assets/Images/Badges/Unlocked/activeBadge2.png",
    "assets/Images/Badges/Locked/inactiveBadge2.png"
  ],
  [
    "assets/Images/Badges/Unlocked/activeBadge3.png",
    "assets/Images/Badges/Locked/inactiveBadge3.png"
  ],
  [
    "assets/Images/Badges/Unlocked/activeBadge4.png",
    "assets/Images/Badges/Locked/inactiveBadge4.png"
  ],
  [
    "assets/Images/Badges/Unlocked/activeBadge5.png",
    "assets/Images/Badges/Locked/inactiveBadge5.png"
  ],
  [
    "assets/Images/Badges/Unlocked/activeBadge6.png",
    "assets/Images/Badges/Locked/inactiveBadge6.png"
  ],
];
