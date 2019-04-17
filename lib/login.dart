import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loan_app/Constant.dart';
import 'package:loan_app/ProgessBar.dart';
import 'package:loan_app/apiutil.dart';
import 'package:loan_app/dashboard.dart';
import 'package:loan_app/httphelper.dart';
import 'package:loan_app/signup.dart';
import 'package:loan_app/util.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class LoginState extends State<Login> {
  final TextEditingController userController = new TextEditingController();
  final TextEditingController otpController = new TextEditingController();
  bool isLoadingVisible = false;

  @override
  void initState() {
    updateUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      inAsyncCall: isLoadingVisible,
      opacity: 0.0,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: ListView(
            children: <Widget>[
              new Image.asset(
                "assets/" + "logo" + ".jpg",
                width: 200.0,
                height: 200.0,
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: userController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Email Id/Phone Number',
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.blue,
                        )),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0),
                    ),
                    TextField(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: InputDecoration(
                        hintText: 'OTP',
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.blue,
                        )),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0),
                    ),
                    RaisedButton(
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.1)),
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () {
                          if (performValidations()) {
                            setState(() {
                              isLoadingVisible = true;
                            });

                            Util.saveSharedPreferenceInString(
                                "UserName", userController.text.toString());
                            APIUtil util = APIUtil.getApiUtil();
                            HttpHelper.getHttpHelper()
                                .performPostRequestWithEncodedFormat(
                                    Constant.VERIFY_OTP,
                                    util.verifyOtpRequestBody(
                                        userController.text,
                                        otpController.text))
                                .then((response) {
                              if (response != null) {
                                Response otpResponse = response;
                                var verifyOtpResponse =
                                    json.decode(otpResponse.body);
                                if (verifyOtpResponse['Status'] != 'Fail') {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Dashboard()));
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Dashboard()));
                                  showInSnackBarBlack(
                                      _scaffoldKey, verifyOtpResponse["msg"]);
                                }
                              } else {
                                //TODO Need to change
                                /* Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Dashboard()));*/
                              }

                              setState(() {
                                isLoadingVisible = false;
                              });
                            });
                          }
                        }),
                    RaisedButton(
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.1)),
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        }),
                  ],
                ),
              )
            ],
          )),
    );
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
    if (userController.text.toString().length < 1) {
      showInSnackBarBlack(_scaffoldKey, "Please Enter Email ID/Phone Number");
      return false;
    } else if (!_isNumeric(userController.text.toString()) &&
        !_isEmail(userController.text.toString())) {
      showInSnackBarBlack(_scaffoldKey, "Please Enter Valid Email ID");
      return false;
    } else if (_isNumeric(userController.text.toString()) &&
        userController.text.length != 10) {
      showInSnackBarBlack(_scaffoldKey, "Please Enter Valid Mobile Id");
      return false;
    } else if (otpController.text.length < 4) {
      showInSnackBarBlack(_scaffoldKey, "OTP Should be 4 characters length");
      return false;
    }
    /*else if (!(otpController.text.toString() == '1234')) {
      showInSnackBarBlack(_scaffoldKey, "Please Enter Valid OTP");
      return false;
    }*/
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

  void updateUserName() async {
    userController.text = await Util.getMobileNumber();
  }
}
