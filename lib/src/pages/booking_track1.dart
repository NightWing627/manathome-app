import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/elements/CircularLoadingWidget.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../Animation/FadeAnimation.dart';

import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';

final stateBloc = StateBloc();
// ignore: must_be_immutable
class BookingTrack1 extends StatelessWidget {
  final Map<String, dynamic> dish;
  String bookId;
  // final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  BookingTrack1({this.dish, this.bookId});

  //Bookingmodel bookdetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutStarts(
        dish: dish,
        bookId: bookId,
      ),
      /** floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
          key: fabKey,
          // Cannot be `Alignment.center`
          alignment: Alignment.bottomRight,
          ringColor: Colors.white.withAlpha(25),
          ringDiameter: 300.0,
          ringWidth: 150.0,
          fabSize: 64.0,
          fabElevation: 8.0,
          fabIconBorder: CircleBorder(),

          fabColor: Colors.blue,
          fabOpenIcon: Icon(Icons.flash_on, color: Colors.white),
          fabCloseIcon: Icon(Icons.close, color: Colors.white),
          fabMargin: const EdgeInsets.all(30.0),
          animationDuration: const Duration(milliseconds: 800),

          onDisplayChange: (isOpen) {},
          children: <Widget>[
          RawMaterialButton(
          onPressed: () {
          _callNumber();
          },
          elevation: 2.0,
          fillColor: Colors.green,
          child: Icon(
          Icons.call,
          size: 28.0,
          color: Colors.white,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
          ),
          RawMaterialButton(
          onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatDetailPage(
          providerId: currentBookView.value.providerid,
          providerName: currentBookView.value.providename,
          providerMobile: currentBookView.value.providermobile)));
          },
          elevation: 2.0,
          fillColor: Colors.green,
          child: Icon(
          Icons.chat,
          size: 28.0,
          color: Colors.white,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
          ),
          ],
          ),
          ), */
    );
  }

/**_callNumber() async {
    String number = currentBookView.value.providermobile; //set the number here
    bool res = await FlutterPhoneDirectCaller.callNumber(number);
    } */
}
// ignore: must_be_immutable
class LayoutStarts extends StatelessWidget {
  final Map<String, dynamic> dish;
  String bookId;

  LayoutStarts({this.dish, this.bookId});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarCarousel(bookId: bookId),
        CustomBottomSheet(context: context, dish: dish, bookId: bookId),
      ],
    );
  }
}
// ignore: must_be_immutable
class CarCarousel extends StatefulWidget {
  final Map<String, dynamic> dish;
  String bookId;

  CarCarousel({this.dish, this.bookId});

  @override
  _CarCarouselState createState() => _CarCarouselState();
}

