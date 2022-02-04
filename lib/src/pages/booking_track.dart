import 'dart:async';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import '../helpers/helper.dart';
import '../Animation/FadeAnimation.dart';
import '../controllers/order_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../models/cart_responce.dart';
import '../models/order_track.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';
import '../../generated/l10n.dart';

final stateBloc = StateBloc();

// ignore: must_be_immutable
class BookingTrack extends StatelessWidget {
  final Map<String, dynamic> dish;
  CartResponce productDetails;
  BookingTrack({this.dish, this.productDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutStarts(
        dish: dish,
        productDetails: productDetails,
      ),
    );
  }
}

// ignore: must_be_immutable
class LayoutStarts extends StatelessWidget {
  final Map<String, dynamic> dish;
  CartResponce productDetails;
  LayoutStarts({this.dish, this.productDetails});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarCarousel(productDetails: productDetails),
        CustomBottomSheet(context: context, dish: dish, productDetails: productDetails),
      ],
    );
  }
}

// ignore: must_be_immutable
class CarCarousel extends StatefulWidget {
  final Map<String, dynamic> dish;
  CartResponce productDetails;
  CarCarousel({this.dish, this.productDetails});

  @override
  _CarCarouselState createState() => _CarCarouselState();
}

class _CarCarouselState extends State<CarCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
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
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 30.0),
                    Text(S.of(context).booking_statuts,
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
              Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)), color: Colors.white),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 30.0, bottom: 20.0, top: 0.0),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 10),
                                      Text(
                                        widget.productDetails.product_name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 10),
                                      Wrap(children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 0),
                                          child: Text(
                                            S.of(context).seller,
                                            style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).hintColor)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 0),
                                          child: Text(
                                            S.of(context).retrack,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).hintColor)),
                                          ),
                                        ),
                                      ]),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child:
                                        Text('${Helper.pricePrint(widget.productDetails.price)}', style: Theme.of(context).textTheme.headline4),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                              Column(children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 15, right: 10),
                                  child: Image.network(
                                    // ignore: deprecated_member_use
                                    '${GlobalConfiguration().getString('api_base_url')}uploads/product_image/product_${widget.productDetails.id}_1_thumb.jpg',
                                    fit: BoxFit.fitHeight,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                SizedBox(height: 20),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
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
  CartResponce productDetails;
  CustomBottomSheet({this.context, this.dish, this.productDetails});

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
        child: SheetContainer(
          dish: widget.dish,
          productDetails: widget.productDetails,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SheetContainer extends StatefulWidget {
  final Map<String, dynamic> dish;
  CartResponce productDetails;
  SheetContainer({this.dish, this.productDetails});

  @override
  _SheetContainerState createState() => _SheetContainerState();
}

class _SheetContainerState extends StateMVC<SheetContainer> {
  OrderController _con;

  _SheetContainerState() : super(OrderController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // print(product_details.value.id);
    //  _con.listenForOrdersTrack(product_details.value.id);
  }

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
      child: _con.ordersTrack.isEmpty
          ? CircularLoadingWidget(
        height: 50,
      )
          : Column(
        children: <Widget>[
          drawerHandle(),
          Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: _con.ordersTrack.length,
                padding: EdgeInsets.only(left: 15),
                itemBuilder: (context, index) {
                  final f = DateFormat('yyyy-MM-dd hh:mm');
                  OrderTrack _orderTrack = _con.ordersTrack.elementAt(index);

                  return Column(
                    children: <Widget>[
                      /* start Booking status part */

                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 30.0, bottom: 20.0, top: 0.0),
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
                                /**  Text(
                                    'RATING',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.subtitle2,
                                    ), */
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _orderTrack.status,
                                  style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 14, fontWeight: FontWeight.w700),
                                ),
                                /*  GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/review');
                              },
                              child: Wrap(children: [
                                Icon(Icons.star, color: Colors.grey[300], size: 20),
                                Icon(Icons.star, color: Colors.grey[300], size: 20),
                                Icon(Icons.star, color: Colors.grey[300], size: 20),
                                Icon(Icons.star, color: Colors.grey[300], size: 20),
                                Icon(Icons.star, color: Colors.grey[300], size: 20),
                              ])), */
                              ],
                            ),
                            _orderTrack.otp != null && _orderTrack.status != 'Delivered'
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'OTP ${_orderTrack.otp}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ],
                            )
                                : Row(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 30.0, bottom: 20.0, top: 10.0),
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
                                  f.format(DateTime.fromMillisecondsSinceEpoch(int.parse(_orderTrack.dateTime) * 1000)),
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
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: Text(
                                    '${_orderTrack.address.addressSelect} ',
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          S.of(context).tracking_system,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),

                      /* start timeline part */
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 40),
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
                                  indicatorStyle: IndicatorStyle(
                                    width: 20,
                                    color: _orderTrack.statusManager.placedstatus == true ? Colors.green : Color(0xFFececec),
                                  ),
                                  beforeLineStyle: LineStyle(
                                    color: _orderTrack.statusManager.acceptstatus == true ? Colors.green : Color(0xFFececec),
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
                                                  S.of(context).placed,
                                                  style: Theme.of(context).textTheme.subtitle2,
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  f.format(DateTime.fromMillisecondsSinceEpoch(_orderTrack.statusManager.placedtime * 1000)),
                                                  style: Theme.of(context).textTheme.caption,
                                                ),
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
                                      color: _orderTrack.statusManager.acceptstatus == true ? Colors.green : Color(0xFFececec),
                                      thickness: 6,
                                    ),
                                    afterLineStyle: LineStyle(
                                      color: _orderTrack.statusManager.packedstatus == true ? Colors.green : Color(0xFFececec),
                                      thickness: 6,
                                    ),
                                    indicatorStyle: IndicatorStyle(
                                      width: 20,
                                      color: _orderTrack.statusManager.acceptstatus == true ? Colors.green : Color(0xFFececec),
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
                                                    S.of(context).accepted,
                                                    style: Theme.of(context).textTheme.subtitle2,
                                                  ),
                                                ),
                                                Container(
                                                  child: _orderTrack.statusManager.acceptstatus == true
                                                      ? Text(
                                                    f.format(
                                                        DateTime.fromMillisecondsSinceEpoch(_orderTrack.statusManager.accepttime * 1000)),
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
                                2.6,
                                TimelineTile(
                                  alignment: TimelineAlign.start,
                                  beforeLineStyle: LineStyle(
                                    color: _orderTrack.statusManager.packedstatus == true ? Colors.green : Color(0xFFececec),
                                    thickness: 6,
                                  ),
                                  indicatorStyle: IndicatorStyle(
                                    width: 20,
                                    color: _orderTrack.statusManager.packedstatus == true ? Colors.green : Color(0xFFececec),
                                  ),
                                  afterLineStyle: LineStyle(
                                    color: _orderTrack.statusManager.shippedstatus == true ? Colors.green : Color(0xFFececec),
                                    thickness: 6,
                                  ),
                                  endChild: Container(
                                    constraints: BoxConstraints(
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
                                                  S.of(context).packed,
                                                  style: Theme.of(context).textTheme.subtitle2,
                                                ),
                                              ),
                                              Container(
                                                child: _orderTrack.statusManager.packedstatus == true
                                                    ? Text(
                                                  f.format(
                                                      DateTime.fromMillisecondsSinceEpoch(_orderTrack.statusManager.packedtime * 1000)),
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
                                2.6,
                                TimelineTile(
                                  alignment: TimelineAlign.start,
                                  beforeLineStyle: LineStyle(
                                    color: _orderTrack.statusManager.shippedstatus == true ? Colors.green : Color(0xFFececec),
                                    thickness: 6,
                                  ),
                                  indicatorStyle: IndicatorStyle(
                                    width: 20,
                                    color: _orderTrack.statusManager.shippedstatus == true ? Colors.green : Color(0xFFececec),
                                  ),
                                  afterLineStyle: LineStyle(
                                    color: _orderTrack.statusManager.deliverstatus == true ? Colors.green : Color(0xFFececec),
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
                                                  S.of(context).shipped,
                                                  style: Theme.of(context).textTheme.subtitle2,
                                                ),
                                              ),
                                              Container(
                                                child: _orderTrack.statusManager.shippedstatus == true
                                                    ? Text(
                                                  f.format(
                                                      DateTime.fromMillisecondsSinceEpoch(_orderTrack.statusManager.shippedtime * 1000)),
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
                                3.4,
                                TimelineTile(
                                  alignment: TimelineAlign.start,
                                  isLast: true,
                                  afterLineStyle: LineStyle(
                                    color: _orderTrack.statusManager.deliverstatus == true ? Colors.green : Color(0xFFececec),
                                    thickness: 6,
                                  ),
                                  indicatorStyle: IndicatorStyle(
                                    width: 20,
                                    color: _orderTrack.statusManager.deliverstatus == true ? Colors.green : Color(0xFFececec),
                                  ),
                                  beforeLineStyle: LineStyle(
                                    color: _orderTrack.statusManager.deliverstatus == true ? Colors.green : Color(0xFFececec),
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
                                                  S.of(context).delivered,
                                                  style: Theme.of(context).textTheme.subtitle2,
                                                ),
                                              ),
                                              Container(
                                                child: _orderTrack.statusManager.deliverstatus == true
                                                    ? Text(
                                                  f.format(
                                                      DateTime.fromMillisecondsSinceEpoch(_orderTrack.statusManager.delivered * 1000)),
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
                            ],
                          ),
                        ),
                      ),
                      /**  ListView(
                          padding: EdgeInsets.only(left: 10, right: 30),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                          Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          Text(
                          'PRICE DETAIL',
                          style: Theme.of(context).textTheme.headline1,
                          ),
                          ],
                          ),
                          SizedBox(height: 10),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(
                          'List Price',
                          ),
                          Text('₹1999', style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(decoration: TextDecoration.lineThrough))),
                          ],
                          ),
                          SizedBox(height: 10),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(
                          'Selling Price',
                          ),
                          Text(
                          '₹719',
                          style: Theme.of(context).textTheme.subtitle2,
                          ),
                          ],
                          ),
                          SizedBox(height: 10),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(
                          'Shipping Price',
                          ),
                          Text(
                          '₹65',
                          style: Theme.of(context).textTheme.subtitle2,
                          ),
                          ],
                          ),
                          SizedBox(height: 10),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(
                          'Total Amount',
                          style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                          '₹719',
                          style: Theme.of(context).textTheme.headline1,
                          ),
                          ],
                          ),
                          drawReviewTile(
                          context,
                          ),
                          SizedBox(
                          height: 100,
                          )
                          ],
                          ), */
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  drawReviewTile(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.height * 0.1,
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
