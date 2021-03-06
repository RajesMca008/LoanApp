import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:loan_app/Constant.dart';
import 'package:loan_app/ProgessBar.dart';
import 'package:loan_app/apiutil.dart';
import 'package:loan_app/httphelper.dart';
import 'package:loan_app/professionaldetails.dart';

class PersonalDetails extends StatefulWidget {
  @override
  PersonalDetailsState createState() => PersonalDetailsState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class PersonalDetailsState extends State<PersonalDetails> {
  bool isLoadingVisible = false;
  String gender = "Male";
  DateTime currentDate = new DateTime.now();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController motherController = new TextEditingController();
  final TextEditingController educationController = new TextEditingController();
  final TextEditingController currentAddressController =
      new TextEditingController();
  final TextEditingController totalEmiController = new TextEditingController();
  final TextEditingController presentRentController =
      new TextEditingController();
  final TextEditingController pancardController = new TextEditingController();

  int _radioValue = 0;
  InputType inputType = InputType.both;
  bool editable = true;

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
        inAsyncCall: isLoadingVisible,
        opacity: 0.0,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(title: Text('Personal Details')),
            body: ListView(
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                TextField(
                  controller: nameController,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
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
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Gender",
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    new Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    new Text('Male'),
                    new Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange,
                    ),
                    new Text('Female'),
                  ],
                ),
                TextField(
                  controller: motherController,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Mother Name',
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
                new InkResponse(
                    child: new InputDecorator(
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.grey),
                        labelText: 'DOB',
                        // ignore: const_with_non_constant_argument, invalid_constant

                        suffixIcon: const Icon(Icons.arrow_right),
                      ),
                      child: new Text(
                        new DateFormat('yMMMd').format(currentDate),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18.0),
                      ),
                    ),
                    onTap: () => _showDatePicker(context)),
                TextField(
                  controller: educationController,
                  maxLines: 2,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Education Details',
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
                  controller: currentAddressController,
                  maxLines: 2,
                  maxLength: 30,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Current Address',
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
                  controller: totalEmiController,
                  maxLines: 2,
                  maxLength: 30,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Total EMI',
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
                  controller: presentRentController,
                  maxLines: 2,
                  maxLength: 30,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Present Rent',
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
                  controller: pancardController,
                  maxLines: 2,
                  maxLength: 30,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'PanCard',
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
                    color: Colors.blue,
                    onPressed: () async {
                      if (performValidations()) {
                        setState(() {
                          isLoadingVisible = true;
                          APIUtil util = APIUtil.getApiUtil();
                          HttpHelper.getHttpHelper()
                              .performPostRequestWithEncodedFormat(
                                  Constant.PERSONAL_DETAILS,
                                  util.prepareRequestBodyForPersonalDetails(
                                      "15",
                                      nameController.text,
                                      gender,
                                      motherController.text,
                                      new DateFormat('yMMMd')
                                          .format(currentDate),
                                      educationController.text,
                                      currentAddressController.text,
                                      totalEmiController.text,
                                      presentRentController.text,
                                      pancardController.text))
                              .then((response) {
                            Response loanDetailsResponse = response;
                            var responseData =
                                json.decode(loanDetailsResponse.body);
                            print(responseData);
                            if (responseData != null &&
                                responseData['status'] == 1) {
                              setState(() {
                                isLoadingVisible = false;
                              });
                              /*Util.saveSharedPreferenceInString("MobileNumber", null);*/
                              showInSnackBarBlack(
                                  _scaffoldKey, responseData['msg']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfessionalDetails()));
                            } else {
                              setState(() {
                                isLoadingVisible = false;
                              });
                              showInSnackBarBlack(
                                  _scaffoldKey, responseData['msg']);
                            }
                          });
                        });
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

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          gender = "Male";
          break;
        case 1:
          gender = "Female";
          break;
      }
    });
  }

  bool performValidations() {
    if (nameController.text.length < 3) {
      showInSnackBarBlack(_scaffoldKey, "Name must have 3 characters long");
      return false;
    } else if (motherController.text.length < 3) {
      showInSnackBarBlack(
          _scaffoldKey, "Mother Name must have 3 characters long");
      return false;
    } else if (currentDate == null) {
      showInSnackBarBlack(_scaffoldKey, "Please select Date & Time");
      return false;
    } else if (educationController.text.length < 3) {
      showInSnackBarBlack(
          _scaffoldKey, "Education Details must have 3 characters long");
      return false;
    } else if (currentAddressController.text.length < 10) {
      showInSnackBarBlack(_scaffoldKey, "Address must have 10 characters long");
      return false;
    } else if (totalEmiController.text.length < 1) {
      showInSnackBarBlack(_scaffoldKey, "Please enter Total EMI");
      return false;
    } else if (presentRentController.text.length < 1) {
      showInSnackBarBlack(_scaffoldKey, "Please enter Present Rent");
      return false;
    } else if (pancardController.text.length < 10) {
      showInSnackBarBlack(_scaffoldKey, "Please enter valid PANCard");
      return false;
    } else {
      return true;
    }
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

  _showDatePicker(BuildContext context) async {
    DateTime dateTimePicked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (dateTimePicked != null) {
      setState(() {
        currentDate = dateTimePicked;
      });
    }
  }
}
