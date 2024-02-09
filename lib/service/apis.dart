class ImageBaseUrls {
  static String base = "http://202.164.42.227:9898";
  //
  static String category = "$base/uploads/category/";
  static String product = "$base/uploads/product/";
  static String messageAttachment = "$base/images/users/";
  static String profile = "$base/uploads/product/";
}

class AppApis {
  /// Base URL
  static String baseUrl =
      'http://202.164.42.227:9898/user'; //Local: 192.168.1.210 and Live: 202.164.42.227

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

  // Home
  static String homeData = "/homeScreen";

  // Add Product or Sell Item
  static String addPhysicalProduct = "/addPhysicalProduct";
  static String editPhysicalProduct = "/editProduct";
  static String addCownerProduct = "/addCownerProduct";
  static String productDetatils = "/viewSingleProduct";
  static String myProducts = "/buySellMyProductCownerProduct";
  static String getProducts = "/othersUsersProducts";

  // Add Favourite
  static String addProductAsFavourite = "/addFavouriteProduct";
  static String myFavouriteProducts = "/myFavouriteProduct";
  static String viewAndLikesOfProduct = "/productAllViewAndLikesUsers";

  // chat Attachment upload
  static String uploadAttachment = "/sendMessageSocket";

  // notifications
  static String notificationListing = "/notificationListing";
  static String deleteNotification = "/deleteNotification";
  static String notificationManage = "/notificationManage";

  // Buy Product
  static String shippingAddressAddProductBuy =
      "/stripeLinkGenerate"; // "/shippingAddressAdd";
  static String stripeWebhookConfirmPayment =
      "/stripeWebhook"; //stripePaymentIntents
  static String purchaseShare = "/purchaseShare";
  static String transactionHistory = "/userTransactionHistory";
}
