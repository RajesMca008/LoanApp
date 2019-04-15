import 'package:flutter/material.dart';

class BankDetails extends StatefulWidget {
  @override
  BankDetailsState createState() => BankDetailsState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class BankDetailsState extends State<BankDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ],
      ),
    );
  }
}
