import 'dart:convert';

class APIUtil {
  static APIUtil apiUtil;
  /*
   * This method used to initialize BMG profile util
   */
  static APIUtil getApiUtil() {
    if (apiUtil == null) {
      apiUtil = new APIUtil();
    }
    return apiUtil;
  }

  String getSignUpRequestBody(
      String userName, String email, String phoneNumber) {
    Map<String, Object> signUpMap = new Map<String, Object>();
    signUpMap['username'] = userName;
    signUpMap['mobile_no'] = email;
    signUpMap['email'] = phoneNumber;
    String requestBody = json.encode(signUpMap);
    return requestBody;
  }

  /*
  This method used to send request body for send otp
   */
  String sendOtpRequestBody(String phoneNumber) {
    Map<String, Object> otpMap = new Map<String, Object>();
    otpMap['mobile_no'] = int.parse(phoneNumber);
    return json.encode(otpMap);
  }
}