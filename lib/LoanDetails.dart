import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:loan_app/personaldetails.dart';

class LoanDetails extends StatefulWidget {
  @override
  LoanDetailsState createState() => LoanDetailsState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class LoanDetailsState extends State<LoanDetails> {
  final TextEditingController loanAmountController =
      new TextEditingController();
  int tenureValue;
  double interestValue;
  List<int> tenureList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<double> interestRateList = [
    /*12.0,
    12.5,
    13.0,
    13.5,
    14.0,
    14.5,
    15.0,
    15.5,
    16.0,
    16.5,
    17.0*/
    8.0
  ];
  int finalEMI;
  bool isEmiDisplay = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Calculate Loan')),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Text(
            "Loan Amount Value",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          TextField(
            inputFormatters: [
              BlacklistingTextInputFormatter(new RegExp('[\\.|\\,|\\- |\\ ]'))
            ],
            controller: loanAmountController,
            maxLength: 12,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
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
          Text(
            "Tenture In Years",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          new DropdownButton<int>(
              value: tenureValue,
              isExpanded: true,
              onChanged: (int newValue) {
                setState(() {
                  tenureValue = newValue;
                  //fetchDetails();
                });
              },
              items: tenureList.map((int data) {
                return new DropdownMenuItem<int>(
                    value: data, child: new Text(data.toString()));
              }).toList()),
          Text(
            "Interest Rate",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
          new DropdownButton<double>(
              value: interestValue,
              isExpanded: true,
              onChanged: (double newValue) {
                setState(() {
                  interestValue = newValue;
                  //fetchDetails();
                });
              },
              items: interestRateList.map((double data) {
                return new DropdownMenuItem<double>(
                    value: data, child: new Text(data.toString()));
              }).toList()),
          RaisedButton(
              color: Colors.blue,
              onPressed: () {
                performLoanCalc();
              },
              child: Text(
                "Calculate Loan EMI",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
          isEmiDisplay
              ? Text(
                  "You have to pay an EMI of INR $finalEMI/- on your loan.",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0),
                  textAlign: TextAlign.center,
                )
              : Text(""),
          RaisedButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PersonalDetails()));
              },
              child: Text(
                "Request Loan",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }

  void performLoanCalc() {
    if (performValidations()) {
      setState(() {
        isEmiDisplay = true;
        double rate = interestValue;
        double time = tenureValue.toDouble();
        rate = rate / (12 * 100);
        time = time * 12;
        double emi = (double.parse(loanAmountController.text) *
                rate *
                pow(1 + rate, time)) /
            (pow(1 + rate, time) - 1);

        finalEMI = emi.ceil();
      });
    }
  }

  bool performValidations() {
    if (loanAmountController.text.length < 5) {
      showInSnackBarBlack(_scaffoldKey, "Please Enter Valid Loan Amount");
      return false;
    } else if (tenureValue == null) {
      showInSnackBarBlack(_scaffoldKey, "Please select tenure");
      return false;
    } else if (interestValue == null) {
      showInSnackBarBlack(_scaffoldKey, "Please select interest rate");
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
}
