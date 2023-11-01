import 'package:get/get.dart';
import 'package:oninto_flutter/routes/get_bindings.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/views/authscreens/forgetpassword_screens.dart';
import 'package:oninto_flutter/views/authscreens/onboarding_screens.dart';
import 'package:oninto_flutter/views/authscreens/signup_screen.dart';
import 'package:oninto_flutter/views/authscreens/verification_screen.dart';
import 'package:oninto_flutter/views/home/denim_screen.dart';
import 'package:oninto_flutter/views/home/favourite_screen.dart';
import 'package:oninto_flutter/views/home/filter_screen.dart';
import 'package:oninto_flutter/views/home/payment_screen.dart';
import 'package:oninto_flutter/views/home/sub_categories_screen.dart';
import 'package:oninto_flutter/views/insight_screen/insight_screen.dart';
import 'package:oninto_flutter/views/navBarMsgScreen/navBarMsgScreen.dart';
import 'package:oninto_flutter/views/sellItemScreen/sell_item_screen.dart';
import 'package:oninto_flutter/views/settingScreen/addressScreen/address_screen.dart';
import 'package:oninto_flutter/views/settingScreen/addressScreen/newAddressScreen/new_address-screen.dart';
import 'package:oninto_flutter/views/settingScreen/cms_screen/cms_screen.dart';
import 'package:oninto_flutter/views/settingScreen/myProductsScreen/editItem_screen.dart';
import 'package:oninto_flutter/views/settingScreen/myProductsScreen/productDetail_screen.dart';
import 'package:oninto_flutter/views/settingScreen/mySubscriptionScreen/selectPlan_screen.dart';
import 'package:oninto_flutter/views/settingScreen/mySubscriptionScreen/subscription_screen.dart';
import 'package:oninto_flutter/views/settingScreen/passwordScreen/password_screen.dart';
import 'package:oninto_flutter/views/settingScreen/paymentScreen/addNewCard_screen.dart';
import 'package:oninto_flutter/views/settingScreen/paymentScreen/setting_payment_screen.dart';
import 'package:oninto_flutter/views/settingScreen/settings_screen.dart';

import '../splash_screen.dart';
import '../views/authscreens/login_screen.dart';
import '../views/bid_screen/home_bid_screen.dart';
import '../views/bid_screen/notification_Screen.dart';
import '../views/home/bottom_navbar_screen.dart';
import '../views/home/category_screen.dart';
import '../views/home/home_screen.dart';
import '../views/home/sub_category_screen.dart';
import '../views/navBarMsgScreen/gyaradoMsgScreen/gyaradoMsgScreen.dart';
import '../views/settingScreen/myProductsScreen/bidding_screen.dart';
import '../views/settingScreen/myProductsScreen/gyraados_screen.dart';
import '../views/settingScreen/myProductsScreen/men_shirt_screen.dart';
import '../views/settingScreen/myProductsScreen/message_screen.dart';
import '../views/settingScreen/myProductsScreen/product_screen.dart';
import '../views/settingScreen/profileScreen/editProfileScreen/editProfileScreen.dart';
import '../views/settingScreen/profileScreen/profileScreen.dart';

class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(
        name: Routes.splashScreen,
        page: () => const SplashScreen(),
        binding: GlobleControllerBinding()),

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
        SettingsBinding(),
        CmsBinding(),
        AddressBinding(),
      ],
    ),
    GetPage(
      name: Routes.onboardingScreen,
      page: () => OnBoardingScreen(),
    ),
    GetPage(
      name: Routes.subCategories,
      page: () => SubCategoriesScreen(),
      // bindings: [CategoriesBinding()]
    ),
    GetPage(
      name: Routes.filterScreen,
      page: () => const FilterScreen(),
    ),
    GetPage(
      name: Routes.subscriptionScreen,
      page: () => SubscriptionScreen(),
    ),
    GetPage(
      name: Routes.denimScreen,
      page: () => DenimScreen(),
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
        name: Routes.homebidScreen,
        page: () => HomeBidScreen(),
        binding: HomeBinding()),
    GetPage(
      name: Routes.selectPlanScreen,
      page: () => SelectPlanScreen(),
    ),
    GetPage(
      name: Routes.favouriteScreen,
      page: () => FavouriteScreen(),
    ),
    GetPage(
      name: Routes.messageScreen,
      page: () => const MessageScreen(),
    ),
    GetPage(
      name: Routes.menshirtScreen,
      page: () => MenshirtScreen(),
    ),
    GetPage(
      name: Routes.subCategoryScreen,
      page: () => SubCategoryScreen(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: Routes.biddingScreen,
      page: () => const BiddingScreen(),
    ),
    GetPage(
      name: Routes.gyradosScreen,
      page: () => GyradosScreen(),
    ),
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
      name: Routes.productDetailScreen,
      page: () => const ProductDetailScreen(),
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
