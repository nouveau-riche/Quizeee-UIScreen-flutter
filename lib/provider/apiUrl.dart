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
  static String baseUrlImage =
      "https://quizeee-app-api.herokuapp.com/api/download/";

  // Login flow
  static String sendVerificationOtp = "send-verification-otp";
  static String sendVerificationRegistration = "signup-verification-otp";
  static String loginUser = "user-login";
  static String signUpUser = "users-signup";
  static String getUserDetails = "get-user-details/";
  static String localStorageKey = "userDetails";
  static String userReferalCodeVerify = "get-user-by-referralCode/";

  //Edit user
  static String editUser = "edit-user-details";
  static String verifyAuths = "verify-edit-phone";

  //Dashboard - QUIZ API
  static String dashboardData = "all-assigned-public-quizes";
  static String dashboardBanner = "get-banner-by-name/dashboard";
  static String checkBookinStatus = "check-booking-status";
  static String bookQuiz = "book-quizeee-master-quiz-slot";
  static String pracQuiz = "get-practice-questionByCategory";
  static String getUserQuiz = "get-user-quizzes-details/";

  //QUIZ SUBMIT
  static String submitResult = "add-quiz-result";
  static String getUserRank = "get-user-rank";

  // NOTIFICATIONS
  static String getUserNotifications = "all-user-notifications/";
  static String deleteNotifications = "del-notification";

  //WEBVIEWS
  static String createQuiz =
      "https://quizeee-free-quiz.netlify.app/web/add-user-free-quiz/";

  // USER PERFORMANCE
  static String userPerformance = "performance-history";
  static String userPerformanceCategory = "user-categoryWise-graph";
  static String userPerformanceSubCategory = "user-subCategoryWise-graph";
  static String userPerformanceAreaOfInterest = "user-areaOfInterestWise-graph";

  // WALLET
  static String walletRefill =
      "https://quizeee-free-quiz.netlify.app/webPayment/make-payment?userId=";
  static String getWalletDetails = "get-single-wallet-details/";
  static String uploadWalletDocs = "add-wallet-document/";
}
