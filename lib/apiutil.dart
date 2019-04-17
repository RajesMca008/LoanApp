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
  Map<String, Object> sendOtpRequestBody(String phoneNumber) {
    Map<String, Object> otpMap = new Map<String, Object>();
    otpMap['mobile_no'] = phoneNumber;
    return otpMap;
  }

  /*
  This method used to send request body for loan details
   */
  Map<String, Object> prepareRequestBodyForLoanDetails(
      String userId, String loanTypeId, String loanAmount, int loanTenor) {
    Map<String, Object> loanMap = new Map<String, Object>();
    loanMap['user_id'] = userId;
    loanMap['loan_type_id'] = loanTypeId;
    loanMap['loan_amount'] = loanAmount;
    loanMap['loan_tenor'] = loanTenor.toString();
    return loanMap;
  }

  /*
  This method used to prepare request body for verify otp
   */
  Map<String, Object> verifyOtpRequestBody(String phoneNumber, String otp) {
    Map<String, Object> otpMap = new Map<String, Object>();
    otpMap['mobile_no'] = phoneNumber;
    otpMap['otp'] = otp;
    return otpMap;
  }

  /*
  This method used to send request body for personal details
   */
  Map<String, Object> prepareRequestBodyForPersonalDetails(
      String userId,
      String fullName,
      String gender,
      String motherName,
      String dob,
      String education,
      String address,
      String totalEmi,
      String presentRent,
      String pancard) {
    Map<String, Object> personMap = new Map<String, Object>();
    personMap['user_id'] = userId;
    personMap['full_name'] = fullName;
    personMap['gender'] = gender;
    personMap['mother_name'] = motherName;
    personMap['educational_qualification'] = education;
    personMap['dob'] = dob;
    personMap['current_address'] = address;
    personMap['total_emi'] = totalEmi;
    personMap['present_rent'] = presentRent;
    personMap['pancard_number'] = pancard;
    print(json.encode(personMap));
    return personMap;
  }

  /*
  This method used to send request body for professional details
   */
  Map<String, Object> prepareRequestBodyForProfessionalDetails(
      String userId,
      String employeName,
      String officeAddress,
      String city,
      String postalCode,
      String fixedSalary,
      String experience,
      String officialMail) {
    Map<String, Object> professionalMap = new Map<String, Object>();
    professionalMap['loan_id'] = userId;
    professionalMap['employer_name'] = employeName;
    professionalMap['office_address'] = officeAddress;
    professionalMap['city'] = city;
    professionalMap['postal_code'] = postalCode;
    professionalMap['fixed_salary'] = fixedSalary;
    professionalMap['experience_in_current_company'] = experience;
    professionalMap['official_mail'] = officialMail;
    print(json.encode(professionalMap));
    return professionalMap;
  }

  /*
  This method used to send request body for bank details
   */
  Map<String, Object> prepareRequestBodyForBankDetails(
    String userId,
    String name,
    String bankName,
    String accountNumber,
    String ifscCode,
    String branch,
  ) {
    Map<String, Object> bankMap = new Map<String, Object>();
    bankMap['loan_id'] = userId;
    bankMap['name'] = name;
    bankMap['name_of_bank'] = bankName;
    bankMap['account_number'] = accountNumber;
    bankMap['ifsc_code'] = ifscCode;
    bankMap['branch'] = branch;
    print(json.encode(bankMap));
    return bankMap;
  }
}
