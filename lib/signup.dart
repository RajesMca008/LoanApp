import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loan_app/Constant.dart';
import 'package:loan_app/ProgessBar.dart';
import 'package:loan_app/apiutil.dart';
import 'package:loan_app/dashboard.dart';
import 'package:loan_app/httphelper.dart';
import 'package:loan_app/login.dart';
import 'package:loan_app/util.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class SignUpState extends State<SignUp> {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  bool isLoadingVisible = false;

  Widget build(BuildContext context) {
    return ProgressBar(
      inAsyncCall: isLoadingVisible,
      opacity: 0.0,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('SignUp'),
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
                height: 200.0,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      maxLength: 20,
                      decoration: InputDecoration(
                        hintText: 'Name',
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
                      controller: mobileController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Mobile',
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
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      maxLength: 40,
                      decoration: InputDecoration(
                        hintText: 'Email Id',
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
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: RaisedButton(
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
                        if (performValidations()) {
                          setState(() {
                            isLoadingVisible = true;
                            Util.saveSharedPreferenceInString(
                                "UserName", nameController.text.toString());
                            Util.saveSharedPreferenceInString("MobileNumber",
                                mobileController.text.toString());
                            Util.saveSharedPreferenceInString(
                                "EmailId", emailController.text.toString());

                            APIUtil util = APIUtil.getApiUtil();
                            HttpHelper.getHttpHelper()
                                .performPostRequest(
                                    Constant.SIGNUP_URL,
                                    util.getSignUpRequestBody(
                                        nameController.text,
                                        mobileController.text,
                                        emailController.text))
                                .then((response) {
                              if (response != null) {
                                Response signUpResponse = response;
                                var signUpResponseData =
                                    json.decode(signUpResponse.body);
                                if (signUpResponseData["status"] == 1) {
                                  isLoadingVisible = false;
                                  HttpHelper.getHttpHelper()
                                      .performPostRequest(
                                          Constant.SEND_OTP_URL,
                                          util.sendOtpRequestBody(
                                              mobileController.text))
                                      .then((response) {
                                    if (response != null) {
                                      Response otpResponse = response;
                                      var sendOtpResponse =
                                          json.decode(otpResponse.body);
                                      if (sendOtpResponse["status"] == 1) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()));
                                      }
                                    }
                                    /*     Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));*/
                                  });
                                } else {
                                  isLoadingVisible = false;
                                }
                                /*else {
                                isLoadingVisible = false;
                              }*/
                              }
                            });
                          });
                        }
                      })),
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    emailController.text = "rajesh.mca008@gmail.com";
    mobileController.text = "8919924240";
    nameController.text = "Rajesh";
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
}