class _CarCarouselState extends State<CarCarousel> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color:Theme.of(context).primaryColorDark
        ),
        child: Stack(
          children: <Widget>[
            // ignore: missing_required_param

            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 27.0, left: 10.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 20.0),
                      Text(S.of(context).booking_track,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                blurRadius: 50,
                                color: Color(0xFF000000),
                                offset: Offset(0, 0),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("HService")
                        .where("bookId", isEqualTo:  currentBookView.value.bookId ).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return CircularLoadingWidget(height: 500);
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 16),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              DocumentSnapshot course = snapshot.data
                                  .docs[index];
                              return Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(40.0)),
                                      color: Color(0xFFf2f2f2)),
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20.0,
                                              right: 20.0,
                                              top: 20.0,
                                              bottom: 0.0),
                                          child: Text(
                                            '#${course['bookId']}',
                                            textAlign: TextAlign.center,
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .subtitle1,
                                          )),
                                      SizedBox(height: 5),
                                      Padding(
                                        padding: EdgeInsets.only(left: 30.0,
                                            right: 30.0,
                                            bottom: 8.0,
                                            top: 0.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Row(mainAxisAlignment: MainAxisAlignment
                                                .center, children: [
                                              Container(
                                                  height: 50,
                                                  width: course['status'] ==
                                                      'ontheway' ||
                                                      course['status'] ==
                                                          'pending'
                                                      ? 80
                                                      : course['status'] ==
                                                      'processing' ? 90 : 50,
                                                  decoration: new BoxDecoration(
                                                      image: new DecorationImage(
                                                        image: course['status'] ==
                                                            'pending'
                                                            ? AssetImage(
                                                            "assets/img/waiting.gif")
                                                            : course['status'] ==
                                                            'accepted'
                                                            ? AssetImage(
                                                            "assets/img/my_marker.png")
                                                            : course['status'] ==
                                                            'ontheway'
                                                            ? AssetImage(
                                                            "assets/img/onthway.gif")
                                                            : course['status'] ==
                                                            'processing'
                                                            ? AssetImage(
                                                            "assets/img/processing.gif")
                                                            : course['status'] ==
                                                            'paymentPending'
                                                            ? AssetImage(
                                                            "assets/img/completed.png")
                                                            : course['status'] ==
                                                            'Success'
                                                            ? AssetImage(
                                                            "assets/img/complete.jpg")
                                                            : course['status'] ==
                                                            'rejected'
                                                            ? AssetImage(
                                                            "assets/img/rejected.png")
                                                            : null,
                                                        fit: BoxFit.fill,
                                                      ))),
                                            ]),
                                            course['status'] ==
                                                'paymentPending' ||
                                                course['status'] == 'Success'
                                                ? Padding(
                                              padding: EdgeInsets.only(
                                                  left: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.1,
                                                  right: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.1,
                                                  bottom: 20.0,
                                                  top: 0.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                  SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Column(
                                                          children: <Widget>[
                                                            Text(
                                                              S
                                                                  .of(context)
                                                                  .hours,
                                                            ),
                                                            Text(
                                                              course['workedHrs'],
                                                              style: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .caption
                                                                  .merge(
                                                                  TextStyle(
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .colorScheme
                                                                          .secondary,
                                                                      fontWeight: FontWeight
                                                                          .w600)),
                                                            ),
                                                            Text(
                                                              course['workedHrs'],
                                                              style: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .caption
                                                                  .merge(
                                                                  TextStyle(
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .colorScheme
                                                                          .secondary,
                                                                      fontWeight: FontWeight
                                                                          .w600)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .only(top: 5),
                                                        child: Text('RM',
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight: FontWeight
                                                                    .w500)),
                                                      ),
                                                      Text(course['grandTotal']
                                                          .toString(),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black,
                                                              fontWeight: FontWeight
                                                                  .w500)),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            _showAlert(context,
                                                                course['bookId']);
                                                          },
                                                          child: Container(
                                                              child: Image(
                                                                image: AssetImage(
                                                                  'assets/img/bookmark.png',
                                                                ),
                                                                width: 50,
                                                                height: 50,
                                                                fit: BoxFit
                                                                    .fitHeight,
                                                              ))),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ));
                            });
                      }
                    }),

              ]),
            ),
          ],
        ),
      );
  }
}

///////////////////
// ignore: must_be_immutable
class CustomBottomSheet extends StatefulWidget {
  BuildContext context;
  final Map<String, dynamic> dish;
  String bookId;

  CustomBottomSheet({this.context, this.dish, this.bookId});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> with SingleTickerProviderStateMixin {
  double sheetTop;

  double minSheetTop = 30;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    double sheetTop = MediaQuery.of(widget.context).size.height * 0.37;
    double minSheetTop = 30;
    controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: sheetTop, end: minSheetTop).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      });
  }

  forwardAnimation() {
    controller.forward();
    stateBloc.toggleAnimation();
  }

  reverseAnimation() {
    controller.reverse();
    stateBloc.toggleAnimation();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: animation.value,
      left: 0,
      child: GestureDetector(
        onTap: () {
          controller.isCompleted ? reverseAnimation() : forwardAnimation();
        },
        onVerticalDragEnd: (DragEndDetails dragEndDetails) {
          //upward drag
          if (dragEndDetails.primaryVelocity < 0.0) {
            forwardAnimation();
            controller.forward();
          } else if (dragEndDetails.primaryVelocity > 0.0) {
            reverseAnimation();
          } else {
            return;
          }
        },
        child: SheetContainer(dish: widget.dish, bookId: widget.bookId),
      ),
    );
  }
}

// ignore: must_be_immutable
class SheetContainer extends StatelessWidget {

  String bookId;


  final Map<String, dynamic> dish;

  SheetContainer({this.dish, this.bookId});

  int checkedItem = 0;

  ScrollController scrollController = ScrollController(initialScrollOffset: 0);

