import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:futsol_mania_owner/utils/HexColor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:futsol_mania_owner/Pages/HomeScreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:futsol_mania_owner/utils/User_Defaults.dart';

class RegisterPlayerScreen extends StatefulWidget {
  @override
  _RegisterPlayerScreenState createState() => _RegisterPlayerScreenState();
}

class _RegisterPlayerScreenState extends State<RegisterPlayerScreen> {

  String selectedInterest;
  String selectedPosition;
  String age="";
  String email="";

  User_Defualts user_defaults = new User_Defualts();

  DatabaseReference users_db = FirebaseDatabase.instance.reference().child("users");
  DatabaseReference players_db = FirebaseDatabase.instance.reference().child("players");

  ProgressDialog progressDialog;

  List<String> _interest = <String>['Football'];
  List<String> _position = <String>['GoolKeeper',
    'Sweeper(SW)',
    'Center Back',
    'Left Full Back',
    'Right Full Back',
    'Defence Mid',
    'Left Wing Back',
    'Right Wing Back',
    'Center Mid Fielder',
    'Left Mid Fielder',
    'Right Mid Fielder',
    'Attack Mid Fielder',
    'Left Forward',
        'Center Forward',
        'Right Forward',
        'Striker'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedInterest = _interest.first;
    selectedPosition = _position.first;

  }

  //Register Player
  registerPlayer(BuildContext context) {

    progressDialog = ProgressDialog(context,type: ProgressDialogType.Normal);
    progressDialog.show();
    FirebaseAuth.instance.currentUser().then((user) {
      var data ={
        "role": "Player",
        "age": age,
        "position": selectedPosition,
        "interest": selectedInterest,
      };
      users_db.child(user.uid).update(data).whenComplete((){
        var data1 ={
          "user_id":user.uid,
          "role": "Player",
          "age": age,
          "position": selectedPosition,
          "interest": selectedInterest,
        };
        players_db.push().set(data1).whenComplete(()
        {
          progressDialog.hide();
          Fluttertoast.showToast(
              msg: "Successfully Become a Player.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1
          );
          Timer(Duration(seconds: 1), () => Navigator.push(context, new MaterialPageRoute(builder: (context) {
            return HomeScreen();
          })));
        });

      }).catchError((e)
      {
        progressDialog.hide();
        Fluttertoast.showToast(
            msg: "There is Some Error.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1
        );
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Become A Player",
              style: TextStyle(color: Colors.black, fontSize: 22.0)),
          backgroundColor: HexColor("FFFFFF"),
        ),
        body: Builder(
            builder: (context) => Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    new SingleChildScrollView(
                      child: Container(
                          margin: const EdgeInsets.only(
                              top: 10.0, left: 15.0, right: 15.0),
                          child: Column(
                            children: <Widget>[

                              Padding(padding: EdgeInsets.only(top: 17.0)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            new SizedBox(
                                              width: double.infinity,
                                              height: 50.0,
                                              child: new TextField(
                                                onChanged: (value) {
                                                  age = value;
                                                },
                                                keyboardType:
                                                    TextInputType.phone,
                                                decoration: new InputDecoration(
                                                    border:
                                                        new OutlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(
                                                              color: HexColor(
                                                                  "39B54A")),
                                                    ),
                                                    hintText: 'Age',
                                                    labelText: 'Age',
                                                    suffixStyle:
                                                        const TextStyle(
                                                            color:
                                                                Colors.green)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 17.0)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            new SizedBox(
                                              width: double.infinity,
                                              height: 50.0,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  border: Border.all(
                                                      color: Colors.black38,
                                                      style: BorderStyle.solid,
                                                      width: 0.80),
                                                ),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                  items: _interest
                                                      .map((value) =>
                                                          DropdownMenuItem(
                                                            child: Text(value),
                                                            value: value,
                                                          ))
                                                      .toList(),
                                                  onChanged: (String value) {
                                                    setState(() {
                                                      selectedInterest = value;
                                                    });
                                                  },
                                                  isExpanded: true,
                                                  value: selectedInterest,
                                                )),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 17.0)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            new SizedBox(
                                              width: double.infinity,
                                              height: 50.0,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  border: Border.all(
                                                      color: Colors.black38,
                                                      style: BorderStyle.solid,
                                                      width: 0.80),
                                                ),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                  items: _position
                                                      .map((value) =>
                                                          DropdownMenuItem(
                                                            child: Text(value),
                                                            value: value,
                                                          ))
                                                      .toList(),
                                                  onChanged: (String value) {
                                                    setState(() {
                                                      selectedPosition= value;
                                                    });
                                                  },
                                                  isExpanded: true,
                                                  value: selectedPosition,
                                                )),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),

                              Padding(padding: EdgeInsets.only(top: 25.0)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: <Widget>[
                                            new SizedBox(
                                              width: double.infinity,
                                              height: 40.0,
                                              child: new RaisedButton(
                                                child: Text("Submit",
                                                    style: TextStyle(
                                                        color:
                                                        HexColor("FFFFFF"),
                                                        fontSize: 14.0)),
                                                onPressed: () =>
                                                    registerPlayer(context),
                                                color: HexColor("39B54A"),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),

                            ],
                          )),
                    )
                  ],
                )));
  }
}
