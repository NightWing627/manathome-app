
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/elements/BlockButtonWidget.dart';
import 'package:multisuperstore/src/elements/SearchWidgetShop.dart';
import 'package:multisuperstore/src/pages/table_reservation.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'ProfilePage.dart';
import 'booking_track1.dart';
import 'vendor_map.dart';
import '../elements/DrawerWidget.dart';
import '../helpers/helper.dart';
import '../pages/home.dart';
import 'orders.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget  {
  dynamic currentTab;

  Widget currentPage = HomeWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({
    Key key,
    this.currentTab,
  }) {
    currentTab = 2;
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = VendorMapWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentPage = SearchResultWidgetShop();
          break;
        case 2:
          widget.currentPage = HomeWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 3:
          widget.currentPage = OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 4:
          widget.currentPage = ProfilePage();
          break;
        // case 4:
        //   widget.currentPage = TableReservationPage(parentScaffoldKey: widget.scaffoldKey);
        //   break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,

      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        //backgroundColor: Colors.transparent,
        body: widget.currentPage,
          bottomNavigationBar: StyleProvider(
              style: Style(),
              child:ConvexAppBar(

            // activeColor: Theme.of(context).primaryColorDark,
                activeColor: Color.fromRGBO(0x1D, 0x1D, 0x1F, 1.0),
                style: TabStyle.fixedCircle,

                initialActiveIndex: widget.currentTab,
                  elevation: 0.5,

            // backgroundColor: Theme.of(context).primaryColor,
              backgroundColor: Color.fromRGBO(0x1D, 0x1D, 0x1F, 1.0),
              color:Theme.of(context).hintColor,

            onTap: (int i) {
              this._selectTab(i);
            },
            items: [

              TabItem(
                  // icon: Icon(Icons.location_on_outlined,color:widget.currentTab==0? Theme.of(context).primaryColorLight : Theme.of(context).hintColor),
                  icon: Icon(Icons.location_on_outlined,color:widget.currentTab==0? Theme.of(context).primaryColorLight : Theme.of(context).hintColor),
                  // ignore: deprecated_member_use
                title: S.of(context).map
              ),
              TabItem(
                  icon: Icon(Icons.search,color:widget.currentTab==1? Theme.of(context).primaryColorLight : Theme.of(context).hintColor),
                  title: S.of(context).search
              ),
              TabItem(
                icon: Image(image:AssetImage('assets/img/logo.png'),
                  width:35,height:35,
                ),
                title: S.of(context).home,
              ),
              TabItem(
                  icon:  Icon(Icons.shopping_bag_outlined,color:widget.currentTab==3? Theme.of(context).primaryColorLight : Theme.of(context).hintColor),
                  title: S.of(context).my_orders
              ),
              TabItem(
                  icon: new Icon(Icons.person,color:widget.currentTab==4? Theme.of(context).primaryColorLight : Theme.of(context).hintColor),
                  title:S.of(context).profile,

              ),
              // TabItem(
              //     icon:  Icon(Icons.book,color:widget.currentTab==4? Theme.of(context).primaryColorLight : Theme.of(context).hintColor),
              //     title: S.of(context).table_reservation
              // ),
            ],



          )
      ),
      ),
    );
  }


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
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _buildChild(context),
        insetPadding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            left: MediaQuery.of(context).size.width * 0.03,
            right: MediaQuery.of(context).size.width * 0.03,
            bottom: MediaQuery.of(context).size.width * 0.03),
      ),
    );
  }

  _buildChild(BuildContext context) => SingleChildScrollView(
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Container(),
    ),
  );
}

// ignore: non_constant_identifier_names
void PaymentConfirmation(context) {
  showDialog(context: context, builder: (context) => PaymentConfirmationPopup());
}

class PaymentConfirmationPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _buildChild(context),
        insetPadding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
      ),
    );
  }

  _buildChild(BuildContext context) => Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    child: Column(
      children: <Widget>[
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12,
          ),
          child: Text(
            'Payment Confirmation',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(height: 70),
        Image(image: AssetImage('assets/img/paymentwaiting.gif'), width: 100, height: 100),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12,
          ),
          child: Text(
            'Waiting For Payment Confirmation',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ],
    ),
  );
}
/*
ratingModel(context, bookId, ratingStatus, Rating con, providerid) {
  TextEditingController textController = TextEditingController();
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return WillPopScope(
          // add this
          onWillPop: () async => false,
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.13,
              color: Color(0xff737373),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40),
                      Image(image: AssetImage('assets/img/ratingpen.png'), width: 100, height: 100),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          right: 12,
                        ),
                        child: Text(
                          'Give us Rating',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 21.0,
                          right: 21,
                        ),
                        child: Text('Help your user improve their service by rating then',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: Theme.of(context).disabledColor))),
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
                              initialRating: 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 30,
                              itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                                con.rate = rating;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Booking Id: ${bookId}', style: Theme.of(context).textTheme.subtitle1),
                      SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(children: [
                            Text('Before Service'),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 120,
                              height:140,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [Center(child: Image(image:NetworkImage('${GlobalConfiguration().getString('api_base_url')}/uploads/beforeservice_image/beforeservice_${bookId}.jpg'),
                                            width:100,height:140,
                                            fit: BoxFit.fill),)]),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Column(children: [
                            Text('After Service'),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 120,
                              height:140,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [Center(child: Image(image:NetworkImage('${GlobalConfiguration().getString('api_base_url')}/uploads/afterservice_image/afterservice_${bookId}.jpg'),
                                            width:120,
                                            height:140,

                                            fit: BoxFit.fill),)]),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                      SizedBox(height: 20),
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
                                  controller: textController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Comments',
                                    hintStyle: Theme.of(context).textTheme.caption,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey[300],
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 2.0,
                                      ),
                                    ),
                                  ))),
                        ),
                      ),
                      BlockButtonWidget(
                        text: Text(
                          'SUBMIT',
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () async {
                          FirebaseFirestore.instance.collection('data').doc(bookId).update({'userRatingStatus': 'true'}).catchError((e) {
                            print(e);
                          });
                          con.bookId = bookId;
                          con.review = textController.text;
                          con.userId = currentUser.value.id;
                          con.providerId = providerid;
                          repositoryUser.giveRegister(con).then((value) {}).catchError((e) {}).whenComplete(() {});
                          return Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}
    **/
class Style extends StyleHook {
  @override
  double get activeIconSize => 28;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(color: color);
  }

}