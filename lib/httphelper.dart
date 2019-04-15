import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:loan_app/AppContext.dart';

/*
This class used for http requests handling and utility methods for different types of requests..
 */
class HttpHelper {
  static HttpHelper httpHelper;

  /*
  This method used to initialize http helper
   */
  static HttpHelper getHttpHelper() {
    if (httpHelper == null) {
      httpHelper = new HttpHelper();
    }
    return httpHelper;
  }

  /*
  This method used to perform http get request handling
   */
  Future<Object> performGetRequest(String url) async {
    http.Response response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return response;
    } else {
      // If that call was not successful, throw an error.
      return throw Exception('Something went wrong Please try again!');
    }
  }

  /*
  This method used to perform http post request handling
   */

  Future<Object> performPostRequest(String url, String requestBody) async {
    bool isConnected = await AppContext().initConnectivity();

    if (isConnected == false) return false;

    http.Response response = await http.post(Uri.parse(url),
        headers: {"content-type": "application/json"},
        body: requestBody); //, encoding: Encoding.getByName("UTF-8")

    try {
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        print(json.decode(response.body));
        return response;
      }
    } catch (e) {
      print("exception" + e.toString());
      return null;
    }
    /*if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print(json.decode(response.body));
      return response;
    } else {
      // If that call was not successful, throw an error.
      // return false;
      return throw Exception('Something went wrong Please try again!');
    }*/
  }

  Future<Object> performPostRequestAction(
      String url, String requestBody) async {
    bool isConnected = await AppContext().initConnectivity();

    if (isConnected == false) return false;

    http.Response response = await http.post(Uri.parse(url),
        headers: {"content-type": "application/json"},
        body: requestBody); //, encoding: Encoding.getByName("UTF-8")

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print(json.decode(response.body));
      var responseJson = json.decode(response.body);
      if (responseJson['status'] == 1) return true;
      return false;
    } else {
      // If that call was not successful, throw an error.
      // return false;
      return throw Exception('Something went wrong Please try again!');
    }
  }

  Future<Object> downloadDataFromServer(String url, String body) async {
    http.Response response = await performPostRequest(url, body);

    if (response == null) return null;
    print(response);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print(response);
      print(json.decode(response.body));
      var outPutResponse = json.decode(response.body);
      return outPutResponse;
    } else {
      // If that call was not successful, throw an error.
      return throw Exception('Something went wrong Please try again!');
    }
  }

  Future<Object> sendRequestToServer(String url, String body) async {
    bool isConnected = await AppContext().initConnectivity();

    if (isConnected == false) return false;

    http.Response response = await httpHelper.performPostRequest(
        url, body); //, encoding: Encoding.getByName("UTF-8")
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print(json.decode(response.body));
      var outPutResponse = json.decode(response.body);
      if (outPutResponse['status'] == 1) return true;
      return false;
    } else {
      // If that call was not successful, throw an error.
      return false;
      return throw Exception('Something went wrong Please try again!');
    }
  }
}
