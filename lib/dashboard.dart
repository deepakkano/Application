// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:subhash_app/firebase_options.dart';
import 'package:subhash_app/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> valueitem = ["High", "Low", "Medium"];
  int count=0; 
  String? selectedvalue1;
  String? selectedvalue2;
  String? selectedvalue3;
  String? Newvaluepen;
  String? Newvaluepencil;
  String? Newvaluebooks;
  void savedatapen() {
    if (selectedvalue1 != "") {
      Map<String, dynamic> vendorsdata = {
        "product1": selectedvalue1,
      };
      if(count==0){
      FirebaseFirestore.instance
          .collection("Vendors")
          
          .doc("vendor-pen")
          .set(vendorsdata);
          count=1;
    }else{
    FirebaseFirestore.instance
          .collection("Vendors")
          .doc("vendor-pen")
          .update(vendorsdata);
            
    }
  }}

  void savedatapencil() {
    if (selectedvalue2 != "") {
      Map<String, dynamic> vendorsdata = {
        "product2": selectedvalue2,
      };
      FirebaseFirestore.instance
          .collection("Vendors")
          .doc("vendor-penchil")
          .set(vendorsdata);
    }
  }

  void savedatabook() {
    if (selectedvalue3 != "") {
      Map<String, dynamic> vendorsdata = {
        "product3": selectedvalue3,
      };
      FirebaseFirestore.instance
          .collection("Vendors")
          .doc("vendor-book")
          .set(vendorsdata);
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    print("logout was click");
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  "Shubash Stationery",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Particulars",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Inventory",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Pen",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Container(
                          child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedvalue1,
                          hint: Text("Select type"),
                          items: valueitem
                              .map((e) => DropdownMenuItem<String>(
                                  value: e, child: Text(e)))
                              .toList(),
                          onChanged: (v) {
                            setState(() {
                              if (selectedvalue1 != Newvaluepen) {
                                selectedvalue1 = v;
                              } else {
                                selectedvalue1 == Newvaluepen;
                                selectedvalue1 = v;
                              }
                              Newvaluepen == selectedvalue1;
                              savedatapen();
                            });
                          },
                        ),
                      )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Pencil",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Container(
                          child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedvalue2,
                          hint: Text("Select type"),
                          items: valueitem
                              .map((e) => DropdownMenuItem<String>(
                                  value: e, child: Text(e)))
                              .toList(),
                          onChanged: (v) {
                            setState(() {
                              if (selectedvalue2 != Newvaluepencil) {
                                selectedvalue2 = v;
                              } else {
                                selectedvalue2 == Newvaluepencil;
                                selectedvalue2 = v;
                              }
                              Newvaluepencil == selectedvalue2;
                              savedatapencil();
                            });
                          },
                        ),
                      )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Books",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Container(
                          child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedvalue3,
                          hint: Text("Select type"),
                          items: valueitem
                              .map((e) => DropdownMenuItem<String>(
                                  value: e, child: Text(e)))
                              .toList(),
                          onChanged: (v) {
                            setState(() {
                              if (selectedvalue3 != Newvaluebooks) {
                                selectedvalue3 = v;
                              } else {
                                selectedvalue1 == Newvaluebooks;
                                selectedvalue3 = v;
                              }
                              Newvaluebooks == selectedvalue3;
                              savedatabook();
                            });
                          },
                        ),
                      )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      logout();
                    },
                    child: Text("Logout")),
              )
            ],
          ),
        ));
  }
}
