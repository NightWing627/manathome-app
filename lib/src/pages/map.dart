import 'package:after_layout/after_layout.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/models/driver_rating.dart';
import 'package:multisuperstore/src/models/payment.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toast/toast.dart';
import '../components/directions_model.dart';
import '../components/directions_repository.dart';
import '../helpers/helper.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import 'cancel.dart';
import 'Widget/custom_divider_view.dart';
import '../repository/order_repository.dart' as repository;

// ignore: must_be_immutable
class MapWidget extends StatefulWidget {
  String orderId;
  String pageType;
  MapWidget({Key key, this.orderId, this.pageType}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget>
    with AfterLayoutMixin<MapWidget> {
  final double _initFabHeight = 170.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 150.0;
  Payment paymentData = new Payment();

  DriverRatingModel driverData = new DriverRatingModel();

  var _initialCameraPosition = CameraPosition(
    target: LatLng(currentUser.value.latitude, currentUser.value.longitude),
    zoom: 17.5,
  );

  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _destination;
  Directions _info;
  String status;

  List<LatLng> latlng = <LatLng>[];
  bool timerLimit = true;
  BitmapDescriptor customIcon;
  @override
  void initState() {
    if (widget.pageType == 'viewDetails') {
      timerLimit = false;
    }

    listenForPaymentDetails(widget.orderId);

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(5, 5)), 'assets/img/shop.png')
        .then((d) {
      customIcon = d;

      getTrackDetails();
    });

    super.initState();
  }