  bool isFav = false;
  bool isReadless = false;

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(40)), color: Theme.of(context).primaryColor),
      child: Column(
        children: <Widget>[
          drawerHandle(),
          Expanded(
            flex: 1,
            child: ListView(
              padding: EdgeInsets.only(left: 15),
              children: <Widget>[
                /* start Booking status part */
                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("HService").where("bookId", isEqualTo: currentBookView.value.bookId).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError || snapshot.data == null) {
                        return Container();
                      }
                      int timeInMillis = snapshot.data.docs[0]['bookingTime'];
                      var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
                      var formattedDate = DateFormat.d().format(date);
                      var formattedmonth = DateFormat.MMM().format(date);
                      var formattedyear = DateFormat.y().format(date);
                      var time = DateFormat('HH:mm').format(date);
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 30.0, bottom: 20.0, top: 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).booking_statuts,
                                      style: Theme.of(context).textTheme.subtitle2,
                                    ),
                                    Text(
                                      S.of(context).price_hr,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data.docs[0]['status'],
                                      style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14, fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'RM ${snapshot.data.docs[0]['chargeperhrs']}',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 30.0, bottom: 20.0, top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).date_and_time,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$formattedDate.$formattedmonth.$formattedyear $time',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).address,
                                      style: Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          snapshot.data.docs[0]['address'],
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    '${S.of(context).booking_tracking_system_title}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),

                /* start timeline part */
                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("HStatusManager").where("bookId", isEqualTo: currentBookView.value.bookId).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError || snapshot.data == null) {
                        return Container();
                      } else {
                        final f = new DateFormat('yyyy-MM-dd hh:mm');
                        bool serviceBook = snapshot.data.docs[0]['serviceBooked'];
                        bool serviceAccepted = snapshot.data.docs[0]['serviceAccepted'];
                        bool startedCustomerPlaced = snapshot.data.docs[0]['startedCustomerPlaced'];
                        bool providerArrived = snapshot.data.docs[0]['providerArrived'];
                        bool jobStarted = snapshot.data.docs[0]['jobStarted'];
                        bool jobCompleted = snapshot.data.docs[0]['jobCompleted'];

                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 40),
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                FadeAnimation(
                                  1,
                                  TimelineTile(
                                    alignment: TimelineAlign.start,
                                    isFirst: true,
                                    indicatorStyle: const IndicatorStyle(
                                      width: 20,
                                      color: Colors.green,
                                    ),
                                    beforeLineStyle: LineStyle(
                                      color: serviceAccepted ? Colors.green : Color(0xFFe4e4e4),
                                      thickness: 6,
                                    ),
                                    endChild: Container(
                                      constraints: const BoxConstraints(
                                        minHeight: 80,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    S.of(context).service_booked,
                                                    style: Theme.of(context).textTheme.subtitle2,
                                                  ),
                                                ),
                                                Container(
                                                  child: serviceBook
                                                      ? Text(
                                                    f.format(new DateTime.fromMicrosecondsSinceEpoch(
                                                        snapshot.data.docs[0]['serviceBookedTime'] * 1000)),
                                                    style: Theme.of(context).textTheme.caption,
                                                  )
                                                      : Text(''),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                FadeAnimation(
                                    1.8,
                                    TimelineTile(
                                      alignment: TimelineAlign.start,
                                      beforeLineStyle: LineStyle(
                                        color: serviceAccepted ? Colors.green : Color(0xFFe4e4e4),
                                        thickness: 6,
                                      ),
                                      afterLineStyle: LineStyle(
                                        color: startedCustomerPlaced ? Colors.green : Color(0xFFe4e4e4),
                                        thickness: 6,
                                      ),
                                      indicatorStyle: IndicatorStyle(
                                        width: 20,
                                        color: serviceAccepted ? Colors.green : Color(0xFFe4e4e4),
                                      ),
                                      endChild: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 80,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      S.of(context).service_accepted,
                                                      style: Theme.of(context).textTheme.subtitle2,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: serviceAccepted
                                                        ? Text(
                                                      f.format(new DateTime.fromMicrosecondsSinceEpoch(
                                                          snapshot.data.docs[0]['serviceAcceptedTime'] * 1000)),
                                                      style: Theme.of(context).textTheme.caption,
                                                    )
                                                        : Text(''),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                FadeAnimation(
                                    1.8,
                                    TimelineTile(
                                      alignment: TimelineAlign.start,
                                      beforeLineStyle: LineStyle(
                                        color: startedCustomerPlaced ? Colors.green : Color(0xFFe4e4e4),
                                        thickness: 6,
                                      ),
                                      afterLineStyle: LineStyle(
                                        color: providerArrived ? Colors.green : Color(0xFFe4e4e4),
                                        thickness: 6,
                                      ),
                                      indicatorStyle: IndicatorStyle(
                                        width: 20,
                                        color: startedCustomerPlaced ? Colors.green : Color(0xFFe4e4e4),
                                      ),
                                      endChild: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 80,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      S.of(context).started_to_customer_place,
                                                      style: Theme.of(context).textTheme.subtitle2,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: startedCustomerPlaced
                                                        ? Text(
                                                      f.format(new DateTime.fromMicrosecondsSinceEpoch(
                                                          snapshot.data.docs[0]['startedCustomerPlacedTime'] * 1000)),
                                                      style: Theme.of(context).textTheme.caption,
                                                    )
                                                        : Text(''),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                FadeAnimation(
                                    1.8,
                                    TimelineTile(
                                      alignment: TimelineAlign.start,
                                      beforeLineStyle: LineStyle(
                                        color: providerArrived ? Colors.green : Color(0xFFe4e4e4),
                                        thickness: 6,
                                      ),
                                      afterLineStyle: LineStyle(
                                        color: jobStarted ? Colors.green : Color(0xFFe4e4e4),
                                        thickness: 6,
                                      ),
                                      indicatorStyle: IndicatorStyle(
                                        width: 20,
                                        color: providerArrived ? Colors.green : Color(0xFFe4e4e4),
                                      ),
                                      endChild: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 80,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      S.of(context).provider_arrived,
                                                      style: Theme.of(context).textTheme.subtitle2,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: providerArrived
                                                        ? Text(
                                                      f.format(new DateTime.fromMicrosecondsSinceEpoch(
                                                          snapshot.data.docs[0]['providerArrivedTime'] * 1000)),
                                                      style: Theme.of(context).textTheme.caption,
                                                    )
                                                        : Text(''),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                FadeAnimation(
                                    1.8,
                                    TimelineTile(
                                      alignment: TimelineAlign.start,
                                      beforeLineStyle: LineStyle(
                                        color: jobStarted ? Colors.green : Color(0xFFe4e4e4),
                                        thickness: 6,
                                      ),
                                      afterLineStyle: LineStyle(
                                        color: jobCompleted ? Colors.green : Color(0xFFe4e4e4),
                                        thickness: 6,
                                      ),
                                      indicatorStyle: IndicatorStyle(
                                        width: 20,
                                        color: jobStarted ? Colors.green : Color(0xFFe4e4e4),
                                      ),
                                      endChild: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 80,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      S.of(context).job_started,
                                                      style: Theme.of(context).textTheme.subtitle2,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: jobStarted
                                                        ? Text(
                                                      f.format(new DateTime.fromMicrosecondsSinceEpoch(
                                                          snapshot.data.docs[0]['jobStartedTime'] * 1000)),
                                                      style: Theme.of(context).textTheme.caption,
                                                    )
                                                        : Text(''),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                FadeAnimation(
                                    1.8,
                                    TimelineTile(
                                      alignment: TimelineAlign.start,
                                      isLast: true,
                                      beforeLineStyle: LineStyle(
                                        color: jobCompleted ? Colors.green : Color(0xFFe4e4e4),
                                        thickness: 6,
                                      ),
                                      indicatorStyle: IndicatorStyle(
                                        width: 20,
                                        color: jobCompleted ? Colors.green : Color(0xFFe4e4e4),
                                      ),
                                      endChild: Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 80,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      S.of(context).job_completed,
                                                      style: Theme.of(context).textTheme.subtitle2,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: jobCompleted
                                                        ? Text(
                                                      f.format(new DateTime.fromMicrosecondsSinceEpoch(
                                                          snapshot.data.docs[0]['jobCompletedTime'] * 1000)),
                                                      style: Theme.of(context).textTheme.caption,
                                                    )
                                                        : Text(''),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        );
                      }
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  drawReviewTile(context, name, asset) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage(asset))),
          ),
          SizedBox(
            width: 15,
          ),
          /*Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  name,
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'This is the best food you can ever try Delicious and Have a nice plating and the service and delivery was really quickly',
                  softWrap: true,
                  maxLines: 3,
                )
              ],
            ),
          ),*/
        ],
      ),
    );
  }

  drawerHandle() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 3,
      width: 65,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Color(0xffd9dbdb)),
    );
  }
}

class StateBloc {
  StreamController animationController = StreamController.broadcast();
  final StateProvider provider = StateProvider();

  Stream get animationStatus => animationController.stream;

  void toggleAnimation() {
    provider.toggleAnimationValue();
    animationController.sink.add(provider.isAnimating);
  }

  void dispose() {
    animationController.close();
  }
}

class StateProvider {
  bool isAnimating = true;

  void toggleAnimationValue() => isAnimating = !isAnimating;
}

void _showAlert(BuildContext context, bookId) {
  showDialog(context: context, barrierDismissible: true, builder: (context) => BillingDetailsPopup(bookId: bookId));
}
// ignore: must_be_immutable
class BillingDetailsPopup extends StatefulWidget {
  BillingDetailsPopup({Key key, this.bookId}) : super(key: key);
  String bookId;

  @override
  _BillingDetailsPopupState createState() => _BillingDetailsPopupState();
}

class _BillingDetailsPopupState extends StateMVC<BillingDetailsPopup> {


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
      insetPadding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.01,
          left: MediaQuery.of(context).size.width * 0.03,
          right: MediaQuery.of(context).size.width * 0.03,
          bottom: MediaQuery.of(context).size.width * 0.03),
    );
  }

  _buildChild(BuildContext context) => SingleChildScrollView(
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(12))),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("payment").where("bookingId", isEqualTo: widget.bookId).snapshots(),
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    S.of(context).payment_details,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        S.of(context).bill_details,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).provider_name, style: Theme.of(context).textTheme.subtitle2),
                              Text(snapshot.data.documents[0]['providerName'], style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).billing_name, style: Theme.of(context).textTheme.subtitle2),
                              Container(
                                  width: 200,
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                                    Text(snapshot.data.documents[0]['billingName'],
                                        overflow: TextOverflow.ellipsis, maxLines: 2, style: Theme.of(context).textTheme.subtitle2),
                                  ]))
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).booking_id, style: Theme.of(context).textTheme.subtitle2),
                              Text(snapshot.data.documents[0]['bookingId'], style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).date, style: Theme.of(context).textTheme.subtitle2),
                              Text(snapshot.data.documents[0]['date'], style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).worked_hours, style: Theme.of(context).textTheme.subtitle2),
                              Text('${snapshot.data.documents[0]['workedHours']} hrs', style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).time, style: Theme.of(context).textTheme.subtitle2),
                              Text('08:00 hrs', style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).price, style: Theme.of(context).textTheme.subtitle2),
                              Text('RM ${snapshot.data.documents[0]['total']}', style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                          SizedBox(height: 12),
                          snapshot.data.documents[0]['miscellaneousAmount'] != 0
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/viewItemDetails', arguments: snapshot.data.documents[0]);
                                },
                                child: Text(S.of(context).miscellaneous_amount, style: Theme.of(context).textTheme.subtitle2),
                              ),
                              Text('RM ${snapshot.data.documents[0]['miscellaneousAmount']}', style: Theme.of(context).textTheme.subtitle2),
                            ],
                          )
                              : Row(),
                        ]),
                      ),
                    ),
                  ]),
                ),
                SizedBox(height: 8),
                Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tax', style: Theme.of(context).textTheme.subtitle2),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('GST ${snapshot.data.documents[0]['tax']}%', style: Theme.of(context).textTheme.subtitle2),
                              Text('RM ${snapshot.data.documents[0]['taxAmount']}', style: Theme.of(context).textTheme.subtitle2),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Service com ${snapshot.data.documents[0]['commission']}%', style: Theme.of(context).textTheme.subtitle2),
                              Text('RM ${snapshot.data.documents[0]['commissionAmount']}', style: Theme.of(context).textTheme.subtitle2)
                            ],
                          ),
                        ]),
                      ),
                    )),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).discount, style: TextStyle(fontSize: 18, color: Colors.grey)),
                        Text('RM 0.00', style: TextStyle(fontSize: 18, color: Colors.cyanAccent[700]))
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).total, style: TextStyle(fontSize: 18, color: Colors.grey)),
                        Text('RM ${snapshot.data.documents[0]['grandTotal']}',
                            style: TextStyle(
                              fontSize: 18,
                            ))
                      ],
                    ),
                    SizedBox(height: 20),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        return Navigator.of(context).pop(true);
                      },
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 100),
                      color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                      shape: StadiumBorder(),
                      child: Text(
                        S.of(context).close,
                        style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                      ),
                    ),
                    SizedBox(height: 20),
                  ]),
                ),
              ],
            );
          }),
    ),
  );
}
