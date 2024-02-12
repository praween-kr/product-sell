import 'package:get/get.dart';
import 'package:oninto_flutter/views/home/product/public_share_product_details_screen.dart';
import 'package:oninto_flutter/views/message/group_details_screen.dart';
import 'package:oninto_flutter/views/settingScreen/myProductsScreen/my_product_filter_screen.dart';
import 'package:oninto_flutter/views/settingScreen/myProductsScreen/my_purchase_share_details.dart';
import 'package:oninto_flutter/views/settingScreen/myProductsScreen/product_likes_views_screen.dart';
import 'package:oninto_flutter/views/settingScreen/paymentScreen/transaction_histories.dart';

import '../views/auth_screens/forget_password_screens.dart';
import '../views/auth_screens/login_screen.dart';
import '../views/auth_screens/onboarding_screens.dart';
import '../views/auth_screens/signup_screen.dart';
import '../views/auth_screens/verification_screen.dart';
import '../views/bid_screen/home_bid_screen.dart';
import '../views/bid_screen/notification_Screen.dart';
import '../views/home/bottom_navbar_screen.dart';
import '../views/home/category_screen.dart';
import '../views/home/category_wise_products_screen.dart';
import '../views/home/favourite_screen.dart';
import '../views/home/filter_screen.dart';
import '../views/home/home_screen.dart';
import '../views/home/payment_screen.dart';
import '../views/home/product/product_details_screen.dart';
import '../views/home/sub_categories_screen.dart';
import '../views/insight_screen/insight_screen.dart';
import '../views/message/group_message_screen.dart';
import '../views/message/message_screen.dart';
import '../views/message/navBarMsgScreen.dart';
import '../views/sellItemScreen/sell_item_screen.dart';
import '../views/settingScreen/addressScreen/address_screen.dart';
import '../views/settingScreen/addressScreen/newAddressScreen/new_address-screen.dart';
import '../views/settingScreen/cms_screen/cms_screen.dart';
import '../views/settingScreen/myProductsScreen/bidding_history_screen.dart';
import '../views/settingScreen/myProductsScreen/biding_product_details_screen.dart';
import '../views/settingScreen/myProductsScreen/my_physical_product_details.dart';
import '../views/settingScreen/myProductsScreen/my_products_screen.dart';
import '../views/settingScreen/mySubscriptionScreen/selectPlan_screen.dart';
import '../views/settingScreen/mySubscriptionScreen/subscription_screen.dart';
import '../views/settingScreen/passwordScreen/password_screen.dart';
import '../views/settingScreen/paymentScreen/addNewCard_screen.dart';
import '../views/settingScreen/paymentScreen/setting_payment_screen.dart';
import '../views/settingScreen/profileScreen/editProfileScreen/editProfileScreen.dart';
import '../views/settingScreen/profileScreen/profileScreen.dart';
import '../views/settingScreen/settings_screen.dart';
import '../views/splash_screen.dart';
import 'get_bindings.dart';
import 'routes.dart';

