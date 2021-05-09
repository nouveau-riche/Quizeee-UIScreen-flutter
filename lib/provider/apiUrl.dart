class ApiUrls {
  //Headers
  static Map<String, String> headers = {
    "Content-Type": "application/json",
  };
  static Map<String, String> headersFormData = {
    "Content-Type": "application/x-www-form-urlencoded",
  };
  static Map<String, String> headersFormDataMultiPart = {
    "Content-Type": "multipart/form-data",
  };

  // Base Url
  static String baseUrl = "https://quizeee-app-api.herokuapp.com/api/";

  // Login flow
  static String sendVerificationOtp = "send-verification-otp";
  static String sendVerificationRegistration = "signup-verification-otp";
  static String loginUser = "user-login";
  static String signUpUser = "users-signup";
  static String getUserDetails = "get-user-details/";
}
