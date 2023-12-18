import 'package:get/get.dart';

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
import '../views/home/product_details_screen.dart';
import '../views/home/sub_categories_screen.dart';
import '../views/insight_screen/insight_screen.dart';
import '../views/message/message_screen.dart';
import '../views/navBarMsgScreen/gyaradoMsgScreen/gyaradoMsgScreen.dart';
import '../views/navBarMsgScreen/navBarMsgScreen.dart';
import '../views/sellItemScreen/sell_item_screen.dart';
import '../views/settingScreen/addressScreen/address_screen.dart';
import '../views/settingScreen/addressScreen/newAddressScreen/new_address-screen.dart';
import '../views/settingScreen/cms_screen/cms_screen.dart';
import '../views/settingScreen/myProductsScreen/bidding_history_screen.dart';
import '../views/settingScreen/myProductsScreen/biding_product_details_screen.dart';
import '../views/settingScreen/myProductsScreen/co_owner_product_details_screen.dart';
import '../views/settingScreen/myProductsScreen/editItem_screen.dart';
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
      page: () => const NotificationScreen(),
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
    GetPage(
        name: Routes.coOwnerProductDetailsScreen,
        page: () => CoOwnerProductDetailsScreen(),
        binding: ProductBinding()),
    GetPage(
      name: Routes.navbarScreen,
      page: () => NavBarMsgScreen(),
    ),
    GetPage(
      name: Routes.gyaradoMsgScreen,
      page: () => const GyaradoMsgScreen(),
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
      name: Routes.editItemScreen,
      page: () => EditItemScreen(),
    ),
    GetPage(
      name: Routes.insightScreen,
      page: () => InsightsScreen(),
    ),
  ];
}