class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(
        name: Routes.splashScreen,
        page: () => const SplashScreen(),
        binding: GlobalControllerBinding()),

    /// Auth ----------
    GetPage(
        name: Routes.loginScreen,
        page: () => LoginScreen(),
        bindings: [AuthBinding(), CmsBinding()]),
    GetPage(
        name: Routes.signupScreen,
        page: () => SignUpScreen(),
        bindings: [AuthBinding(), CmsBinding()]),
    GetPage(
      name: Routes.passwordScreen,
      page: () => PasswordScreen(),
    ),
    GetPage(
      name: Routes.forgotScreen,
      page: () => const ForgotScreen(),
    ),
    GetPage(
      name: Routes.verificationScreen,
      page: () => VerificationScreen(),
    ),

    /// Home ----------
    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: Routes.bottomScreen,
      page: () => BottomScreen(),
      bindings: [
        HomeBinding(),
        CategoriesBinding(),
        ProductBinding(),
        FavouritesBinding(),
        SettingsBinding(),
        CmsBinding(),
        ChatMsgBinding(),
        AddressBinding(),
      ],
    ),
    GetPage(
      name: Routes.onboardingScreen,
      page: () => OnBoardingScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.subCategories,
      page: () => SubCategoriesScreen(),
      // bindings: [CategoriesBinding()]
    ),
    GetPage(
      name: Routes.filterScreen,
      page: () => FilterScreen(),
    ),
    GetPage(
      name: Routes.subscriptionScreen,
      page: () => SubscriptionScreen(),
    ),
    GetPage(
      name: Routes.productDetailsScreen,
      page: () => ProductDetailsScreen(),
    ),
    GetPage(
      name: Routes.sellItemScreen,
      page: () => SellItemScreen(),
      binding: SellItemBinding(),
    ),
    GetPage(
      name: Routes.paymentScreen,
      page: () => PaymentScreen(),
    ),
    GetPage(
      name: Routes.productScreen,
      page: () => ProductScreen(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.likeAndViewsOfProductScreen,
      page: () => LikeAndViewsOfProductScreen(),
      binding: ProductBinding(),
    ),
    GetPage(
        name: Routes.publicShareProductDetails,
        page: () => PublicShareProductDetails(),
        binding: ProductBinding()),
    GetPage(
      name: Routes.addNewCardScreen,
      page: () => const AddNewCardScreen(),
    ),
    GetPage(
      name: Routes.settingScreen,
      page: () => SettingScreen(),
      bindings: [AddressBinding()],
    ),
    GetPage(
      name: Routes.settingPaymentScreen,
      page: () => SettingPaymentScreen(),
    ),
    GetPage(
      name: Routes.categoryScreen,
      page: () => CategoryScreen(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: Routes.notificationScreen,
      page: () => NotificationScreen(),
    ),
    GetPage(
      name: Routes.cmsScreen,
      page: () => CmsScreen(),
    ),
    GetPage(
        name: Routes.homeBidScreen,
        page: () => HomeBidScreen(),
        binding: HomeBinding()),
    GetPage(
      name: Routes.selectPlanScreen,
      page: () => SelectPlanScreen(),
    ),
    GetPage(
      name: Routes.favouriteScreen,
      page: () => FavouriteScreen(),
      binding: FavouritesBinding(),
    ),
    GetPage(
      name: Routes.messageScreen,
      page: () => MessageScreen(),
      binding: ChatMsgBinding(),
    ),
    GetPage(
      name: Routes.bidingProductDetails,
      page: () => BidingProductDetailsScreen(),
    ),
    GetPage(
      name: Routes.categoriesWiseProductsScreen,
      page: () => CategoryWiseProductsScreen(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: Routes.biddingHistoryScreen,
      page: () => BiddingHistoryScreen(),
    ),
    // GetPage(
    //     name: Routes.myShareProductDetailsScreen,
    //     page: () => MyShareProductDetails(),
    //     binding: ProductBinding()),
    GetPage(
      name: Routes.navbarScreen,
      page: () => NavBarMsgScreen(),
    ),
    GetPage(
      name: Routes.groupMessageScreen,
      page: () => GroupMessageScreen(),
    ),
    GetPage(
      name: Routes.groupDetailsScreen,
      page: () => GroupDetailsScreen(),
    ),
    GetPage(
      name: Routes.profileScreen,
      page: () => ProfileScreen(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.editProfileScreen,
      page: () => EditProfileScreen(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.addressScreen,
      page: () => AddressScreen(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: Routes.newAddressScreen,
      page: () => NewAddressScreen(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: Routes.subscriptionScreen,
      page: () => SubscriptionScreen(),
    ),
    GetPage(
      name: Routes.insightScreen,
      page: () => InsightsScreen(),
    ),
    GetPage(
      name: Routes.myPhysicalProductDetailScreen,
      page: () => MyPysicalProductDetailScreen(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.myProductFilterScreen,
      page: () => MyProductFilterScreen(),
      binding: ProductBinding(),
    ),
    // GetPage(
    //   name: Routes.editItemScreen,
    //   page: () => EditItemScreen(),
    // ),
    GetPage(
      name: Routes.insightScreen,
      page: () => InsightsScreen(),
    ),

    GetPage(
      name: Routes.transactionHistories,
      page: () => TransactionHistories(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: Routes.myPurchaseShareDetails,
      page: () => MyPurchaseShareDetails(),
      binding: ProductBinding(),
    ),
  ];
}
