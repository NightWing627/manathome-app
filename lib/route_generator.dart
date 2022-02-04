import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multisuperstore/src/pages/all_provider.dart';
import 'package:multisuperstore/src/pages/animated_screen.dart';
import 'package:multisuperstore/src/pages/booking_detail.dart';
import 'package:multisuperstore/src/pages/booking_detail_service.dart';
import 'package:multisuperstore/src/pages/bookings.dart';
import 'package:multisuperstore/src/pages/category_productss.dart';
import 'package:multisuperstore/src/pages/chat_page.dart';
import 'package:multisuperstore/src/pages/h_category.dart';
import 'package:multisuperstore/src/pages/h_thankyou.dart';
import 'package:multisuperstore/src/pages/introscreen.dart';
import 'package:multisuperstore/src/pages/location_detector.dart';
import 'package:multisuperstore/src/pages/loginpage.dart';
import 'package:multisuperstore/src/pages/maph.dart';
import 'package:multisuperstore/src/pages/mybookings.dart';
import 'package:multisuperstore/src/pages/order_details.dart';
import 'package:multisuperstore/src/pages/otp_verification_email.dart';
import 'package:multisuperstore/src/pages/recharge.dart';
import 'package:multisuperstore/src/pages/register.dart';
import 'package:multisuperstore/src/pages/searchLocation.dart';
import 'package:multisuperstore/src/pages/search_location.dart';
import 'package:multisuperstore/src/pages/services_page.dart';
import 'package:multisuperstore/src/pages/stores_favorite.dart';
import 'package:multisuperstore/src/pages/subcategory.dart';
import 'package:multisuperstore/src/pages/timedatepage.dart';
import 'package:multisuperstore/src/pages/topup.dart';
import 'package:multisuperstore/src/pages/tutorial.dart';
import 'package:multisuperstore/src/pages/update_password.dart';
import 'package:multisuperstore/src/pages/wallet.dart';
import 'package:multisuperstore/src/pages/wallet_thankyou.dart';
import 'package:multisuperstore/src/pages/wallet_transcation_history.dart';
import 'src/pages/booking_track1.dart';
import 'src/pages/grocerystore.dart';

