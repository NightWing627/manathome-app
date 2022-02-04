import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../helpers/helper.dart';
import '../repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../repository/order_repository.dart' as OrderRepo;

class ReviewsController extends ControllerMVC {
  Review marketReview = new Review();
  List<Review> productsReviews = [];
  List<Product> productsOfOrder = [];
  GlobalKey<ScaffoldState> scaffoldKeyRating;
  OverlayEntry loader;
  ReviewsController() {
    loader = Helper.overlayLoader(context);
    this.scaffoldKeyRating = new GlobalKey<ScaffoldState>();
  }

  updateReview() {
    if (marketReview.review != null && marketReview.rate != 0.0) {
      marketReview.user_id = currentUser.value.id;
      Overlay.of(context).insert(loader);
      OrderRepo.addProductReview(marketReview).then((value) {

        showToast("Thank you for give your rating", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        Navigator.pop(context, 'success');
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    } else {
      showToast("lease give your rating", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);

    }
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }
}
