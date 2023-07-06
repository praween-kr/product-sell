import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/views/authscreens/forgetpassword_screens.dart';
import 'package:oninto_flutter/views/authscreens/onboarding_screens.dart';
import 'package:oninto_flutter/views/authscreens/signup_screen.dart';
import 'package:oninto_flutter/views/authscreens/verification_screen.dart';
import 'package:oninto_flutter/views/home/denim_screen.dart';
import 'package:oninto_flutter/views/home/favourite_screen.dart';
import 'package:oninto_flutter/views/home/filter_screen.dart';
import 'package:oninto_flutter/views/home/men_screen.dart';
import 'package:oninto_flutter/views/home/payment_screen.dart';
import 'package:oninto_flutter/views/navBarMsgScreen/navBarMsgScreen.dart';
import 'package:oninto_flutter/views/sellItemScreen/itemBidScreen/item_bid_screen.dart';
import 'package:oninto_flutter/views/sellItemScreen/sell_item_screen.dart';
import 'package:oninto_flutter/views/settingScreen/settings_screen.dart';
import '../splash_screen.dart';
import '../views/authscreens/login_screen.dart';
import '../views/bid_screen/home_bid_screen.dart';
import '../views/bid_screen/notification_Screen.dart';
import '../views/home/bottom_navbar_screen.dart';
import '../views/home/category_screen.dart';
import '../views/home/home_screen.dart';
import '../views/navBarMsgScreen/gyaradoMsgScreen/gyaradoMsgScreen.dart';
import '../views/settingScreen/myProductsScreen/bidding_screen.dart';
import '../views/settingScreen/myProductsScreen/gyraados_screen.dart';
import '../views/settingScreen/myProductsScreen/men_shirt_screen.dart';
import '../views/settingScreen/myProductsScreen/message_screen.dart';
import '../views/settingScreen/myProductsScreen/product_screen.dart';
import '../views/settingScreen/profileScreen/editProfileScreen/editProfileScreen.dart';
import '../views/settingScreen/profileScreen/profileScreen.dart';


class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget widgetScreen;
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashScreen:
        widgetScreen = const SplashScreen();
        break;
      case Routes.loginScreen:
        widgetScreen = LoginScreen();
        break;
      case Routes.homeScreen:
        widgetScreen = HomeScreen(data: args as Map<String, dynamic>?);
        break;
      case Routes.bottomScreen:
        widgetScreen = BottomScreen();
        break;
      case Routes.onboardingScreen:
        widgetScreen = OnBoardingScreen();
        break;
      case Routes.forgotScreen:
        widgetScreen = const ForgotScreen();
        break;
      case Routes.verificationScreen:
        widgetScreen = const VerificationScreen();
        break;
      case Routes.menScreen:
        widgetScreen = MenScreen();

        break;
      case Routes.filterScreen:
        widgetScreen = const FilterScreen();
        break;
      case Routes.denimScreen:
        widgetScreen = DenimScreen(
          data: args as Map<String, dynamic>,
        );
        break;
      case Routes.paymentScreen:
        widgetScreen = const PaymentScreen();
        break;
      case Routes.productScreen:
        widgetScreen = ProductScreen();
        break;
      case Routes.signupScreen:
        widgetScreen = SignUpScreen();
        break;
      case Routes.settingScreen:
        widgetScreen = SettingScreen();
        break;
      case Routes.categoryScreen:
        widgetScreen = CategoryScreen();
        break;

      case Routes.notificationScreen:
        widgetScreen = NotificationScreen();
        break;
      case Routes.homebidScreen:
        widgetScreen = HomeBidScreen();
        break;
      case Routes.favouriteScreen:
        widgetScreen = FavouriteScreen();
        break;
      case Routes.messageScreen:
        widgetScreen = const MessageScreen();
        break;
      case Routes.menshirtScreen:
        widgetScreen = const MenshirtScreen();
        break;
      case Routes.biddingScreen:
        widgetScreen = const BiddingScreen();
        break;
      case Routes.gyradosScreen:
        widgetScreen = GyradosScreen();
        break;
      case Routes.navbarScreen:
        widgetScreen = NavBarMsgScreen();
        break;
      case Routes.sellItemScreen:
        widgetScreen = SellItemScreen();
        break;
      case Routes.gyaradoMsgScreen:
        widgetScreen = GyaradoMsgScreen();
        break;
      case Routes.profileScreen:
        widgetScreen = ProfileScreen();
        break;
      case Routes.editProfileScreen:
        widgetScreen = EditProfileScreen();
        break;
        break;
      // case Routes.itemBidScreen:
      //   widgetScreen = ItemBidScreen();
      //   break;
      default:
        widgetScreen = _errorRoute();
    }
    return GetPageRoute(
        routeName: settings.name,
        page: () => widgetScreen,
        transition: Transition.rightToLeft,
        settings: settings);
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('No Such screen found in route generator'),
      ),
    );
  }
}