import 'src/pages/book_confirmation.dart';
import 'src/pages/send_package.dart';
import 'src/pages/upload_prescription.dart';
import 'src/pages/map.dart';
import 'src/pages/store_detail.dart';
import 'src/pages/booking_track.dart';
import 'src/pages/checkoutpage.dart';
import 'src/pages/payment.dart';
import 'src/pages/category_product.dart';
import 'src/pages/ProfilePage.dart';
import 'src/pages/apply_coupon.dart';
import 'src/pages/empty_cart.dart';
import 'src/pages/orders.dart';
import 'src/pages/otp_verification.dart';
import 'src/pages/product_list.dart';
import 'src/pages/stores.dart';
import 'src/pages/thankyou.dart';
import 'src/pages/forget_password.dart';
import 'src/pages/languages.dart';
import 'src/pages/loginpage.dart';
import 'src/pages/pages.dart';
import 'src/pages/settings.dart';
import 'src/pages/splash_screen.dart';
import 'src/pages/main_page.dart';
import 'src/pages/shop_rating.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/orderDetails':
        return MaterialPageRoute(
            builder: (_) => OrderDetails(
                  orderId: args,
                ));
      case '/bookingDetails':
        return MaterialPageRoute(builder: (_) => BookingDetails());
      case '/bookingServiceDetails':
        return MaterialPageRoute(builder: (_) => BookingDetailsService());
      case '/ForgetPassword':
        return MaterialPageRoute(builder: (_) => ForgetPasswordWidget());
      case '/UpdatePassword':
        return MaterialPageRoute(builder: (_) => UpdatePasswordWidget(email: args,));
      case '/Pages':
        return MaterialPageRoute(builder: (_) => PagesWidget(currentTab: args));
      case '/Profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/Map':
        return MaterialPageRoute(
            builder: (_) => MapWidget(
                  orderId: args.toString(),
                ));
      case '/uploadPrescription':
        return MaterialPageRoute(builder: (_) => UploadPrescription());
      case '/Checkout':
        return MaterialPageRoute(builder: (_) => CheckoutPage());
      case '/EmptyList':
        return MaterialPageRoute(builder: (_) => EmptyList());
      case '/ProductList':
        print(args);
        return MaterialPageRoute(builder: (_) => ProductList(pageType: args));
      case '/MainPage':
        return MaterialPageRoute(builder: (_) => MainPage());
      case '/OtpVerification':
        return MaterialPageRoute(builder: (_) => OtpVerification());
      case '/OtpVerificationEmail':
        return MaterialPageRoute(builder: (_) => OtpVerificationEmail());
      case '/Orders':
        return MaterialPageRoute(builder: (_) => OrdersWidget());
      case '/TableBookings':
        return MaterialPageRoute(builder: (_) => BookingsWidget());
      case '/ApplyCoupon':
        return MaterialPageRoute(builder: (_) => ApplyCoupon());
      case '/Store':
        return MaterialPageRoute(builder: (_) => Stores(storeType: args));
      case '/StoreView':
        return MaterialPageRoute(
            builder: (_) => StoreViewDetails(shopDetails: args));
      case '/GroceryStore':
        return MaterialPageRoute(
            builder: (_) => GroceryStoreWidget(shopDetails: args));
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
      case '/HThankyou':
        return MaterialPageRoute(builder: (_) => HThankyou());
      case '/WThankyou':
        return MaterialPageRoute(builder: (_) => WThankyou());
      case '/Thankyou':
        return MaterialPageRoute(
            builder: (_) => Thankyou(
                  orderId: args,
                ));

      case '/searchLocation':
        return MaterialPageRoute(builder: (_) => SearchLocationTest());
      case '/Settings':
        return MaterialPageRoute(builder: (_) => SettingsWidget());
      case '/Settings':
        return MaterialPageRoute(builder: (_) => SettingsWidget());
      case '/ShopRating':
        return MaterialPageRoute(
            builder: (_) => ShopRating(
                  invoiceDetailsData: args,
                ));
      case '/CategoryProduct':
        return MaterialPageRoute(builder: (_) {
          return CategoryProduct(categoryData: args);
        });

      case '/location':
        return MaterialPageRoute(builder: (_) => LocationDetector());
      case '/searchLocation':
        return MaterialPageRoute(builder: (_) => SearchLocation());
      case '/Chat':
        return MaterialPageRoute(builder: (_) => ChatPage());
      case '/Payment':
        return MaterialPageRoute(builder: (_) => PaymentPage());
      case '/Sendpackage':
        return MaterialPageRoute(builder: (_) => SendPackage());
      case '/introscreen':
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case '/tutorialscreen':
        return MaterialPageRoute(builder: (_) => TutorialScreen());
      case '/AnimatedScreen':
        return MaterialPageRoute(
            builder: (_) => AnimatedScreen(
                  isFirst: args,
                ));
      case '/booktracking':
        return MaterialPageRoute(
            builder: (_) => BookingTrack(productDetails: args));

      case '/register':
        return MaterialPageRoute(builder: (_) => Register());
      case '/category_products':
        return MaterialPageRoute(builder: (_) => CategoryProducts());
      case '/wallet':
        return MaterialPageRoute(builder: (_) => WalletPage());
      case '/Recharge':
        return MaterialPageRoute(builder: (_) => RechargePage());
      case '/TransactionHistory':
        return MaterialPageRoute(builder: (_) => WalletTransactionHistory());
      case '/H_subcategory':
        return MaterialPageRoute(builder: (_) => SubCategory());
      case '/H_category':
        return MaterialPageRoute(builder: (_) => HCategory());
      case '/H_schedule':
        return MaterialPageRoute(builder: (_) => TimeDatePage());
      case '/H_All_provider':
        return MaterialPageRoute(
            builder: (_) => AllProvider(
                  providerList: args,
                ));
      case '/H_Service':
        return MaterialPageRoute(
            builder: (_) => ServicesPage(
                  providerData: args,
                ));
      case '/H_Booking':
        return MaterialPageRoute(builder: (_) => BookConfirmation());
      case '/H_MyBooking':
        return MaterialPageRoute(builder: (_) => MyBookings());
      case '/H_BookingDetails':
        return MaterialPageRoute(builder: (_) => BookingTrack1());
      case '/mapH':
        return MaterialPageRoute(builder: (_) => MapWidgetH());
      case '/My_FavoriteStore':
        return MaterialPageRoute(builder: (_) => StoresFavorite());
      case '/topUp':
        return MaterialPageRoute(builder: (_) => TopUpPage());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
