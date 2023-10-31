class AppApis {
  /// Base URL
  static String baseUrl = 'http://202.164.42.227:9898/user';

  static String imageBaseUrl = 'http://202.164.42.227:9898/uploads/category/';

  /// API end points---------
  static String signin = '/login';
  static String signUp = '/signUp';
  static String otpVerify = "/otpVerify";
  static String resendOtp = "/resendOtp";
  static String logout = "/logOut";
  //Profile
  static String updateProfile = "/updateProfile";
  static String changePassword = "/changePassword";

  //CMS
  static String getCMS = "/getcms";

  // Address
  static String addAddress = "/addUserAddress";
  static String getAddresses = "/listOfAddress";

  // Categories
  static String categoryList = "/categoryList";
  static String subCategoriesList = "/subCategorys";
}