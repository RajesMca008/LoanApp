import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:loan_app/Constant.dart';
import 'package:loan_app/ProgessBar.dart';
import 'package:loan_app/apiutil.dart';
import 'package:loan_app/dashboard.dart';
import 'package:loan_app/httphelper.dart';

class ProfessionalDetails extends StatefulWidget {
  @override
  ProfessionalDetailsState createState() => ProfessionalDetailsState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class ProfessionalDetailsState extends State<ProfessionalDetails> {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController fixedSalaryController =
      new TextEditingController();
  final TextEditingController postalCodeController =
      new TextEditingController();
  final TextEditingController officeAddressController =
      new TextEditingController();
  final TextEditingController officialMailIdController =
      new TextEditingController();
  final TextEditingController experienceController =
      new TextEditingController();
  final TextEditingController cityController = new TextEditingController();
  int _radioValue = 0;
  InputType inputType = InputType.both;
  bool editable = true;
  DateTime date;
  bool termsNconds = false;
  bool isLoadingVisible = false;
  @override
  Widget build(BuildContext context) {
    return ProgressBar(
        inAsyncCall: isLoadingVisible,
        opacity: 0.0,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(title: Text('Professional Details')),
            body: ListView(
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                TextField(
                  controller: nameController,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Employee Name',
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
                  controller: officeAddressController,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Office Address',
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
                  controller: cityController,
                  maxLines: 1,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'City',
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
                  controller: postalCodeController,
                  maxLines: 1,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Postal Code',
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
                  controller: fixedSalaryController,
                  maxLines: 2,
                  maxLength: 30,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Fixed Salary',
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
                  controller: experienceController,
                  maxLines: 2,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Experience in the Current Company',
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
                  controller: officialMailIdController,
                  maxLines: 2,
                  maxLength: 40,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Official Mail Id',
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
                new CheckboxListTile(
                  value: termsNconds,
                  onChanged: _value1Changed,
                  title: new Text('Accept Terms & Conditions'),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.blue,
                ),
                RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (performValidations()) {
                        setState(() {
                          isLoadingVisible = true;
                          APIUtil util = APIUtil.getApiUtil();
                          HttpHelper.getHttpHelper()
                              .performPostRequestWithEncodedFormat(
                                  Constant.PROFESSIONAL_DETAILS,
                                  util.prepareRequestBodyForProfessionalDetails(
                                      "14",
                                      nameController.text,
                                      officeAddressController.text,
                                      cityController.text,
                                      postalCodeController.text,
                                      fixedSalaryController.text,
                                      experienceController.text,
                                      officialMailIdController.text))
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
                              /*Util.saveSharedPreferenceInString("MobileNumber", null);*/
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Dashboard()),
                                  ModalRoute.withName('/'));
                            } else {
                              setState(() {
                                isLoadingVisible = false;
                              });
                              showInSnackBarBlack(
                                  _scaffoldKey, responseData['msg']);
                            }
                          });
                        });

                        /*  Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Dashboard()),
                          ModalRoute.withName('/'),
                        );*/
                      }
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))
              ],
            )));
  }

  void _value1Changed(bool value) => setState(() => termsNconds = value);

  bool performValidations() {
    if (nameController.text.length < 3) {
      showInSnackBarBlack(_scaffoldKey, "Name must have 3 characters long");
      return false;
    } else if (officeAddressController.text.length < 10) {
      showInSnackBarBlack(_scaffoldKey, "Address must have 10 characters long");
      return false;
    } else if (cityController.text.length < 3) {
      showInSnackBarBlack(_scaffoldKey, "City must have 3 characters long");
      return false;
    } else if (postalCodeController.text.length < 6) {
      showInSnackBarBlack(
          _scaffoldKey, "Postal Code must have 6 characters long");
      return false;
    } else if (fixedSalaryController.text.length < 4) {
      showInSnackBarBlack(
          _scaffoldKey, "Fixed Salary must have 4 characters long");
      return false;
    } else if (experienceController.text.length < 1) {
      showInSnackBarBlack(
          _scaffoldKey, "Please enter experience in the current company");
      return false;
    } else if (!_isEmail(officialMailIdController.text.toString())) {
      showInSnackBarBlack(_scaffoldKey, "Please Enter Valid Email ID");
      return false;
    } else if (termsNconds == false) {
      showInSnackBarBlack(_scaffoldKey, "Please Accept Terms & Conditions");
      return false;
    } else {
      return true;
    }
  }

  bool _isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
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
