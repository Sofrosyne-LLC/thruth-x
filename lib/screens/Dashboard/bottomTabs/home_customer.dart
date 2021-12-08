import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truthinx/Services/NotificationServices.dart';
import 'package:truthinx/Services/ProfileServices.dart';

import 'package:truthinx/Models/AppUser.dart';
import 'package:truthinx/screens/Dashboard/bottomTabs/Drawer.dart';
import 'package:truthinx/screens/Dashboard/bottomTabs/ModelDrawer.dart';
import 'package:truthinx/screens/Dashboard/search.dart';
import 'package:truthinx/screens/Widgets/Model_Grid_Item.dart';
import 'package:truthinx/utils/constants.dart';

class HomeScreenCustomer extends StatefulWidget {
  HomeScreenCustomer({Key key}) : super(key: key);

  @override
  _HomeScreenCustomerState createState() => _HomeScreenCustomerState();
}

const double width = 330.0;
const double height = 35.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.grey;
CollectionReference collectionReferenceUser =
    FirebaseFirestore.instance.collection('user');

class _HomeScreenCustomerState extends State<HomeScreenCustomer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double rateSlider = 25;
  double heightFilter = 124.1;
  bool heightAny = true;
  bool rateAny = true;
  bool weightAny = true;
  double dress = 0;
  double bust = 20;
  double waist = 20;
  double hips = 22;
  double neck = 13;
  double jacket = 0;
  double inseam = 20;
  double shoe = 5;
  double weight = 100;
  List<String> cupList = ["A", "B", "C", "D", "DD+"];
  String cup = '';
  List<String> selectedModeling = [];
  List<String> selectedPhysicalAttribs = [];
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<bool> _saveTokenToDatabase() async {
    String uid = FirebaseAuth.instance.currentUser.uid;
    String fcmToken = await _fcm.getToken();

    if (fcmToken != null) {
      var tokenRef =
          FirebaseFirestore.instance.collection("notifications").doc(uid);

      await tokenRef.update(
        {"fcmToken": fcmToken, "createdAt": FieldValue.serverTimestamp()},
      );
    }
    return Future.value(true);
  }

  ProfileServices profileData = ProfileServices();
  AppUser user;

  @override
  void initState() {
    super.initState();
    //  profileData.getLocalUser().then((value) {
    //   setState(() {
    //     user = value;
    //     print(user.instagram);
    //   });
    // });
    _saveTokenToDatabase();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }

  bool isClient = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.black12,
          centerTitle: true,
          title: Text(
            'Models',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, size: 30),
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) {
                      return Search(isClient: isClient);
                    },
                  ),
                );
              },
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  isDismissible: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        height: height / 2,
                        width: width,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(34, 39, 46, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Filters",
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                  SizedBox(
                                    height: 6.0,
                                  ),
                                  SizedBox(
                                    height: 1,
                                    child: Divider(),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text("City : "),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      Text("Rate : "),
                                      Text(
                                          '${rateAny ? "Any" : "\$$rateSlider"}')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width / 2.2,
                                        child: Slider(
                                          value: rateSlider,
                                          label: '\$$rateSlider',
                                          min: 25,
                                          max: 500,
                                          divisions: 25,
                                          onChanged: (value) {
                                            setState(() {
                                              rateAny = false;
                                              rateSlider = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Checkbox(
                                            activeColor: Colors.blue,
                                            value: rateAny,
                                            onChanged: (value) {
                                              setState(() {
                                                print(value);
                                                rateAny = !rateAny;
                                              });
                                            },
                                          ),
                                          Text("Any")
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      Text("Height : "),
                                      Text(
                                        heightAny
                                            ? "Any"
                                            : "${(heightFilter / 30).toStringAsFixed(2).split(".")[0]}\'${(heightFilter / 30).toStringAsFixed(2).split(".")[1]}\''",
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width / 2.2,
                                        child: Slider(
                                          value: heightFilter,
                                          label:
                                              "${(heightFilter / 30).toStringAsFixed(2).split(".")[0]}\'${(heightFilter / 30).toStringAsFixed(2).split(".")[1]}\''",
                                          min: 123.3,
                                          max: 183.3,
                                          onChanged: (value) {
                                            setState(() {
                                              heightAny = false;
                                              heightFilter = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            activeColor: Colors.blue,
                                            value: heightAny,
                                            onChanged: (value) {
                                              setState(() {
                                                heightAny = !heightAny;
                                              });
                                            },
                                          ),
                                          Text("Any")
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      Text("Weight : "),
                                      Text(
                                        weightAny
                                            ? "Any"
                                            : "${weight.toStringAsFixed(1)}lbs",
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width / 2.2,
                                        child: Slider(
                                          value: weight,
                                          label:
                                              "${weight.toStringAsFixed(1)}lbs",
                                          min: 100,
                                          max: 280,
                                          onChanged: (value) {
                                            setState(() {
                                              weightAny = false;
                                              weight = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            activeColor: Colors.blue,
                                            value: weightAny,
                                            onChanged: (value) {
                                              setState(() {
                                                weightAny = !weightAny;
                                              });
                                            },
                                          ),
                                          Text("Any")
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Measurement",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  "Cup",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    border: Border.all(
                                                        color:
                                                            Colors.grey[400])),
                                                child: DropdownSearch<String>(
                                                  showSearchBox: true,
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    // hintText: null,
                                                    // labelText: "Whar is Your Indusry?",
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                      left: 10,
                                                    ),
                                                    border: InputBorder.none,
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .never,
                                                  ),
                                                  searchBoxDecoration:
                                                      InputDecoration(
                                                    hintText: "Search Course",
                                                  ),
                                                  mode: Mode.DIALOG,
                                                  // showSelectedItem: true,
                                                  items: cupList,
                                                  // label: "Indusry",
                                                  itemAsString: (item) => item,
                                                  hint: "Choose Cup Type",
                                                  // popupItemDisabled: (String s) => s.startsWith('I'),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      cup = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Text("Dress : "),
                                            Text("${dress.toStringAsFixed(1)}"),
                                          ],
                                        ),
                                        Slider(
                                          value: dress,
                                          label: "${dress.toStringAsFixed(1)}",
                                          min: 0,
                                          max: 32,
                                          onChanged: (value) {
                                            setState(() {
                                              dress = value;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Text("Bust : "),
                                            Text("${bust.toStringAsFixed(1)}"),
                                          ],
                                        ),
                                        Slider(
                                          value: bust,
                                          label: "${bust.toStringAsFixed(1)}",
                                          min: 20,
                                          max: 60,
                                          onChanged: (value) {
                                            setState(() {
                                              bust = value;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Text("Waist : "),
                                            Text("${waist.toStringAsFixed(1)}"),
                                          ],
                                        ),
                                        Slider(
                                          value: waist,
                                          label: "${waist.toStringAsFixed(1)}",
                                          min: 20,
                                          max: 50,
                                          onChanged: (value) {
                                            setState(() {
                                              waist = value;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Text("Neck : "),
                                            Text("${neck.toStringAsFixed(1)}"),
                                          ],
                                        ),
                                        Slider(
                                          value: neck,
                                          label: "${neck.toStringAsFixed(1)}",
                                          min: 13,
                                          max: 22,
                                          onChanged: (value) {
                                            setState(() {
                                              neck = value;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Text("Jacket : "),
                                            Text(
                                                "${jacket.toStringAsFixed(1)}"),
                                          ],
                                        ),
                                        Slider(
                                          value: jacket,
                                          label: "${jacket.toStringAsFixed(1)}",
                                          min: 0,
                                          max: 50,
                                          onChanged: (value) {
                                            setState(() {
                                              jacket = value;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Text("Inseam : "),
                                            Text(
                                                "${inseam.toStringAsFixed(1)}"),
                                          ],
                                        ),
                                        Slider(
                                          value: inseam,
                                          label: "${inseam.toStringAsFixed(1)}",
                                          min: 20,
                                          max: 60,
                                          onChanged: (value) {
                                            setState(() {
                                              inseam = value;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Text("Shoe : "),
                                            Text("${shoe.toStringAsFixed(0)}"),
                                          ],
                                        ),
                                        Slider(
                                          value: shoe,
                                          label: "${shoe.toStringAsFixed(0)}",
                                          min: 5,
                                          max: 20,
                                          onChanged: (value) {
                                            setState(() {
                                              shoe = value;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Modeling",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: Colors.grey[400])),
                                    child: DropdownSearch<String>(
                                      showSearchBox: true,
                                      dropdownSearchDecoration: InputDecoration(
                                        // hintText: null,
                                        // labelText: "Whar is Your Indusry?",
                                        contentPadding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        border: InputBorder.none,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                      ),
                                      searchBoxDecoration: InputDecoration(
                                        hintText: "Search Course",
                                      ),
                                      mode: Mode.DIALOG,
                                      // showSelectedItem: true,
                                      items: Constants.modeling,
                                      // label: "Indusry",
                                      itemAsString: (item) => item,
                                      hint: "Choose Modeling Type",
                                      // popupItemDisabled: (String s) => s.startsWith('I'),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedModeling.add(value);
                                        });
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: selectedModeling.length > 0
                                        ? true
                                        : false,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Container(
                                        width: width,
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          children: List.generate(
                                            selectedModeling.length,
                                            (index) => GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedModeling.remove(
                                                      selectedModeling[index]);
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.0,
                                                    vertical: 5.0),
                                                margin: EdgeInsets.all(3.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                ),
                                                child: Text(
                                                  "${selectedModeling[index]}",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Physical Attributes",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: Colors.grey[400])),
                                    child: DropdownSearch<String>(
                                      showSearchBox: true,
                                      dropdownSearchDecoration: InputDecoration(
                                        // hintText: null,
                                        // labelText: "Whar is Your Indusry?",
                                        contentPadding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        border: InputBorder.none,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                      ),
                                      searchBoxDecoration: InputDecoration(
                                        hintText: "Search Course",
                                      ),
                                      mode: Mode.DIALOG,
                                      // showSelectedItem: true,
                                      items: Constants.physicalAttribs,
                                      // label: "Indusry",
                                      itemAsString: (item) => item,
                                      hint: "Choose Physical Attributes",
                                      // popupItemDisabled: (String s) => s.startsWith('I'),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedPhysicalAttribs.add(value);
                                        });
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: selectedPhysicalAttribs.length > 0
                                        ? true
                                        : false,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Container(
                                        width: width,
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          children: List.generate(
                                            selectedPhysicalAttribs.length,
                                            (index) => GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedPhysicalAttribs
                                                      .remove(
                                                    selectedPhysicalAttribs[
                                                        index],
                                                  );
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.0,
                                                    vertical: 5.0),
                                                margin: EdgeInsets.all(3.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                ),
                                                child: Text(
                                                  "${selectedPhysicalAttribs[index]}",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.filter_alt_rounded,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        drawer: FutureBuilder(
            future: profileData.getLocalUser(),
            builder: (context, AsyncSnapshot<AppUser> snap) {
              if (snap.hasData) {
                isClient = snap.data.role == "Client";
                if (snap.data.role == "Client") {
                  return TruthinXDrawer();
                } else {
                  return ModelDrawer();
                }
              } else {
                return Container();
              }
            }),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: collectionReferenceUser
                    // .where("verification", isEqualTo: 'submitted')
                    .where("role", isEqualTo: 'Model')
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          physics: ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 1.4),
                          ),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot data = snapshot.data.docs[index];
                            return GridProduct(
                              // img: data['profile_pic'],
                              isVerified: data['verification'] == "VERIFIED",
                              name: data['first_name'],
                              rating: 5.0,
                              raters: 23,
                              gender: data["gender"],
                              img: data["dp"],
                              details: data,
                              isClient: isClient,
                            );
                          },
                        );
                },
              ),
            ),
//             Expanded(
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 primary: false,
//                 physics: ScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: MediaQuery.of(context).size.width /
//                       (MediaQuery.of(context).size.height / 1.4),
//                 ),
//                 itemCount: foods == null ? 0 : foods.length,
//                 itemBuilder: (BuildContext context, int index) {
// //                Food food = Food.fromJson(foods[index]);
//                   Map food = foods[index];
// //                print(foods);
// //                print(foods.length);
//                   return GridProduct(
//                     img: food['img'],
//                     isFav: false,
//                     name: food['name'],
//                     rating: 5.0,
//                     raters: 23,
//                   );
//                 },
//               ),
//             ),
          ],
        ));
  }
}
