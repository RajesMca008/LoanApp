import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //for making request
import 'dart:async'; //for asynchronous features
import 'dart:convert'; //for converting the response to desired format. e.g: JSON
import 'package:flutter/services.dart'; //PlatForm Exception
import 'dart:io';

import 'package:loan_app/connectivity.dart';

class AppContext {
  static final AppContext _singleton = new AppContext._internal();

  String _connectionStatus;
  final Connectivity _connectivity = new Connectivity();

  //For subscription to the ConnectivityResult stream
  StreamSubscription<ConnectivityResult> _connectionSubscription;

  factory AppContext() {
    return _singleton;
  }

  //called in initState
  /*
    _connectivity.checkConnectivity() checks the connection state of the device.
  */
  /// Check internet connection status.
  Future<bool> initConnectivity() async {
    String connectionStatus;
    bool isConnected = false;
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();
    } on PlatformException catch (e) {
      print(e.toString());
      connectionStatus = "Internet connectivity failed";
    }

    _connectionStatus = connectionStatus;
    print("InitConnectivity : $_connectionStatus");
    if (_connectionStatus == "ConnectivityResult.mobile" ||
        _connectionStatus == "ConnectivityResult.wifi") {
      isConnected = await getData();
      print("connected :$isConnected");
    } else {
      print("You are not connected to internet");
      isConnected = false;
    }

    return isConnected;
  }

  //makes the request
  Future<bool> getData() async {
    bool res = false;

    try {
      final result = await InternetAddress.lookup('54.208.156.33');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        res = true;
        //_titleText="connected";
      }
    } on SocketException catch (_) {
      print('not connected');

      res = false;
      //_titleText="not connected";
    }

    return res;
  }

  AppContext._internal();
}