  listenForPaymentDetails(id) async {
    repository.PaymentDetails(id)
        .then((value) {
          setState(() {
            paymentData = value;
          });
          print('subtotal');
          print(value.delivery_fees);
          print(paymentData.sub_total);
        })
        .catchError((e) {})
        .whenComplete(() {});
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  getTrackDetails() {
    FirebaseFirestore.instance
        .collection("orderDetails")
        .where("orderId", isEqualTo: widget.orderId)
        .snapshots()
        .listen((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()["status"] == 'Completed') {
          // Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);

        } else if (result.data()["status"] == 'Shipped') {
          BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(5, 5)),
                  'assets/img/deliveryboy.png')
              .then((d) {
            setState(() {
              customIcon = d;
            });

            LatLng _driver = LatLng(
                result.data()["shopLatitude"], result.data()["shopLongitude"]);
            LatLng _destination = LatLng(result.data()["originLatitude"],
                result.data()["originLongitude"]);
            latlng.add(_driver);
            latlng.add(_destination);
            _addMarker(_driver);
            _addMarker(_destination);
          });
        } else {
          LatLng _driver = LatLng(
              result.data()["shopLatitude"], result.data()["shopLongitude"]);
          LatLng _destination = LatLng(result.data()["originLatitude"],
              result.data()["originLongitude"]);
          latlng.add(_driver);
          latlng.add(_destination);
          _addMarker(_driver);
          _addMarker(_destination);
        }
      });
    });
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeLeft: true,
      removeRight: true,
      child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            controller: sc,
            children: <Widget>[
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("orderDetails")
                      .where("orderId", isEqualTo: widget.orderId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.data.docs[0]['status'] == 'Placed' &&
                            timerLimit == false
                        ? Container(
                            padding: EdgeInsets.only(
                                left: 18, right: 18, bottom: 18),
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Icon(Icons.card_membership),
                                    ),
                                    Container(
                                        height: 15,
                                        color: Colors.blue,
                                        padding: EdgeInsets.all(3),
                                        child: Center(
                                            child: Text(
                                          'LIVE',
                                          style: TextStyle(
                                              fontSize: 7,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor),
                                        ))),
                                  ],
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10, top: 30),
                                      child: Text(
                                        'Ordine ricevuto',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: Text(
                                        'Order is placed successfully',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                  ],
                                )),
                                Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: CachedNetworkImage(
                                    // ignore: deprecated_member_use
                                    imageUrl:
                                        "${GlobalConfiguration().getString('api_base_url')}/uploads/vendor_image/vendor_${snapshot.data.docs[0]['shopId']}.png",
                                    placeholder: (context, url) =>
                                        new CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        new Icon(Icons.error),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ],
                            ))
                        : snapshot.data.docs[0]['status'] == 'Placed' &&
                                timerLimit == true
                            ? Container(
                                padding: EdgeInsets.only(
                                    left: 18, right: 18, bottom: 18),
                                color: Theme.of(context).primaryColor,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Icon(Icons.card_membership),
                                        ),
                                        Container(
                                            height: 15,
                                            color: Colors.blue,
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Center(
                                                child: Text(
                                              'LIVE',
                                              style: TextStyle(
                                                  fontSize: 7,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor),
                                            ))),
                                      ],
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              color: Colors.transparent,
                                              child: Center(
                                                child: Card(
                                                  elevation: 5,
                                                  shape: StadiumBorder(),
                                                  color: Colors.transparent,
                                                  // ignore: deprecated_member_use
                                                  child: FlatButton(
                                                    onPressed: () {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'orderDetails')
                                                          .doc(widget.orderId)
                                                          .update({
                                                        'status': 'cancelled'
                                                      }).catchError((e) {
                                                        print(e);
                                                      });
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      CancelPage(
                                                                        paymentData:
                                                                            paymentData,
                                                                        shopName: snapshot
                                                                            .data
                                                                            .docs[0]['shopName'],
                                                                        orderId:
                                                                            widget.orderId,
                                                                        shopId: snapshot
                                                                            .data
                                                                            .docs[0]['shopId'],
                                                                      )));
                                                    },
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12,
                                                            horizontal: 28),
                                                    color: Colors.red,
                                                    shape: StadiumBorder(),
                                                    child: Text(
                                                      S.of(context).cancel,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          .merge(TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorLight,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: Text(
                                            'After count down end cant be cancelled',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ),
                                      ],
                                    )),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: CircularCountDownTimer(
                                        duration: setting.value.cancel_timer,
                                        controller: CountDownController(),
                                        width: 60,
                                        height: 60,
                                        color: Colors.grey[300],
                                        fillColor: Colors.red,
                                        strokeWidth: 5.0,
                                        strokeCap: StrokeCap.round,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .merge(
                                                TextStyle(color: Colors.red)),
                                        textFormat: CountdownTextFormat.SS,
                                        isReverse: true,
                                        isReverseAnimation: true,
                                        isTimerTextShown: true,
                                        autoStart: true,
                                        onStart: () {
                                          print('Countdown Started');
                                        },
                                        onComplete: () {
                                          setState(() {
                                            timerLimit = false;
                                          });
                                          print('Countdown Ended');
                                        },
                                      ),
                                    ),
                                  ],
                                ))
                            : snapshot.data.docs[0]['status'] == 'Placed' &&
                                    timerLimit == true
                                ? Container(
                                    padding: EdgeInsets.only(
                                        left: 18, right: 18, bottom: 18),
                                    color: Theme.of(context).primaryColor,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child:
                                                  Icon(Icons.card_membership),
                                            ),
                                            Container(
                                                height: 15,
                                                color: Colors.blue,
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Center(
                                                    child: Text(
                                                  'LIVE',
                                                  style: TextStyle(
                                                      fontSize: 7,
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor),
                                                ))),
                                          ],
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10, top: 10),
                                              child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15,
                                                  color: Colors.transparent,
                                                  child: Center(
                                                    child: Card(
                                                      elevation: 5,
                                                      shape: StadiumBorder(),
                                                      color: Colors.transparent,
                                                      // ignore: deprecated_member_use
                                                      child: FlatButton(
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'orderDetails')
                                                              .doc(widget
                                                                  .orderId)
                                                              .update({
                                                            'status':
                                                                'cancelled'
                                                          }).catchError((e) {
                                                            print(e);
                                                          });
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          CancelPage(
                                                                            paymentData:
                                                                                paymentData,
                                                                            shopName:
                                                                                snapshot.data.docs[0]['shopName'],
                                                                            orderId:
                                                                                widget.orderId,
                                                                            shopId:
                                                                                snapshot.data.docs[0]['shopId'],
                                                                          )));
                                                        },
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 12,
                                                                horizontal: 28),
                                                        color: Colors.red,
                                                        shape: StadiumBorder(),
                                                        child: Text(
                                                          S.of(context).cancel,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .caption
                                                              .merge(TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColorLight,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                              ),
                                              child: Text(
                                                'After count down end cant be cancelled',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                            ),
                                          ],
                                        )),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 10,
                                          ),
                                          child: CircularCountDownTimer(
                                            duration:
                                                setting.value.cancel_timer,
                                            controller: CountDownController(),
                                            width: 60,
                                            height: 60,
                                            color: Colors.grey[300],
                                            fillColor: Colors.red,
                                            strokeWidth: 5.0,
                                            strokeCap: StrokeCap.round,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .merge(TextStyle(
                                                    color: Colors.red)),
                                            textFormat: CountdownTextFormat.SS,
                                            isReverse: true,
                                            isReverseAnimation: true,
                                            isTimerTextShown: true,
                                            autoStart: true,
                                            onStart: () {
                                              print('Countdown Started');
                                            },
                                            onComplete: () {
                                              setState(() {
                                                timerLimit = false;
                                              });
                                              print('Countdown Ended');
                                            },
                                          ),
                                        ),
                                      ],
                                    ))
                                : snapshot.data.docs[0]['status'] == 'Accepted'
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            left: 18, right: 18, bottom: 18),
                                        color: Theme.of(context).primaryColor,
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  child: Icon(
                                                      Icons.card_membership),
                                                ),
                                                Container(
                                                    height: 15,
                                                    color: Colors.brown,
                                                    padding: EdgeInsets.all(3),
                                                    child: Center(
                                                        child: Text(
                                                      'LIVE',
                                                      style: TextStyle(
                                                          fontSize: 7,
                                                          color: Theme.of(
                                                                  context)
                                                              .scaffoldBackgroundColor),
                                                    ))),
                                              ],
                                            ),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 30),
                                                  child: Text(
                                                    'Ordine in preparazione',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                  ),
                                                  child: Text(
                                                    'Your order is being prepared now',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption,
                                                  ),
                                                ),
                                              ],
                                            )),
                                            Padding(
                                              padding: EdgeInsets.only(top: 30),
                                              child: CachedNetworkImage(
                                                // ignore: deprecated_member_use
                                                imageUrl:
                                                    "${GlobalConfiguration().getString('api_base_url')}/uploads/vendor_image/vendor_${snapshot.data.docs[0]['shopId']}.png",
                                                placeholder: (context, url) =>
                                                    new CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        new Icon(Icons.error),
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ],
                                        ))
                                    : snapshot.data.docs[0]['status'] ==
                                            'Packed'
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                left: 18,
                                                right: 18,
                                                bottom: 18),
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 20),
                                                      child: Icon(Icons
                                                          .card_membership),
                                                    ),
                                                    Container(
                                                        height: 15,
                                                        color: Colors.brown,
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        child: Center(
                                                            child: Text(
                                                          'LIVE',
                                                          style: TextStyle(
                                                              fontSize: 7,
                                                              color: Theme.of(
                                                                      context)
                                                                  .scaffoldBackgroundColor),
                                                        ))),
                                                  ],
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 30),
                                                      child: Text(
                                                        'Ordine pronto',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline1,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                      ),
                                                      child: Text(
                                                        'Your order is ready now',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 30),
                                                  child: CachedNetworkImage(
                                                    // ignore: deprecated_member_use
                                                    imageUrl:
                                                        "${GlobalConfiguration().getString('api_base_url')}/uploads/vendor_image/vendor_${snapshot.data.docs[0]['shopId']}.png",
                                                    placeholder: (context,
                                                            url) =>
                                                        new CircularProgressIndicator(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        new Icon(Icons.error),
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ],
                                            ))
                                        : snapshot.data.docs[0]['status'] ==
                                                'Shipped'
                                            ? Container(
                                                padding: EdgeInsets.only(
                                                    left: 18,
                                                    right: 18,
                                                    bottom: 18),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20),
                                                          child: Icon(Icons
                                                              .card_membership),
                                                        ),
                                                        Container(
                                                            height: 15,
                                                            color: Colors
                                                                .deepOrange,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3),
                                                            child: Center(
                                                                child: Text(
                                                              'LIVE',
                                                              style: TextStyle(
                                                                  fontSize: 7,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .scaffoldBackgroundColor),
                                                            ))),
                                                      ],
                                                    ),
                                                    Expanded(
                                                        child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 30),
                                                          child: Text(
                                                            'Processo di consegna iniziato',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline1,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                          ),
                                                          child: Text(
                                                            'Your order is picked up by ${snapshot.data.docs[0]['driverName']}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .caption,
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                    Badge(
                                                      position: BadgePosition
                                                          .bottomEnd(
                                                              bottom: -10,
                                                              end: -5),
                                                      badgeContent: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 25,
                                                        width: 25,
                                                        child: InkWell(
                                                          onTap: () {},
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.call,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                right: 10,
                                                                left: 10),
                                                        child:
                                                            CachedNetworkImage(
                                                          // ignore: deprecated_member_use
                                                          imageUrl:
                                                              "${GlobalConfiguration().getString('api_base_url')}/uploads/driver_image/driver_${snapshot.data.docs[0]['driverId']}.png",
                                                          placeholder: (context,
                                                                  url) =>
                                                              new CircularProgressIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              new Icon(
                                                                  Icons.error),
                                                          width: 50,
                                                          height: 50,
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                            : snapshot.data.docs[0]['status'] ==
                                                    'Delivered'
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        left: 18,
                                                        right: 18,
                                                        bottom: 18),
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    child: Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 20),
                                                              child: Icon(Icons
                                                                  .card_membership),
                                                            ),
                                                            Container(
                                                                height: 15,
                                                                color: Colors
                                                                    .green,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(3),
                                                                child: Center(
                                                                    child: Text(
                                                                  'LIVE',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          7,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .scaffoldBackgroundColor),
                                                                ))),
                                                          ],
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      top: 30),
                                                              child: Text(
                                                                'Order Is Delivered',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline1,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: 10,
                                                                right: 10,
                                                              ),
                                                              child: Text(
                                                                'Your order is delivered  by ${snapshot.data.docs[0]['driverName']}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 30),
                                                          child: Image(
                                                            image: AssetImage(
                                                              'assets/img/userImage6.jpeg',
                                                            ),
                                                            width: 50,
                                                            height: 50,
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                        ),
                                                      ],
                                                    ))
                                                : Container();
                  }),
              CustomDividerView(dividerHeight: 15.0),
              Container(
                padding: const EdgeInsets.all(20.0),
                color: Theme.of(context).primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(S.of(context).bill_details,
                        style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(S.of(context).item_total,
                            style: Theme.of(context).textTheme.subtitle2),
                        Text(Helper.pricePrint(paymentData.sub_total),
                            style: Theme.of(context).textTheme.subtitle2),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(S.of(context).discount,
                            style: Theme.of(context).textTheme.subtitle2),
                        Text(Helper.pricePrint(paymentData.discount),
                            style: Theme.of(context).textTheme.subtitle2),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(S.of(context).delivery_fee,
                                      style: TextStyle(color: Colors.blue)),
                                  Text(
                                      Helper.pricePrint(
                                          paymentData.delivery_fees),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                  S
                                      .of(context)
                                      .your_delivery_partner_is_travelling_long_distance_to_deliver_your_order,
                                  style: Theme.of(context).textTheme.caption),
                              SizedBox(height: 10),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(S.of(context).delivery_tip,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  Text(
                                      Helper.pricePrint(
                                          paymentData.delivery_tips),
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(height: 10),
                              /**    Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                  Text('Taxes and Charges', style: TextStyle(color: Colors.blue)),
                                  Text('\$ 54.00', style: Theme.of(context).textTheme.subtitle2),
                                  ],
                                  ), 
                                  **/
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      child: Row(
                        children: <Widget>[
                          Text(
                            S.of(context).to_pay,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Spacer(),
                          Text(
                            Helper.pricePrint(paymentData.grand_total),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .95;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          /**  leading: _con.currentMarket?.latitude == null
              ? new IconButton(
              icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
              onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
              )
              : IconButton(
              icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
              onPressed: () => Navigator.of(context).pushNamed('/Pages', arguments: 2),
              ), 
              **/
          title: Text(
            S.of(context).live_track,
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        body: Stack(
//        fit: StackFit.expand,
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            SlidingUpPanel(
              maxHeight: _panelHeightOpen,
              minHeight: _panelHeightClosed,
              parallaxEnabled: true,
              parallaxOffset: .5,
              panelBuilder: (sc) => _panel(sc),
              body: GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (controller) => _googleMapController = controller,
                markers: {
                  if (_origin != null) _origin,
                  if (_destination != null) _destination
                },
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: PolylineId('overview_polyline'),
                      color: Colors.black,
                      width: 4,
                      points: _info.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
              ),
              onPanelSlide: (double pos) => setState(() {
                _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                    _initFabHeight;
              }),
            ),
            Positioned(
                right: 20.0,
                bottom: _fabHeight,
                child: Container(
                    padding: EdgeInsets.all(5),
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black),
                    child: Column(
                      children: [
                        Text(S.of(context).item,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .primaryColorLight
                                    .withOpacity(0.6))),
                        SizedBox(height: 6),
                        _info == null
                            ? Text('--',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .merge(TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.w600)))
                            : Text('${_info.totalDuration}',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .merge(TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.w600))),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(3),
                            color: Theme.of(context).primaryColor,
                            width: 100,
                            child: Center(
                              child: Text(
                                S.of(context).on_time,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .merge(TextStyle(
                                        color:
                                            Theme.of(context).backgroundColor)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        print(customIcon);
        _origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: customIcon,
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout

    if (currentUser.value.apiToken != null) {
      FirebaseFirestore.instance
          .collection("orderDetails")
          .where("userId", isEqualTo: currentUser.value.id)
          .where("orderId", isEqualTo: widget.orderId)
          .where("status", isEqualTo: 'Completed')
          .snapshots()
          .listen((snapshot) {
        snapshot.docs.forEach((result) {
          ratingModel(
            context,
            result.data()['orderId'],
            result.data()['driverName'],
            result.data()['driverId'],
          );
        });
      });
    }
  }

  void ratingModel(context, orderID, driverName, driverId) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.8,
              color: Color(0xff737373),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40),
                      Image(
                          image: AssetImage('assets/img/rating.png'),
                          width: 100,
                          height: 100),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          right: 12,
                        ),
                        child: Text(
                          'Give us Rating',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 21.0,
                          right: 21,
                        ),
                        child: Text('Rate your deliver by $driverName',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle1.merge(
                                TextStyle(
                                    color: Theme.of(context).disabledColor))),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 17.0,
                          right: 17,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 30,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                                driverData.rate = rating;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('${S.of(context).booking_id}: $orderID',
                          style: Theme.of(context).textTheme.subtitle1),
                      SizedBox(height: 10),
                      Text('Tell us about the service'),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30.0,
                          right: 30,
                          top: 5,
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                              width: double.infinity,
                              height: 70,
                              child: TextField(
                                  textAlign: TextAlign.left,
                                  autocorrect: true,
                                  onChanged: (e) {
                                    driverData.message = e;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Comments',
                                    hintStyle:
                                        Theme.of(context).textTheme.caption,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey[300],
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 2.0,
                                      ),
                                    ),
                                  ))),
                        ),
                      ),
                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () {
                          driverData.orderId = orderID;
                          driverData.driver = driverId;
                          submitDriverRating();
                        },
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 100),
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(1),
                        shape: StadiumBorder(),
                        child: Text(
                          S.of(context).services,
                          style: Theme.of(context).textTheme.headline6.merge(
                              TextStyle(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  submitDriverRating() {
    driverData.buyer = currentUser.value.id;

    repository.updateDriverRating(driverData).then((value) {
      showToast("Your rating  is update successfully",
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    }).catchError((e) {
      print(e);
    }).whenComplete(() {});
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }
}
