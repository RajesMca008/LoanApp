import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loan_app/Constant.dart';
import 'package:loan_app/ProgessBar.dart';
import 'package:loan_app/apiutil.dart';
import 'package:loan_app/httphelper.dart';

class BankDetails extends StatefulWidget {
  @override
  BankDetailsState createState() => BankDetailsState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
bool isLoadingVisible = false;

class BankDetailsState extends State<BankDetails> {
  @override
  Widget build(BuildContext context) {
    return ProgressBar(
        inAsyncCall: isLoadingVisible,
        opacity: 0.0,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(title: Text('Bank Details')),
          body: ListView(
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Name:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    "Rajesh Kumar",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Bank:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    "ICICI",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Account Number:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    "093343993241",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "IFSC:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    "ICICI00349",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Account Type:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    "Current",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Branch:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    "JUBLI HILLS,HYDERABAD",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Phone:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    "0402222565",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Container(
                child: Text(""),
              ),
              RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {
                      isLoadingVisible = true;
                      APIUtil util = APIUtil.getApiUtil();
                      HttpHelper.getHttpHelper()
                          .performPostRequestWithEncodedFormat(
                              Constant.BANK_DETAILS,
                              util.prepareRequestBodyForBankDetails(
                                  "14",
                                  "Rajesh",
                                  "HDFC",
                                  "03710027549",
                                  "hdfc00003200",
                                  "Vadala, antophill branch"))
                          .then((response) {
                        Response professionalDetailsResponse = response;
                        var responseData =
                            json.decode(professionalDetailsResponse.body);
                        print(responseData);
                        if (responseData != null &&
                            responseData['status'] == 1) {
                          setState(() {
                            isLoadingVisible = false;
                          });
                          showInSnackBarBlack(
                              _scaffoldKey, responseData['msg']);
                          /*Util.saveSharedPreferenceInString("MobileNumber", null);*/
                        } else {
                          setState(() {
                            isLoadingVisible = false;
                          });
                        }
                      });
                    });

                    /*  Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Dashboard()),
                          ModalRoute.withName('/'),
                        );*/
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ));
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
}
