import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loan_app/Constant.dart';
import 'package:loan_app/LoanDetails.dart';
import 'package:loan_app/apiutil.dart';
import 'package:loan_app/bankdetails.dart';
import 'package:loan_app/httphelper.dart';
import 'package:loan_app/login.dart';
import 'package:loan_app/util.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class DashboardState extends State<Dashboard> {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();

  String userName = '';
  String mobile = '';
  String emailId = '';

  @override
  Widget build(BuildContext context) {
    return /*WillPopScope(
        onWillPop: () {
          _asyncConfirmDialog(context);
        },
        child:*/
        Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text('Dashboard'),
            ),
            drawer: new Drawer(
                child: new ListView(
              children: <Widget>[
                new DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: new Image.asset(
                        "assets/" + "logo" + ".jpg",
                        width: 200.0,
                        height: 200.0,
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          Text(
                            mobile,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          Text(
                            emailId,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                new ListTile(
                  title: new Text('Bank Details'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BankDetails()));
                  },
                ),
                new Divider(
                  color: Colors.blue,
                ),
                new ListTile(
                  title: new Text('About Us'),
                  onTap: () {},
                ),
                new Divider(
                  color: Colors.blue,
                ),
                new ListTile(
                  title: new Text('Logout'),
                  onTap: () async {
                    APIUtil util = APIUtil.getApiUtil();
                    HttpHelper.getHttpHelper()
                        .performPostRequest(
                            Constant.LOGOUT,
                            util.sendOtpRequestBody(
                              await Util.getMobileNumber(),
                            ))
                        .then((response) {
                      Response logoutResponse = response;
                      var responseData = json.decode(logoutResponse.body);
                      if (responseData != null && responseData['status'] == 1) {
                        /*Util.saveSharedPreferenceInString("MobileNumber", null);*/
                        showInSnackBarBlack(_scaffoldKey, responseData['msg']);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        showInSnackBarBlack(_scaffoldKey,
                            "Something went wrong! Please try again");
                      }
                    });
                  },
                ),
                new Divider(
                  color: Colors.blue,
                ),
              ],
            )),
            body: ListView(children: <Widget>[
              Image.asset(
                "assets/" + "getloan" + ".jpg",
                width: 200.0,
                height: 200.0,
              ),
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: RaisedButton(
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.1)),
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text(
                        'GetLoan',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoanDetails()));
                      }))
            ]));
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  getUserDetails() async {
    String loginUserName = await Util.getUserName();
    String mobile = await Util.getMobileNumber();
    String emailId = await Util.getEmailId();
    setState(() {
      userName = loginUserName;
      this.emailId = emailId;
      this.mobile = mobile;
      print(mobile);
    });
  }

  /*
    This method used to display snackbar
   */
  void showInSnackBarBlack(
      GlobalKey<ScaffoldState> scaffoldKey, String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(
          seconds: 2,
        ),
        backgroundColor: Colors.blue,
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )));
  }

  bool performValidations() {
    if (nameController.text.toString().length < 3) {
      showInSnackBarBlack(_scaffoldKey, "Name must have 3 characters long");
      return false;
    } else if (mobileController.text.length < 1 &&
        mobileController.text.length != 10) {
      showInSnackBarBlack(_scaffoldKey, "Please Enter Valid Mobile Id");
      return false;
    } else if (emailController.text.length < 1) {
      showInSnackBarBlack(_scaffoldKey, "Please Enter Mail Id");
      return false;
    } else if (!_isEmail(emailController.text.toString())) {
      showInSnackBarBlack(_scaffoldKey, "Please Enter Valid Email ID");
      return false;
    }
    return true;
  }

  bool _isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  bool _isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext mainContext) async {
    return showDialog<ConfirmAction>(
      context: mainContext,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exit!'),
          content: const Text('Are you want to exit?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/LoginScreen');
              },
            )
          ],
        );
      },
    );
  }
}
