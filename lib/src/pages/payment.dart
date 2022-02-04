import 'package:multisuperstore/src/pages/flutterwave_payment.dart';
import 'package:multisuperstore/src/pages/paypal_payment.dart';
import 'package:multisuperstore/src/pages/stripe_payment.dart';
import 'package:multisuperstore/src/pages/uip_india.dart';
import 'package:toast/toast.dart';

import '../repository/settings_repository.dart';
import '../controllers/cart_controller.dart';
import '../helpers/helper.dart';
import '../repository/order_repository.dart';
import '../../generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends StateMVC<PaymentPage> {
  CartController _con;

  _PaymentPageState() : super(CartController()) {
    _con = controller;
  }

  Razorpay _razorpay;
  // ignore: deprecated_member_use
  List<bool> paymentSelect = List(8);
  int selectedRadio;
  int checkedItem = 0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    currentCheckout.value.payment.delivery_tips =
        currentCheckout.value.delivery_tips;
    currentCheckout.value.payment.delivery_fees =
        currentCheckout.value.delivery_fees;
    currentCheckout.value.payment.sub_total = currentCheckout.value.sub_total;
    currentCheckout.value.payment.discount = currentCheckout.value.discount;
    currentCheckout.value.payment.grand_total =
        currentCheckout.value.grand_total;
    print(currentCheckout.value.toMap());

    for (int i = 0; i <= 7; i++) {
      paymentSelect[i] = false;
    }
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      if (val == 1) {
        currentCheckout.value.payment.method = 'cash on delivery';
      } else {
        currentCheckout.value.payment.method = 'online';
      }
    });
  }

  selectPayment(id, paymentType) {
    currentCheckout.value.payment.paymentType = paymentType;
    setState(() {
      for (int i = 0; i <= 7; i++) {
        if (id == i) {
          paymentSelect[i] = true;
        } else {
          paymentSelect[i] = false;
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': setting.value.razorpay_key,
      'amount': currentCheckout.value.grand_total * 100,
      'name': setting.value.appName,
      'description': 'Online Shopping',
      'prefill': {
        'contact': currentUser.value.phone,
        'email': currentUser.value.email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      // debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    //Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    _con.bookOrder(currentCheckout.value);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    //Fluttertoast.showToast(msg: "ERROR: " + response.code.toString() + " - " + response.message, timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).dividerColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(top: 27.0, left: 10.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Theme.of(context).backgroundColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    S.of(context).payment,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          setting.value.rayzorPay
                              ? Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10),
                                  child: InkWell(
                                    onTap: () {
                                      setSelectedRadio(2);
                                      selectPayment(0, 'RayzorPay');
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            right: 10,
                                            bottom: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12
                                                    .withOpacity(0.1),
                                                blurRadius: 1.5,
                                                spreadRadius: 1.5,
                                              ),
                                            ]),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/img/razorpay.png'),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('RayzorPay',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline1),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            paymentSelect[0] == true
                                                ? Align(
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color:
                                                                  Colors.green),
                                                        )),
                                                  )
                                                : Container()
                                          ],
                                        )),
                                  ),
                                )
                              : Container(),
                          setting.value.upi
                              ? Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10),
                                  child: InkWell(
                                    onTap: () {
                                      setSelectedRadio(2);
                                      selectPayment(1, 'UPI');
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            right: 10,
                                            bottom: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12
                                                    .withOpacity(0.1),
                                                blurRadius: 1.5,
                                                spreadRadius: 1.5,
                                              ),
                                            ]),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/img/upi.png'),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('UPI',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline1),
                                                    Text(
                                                      'Coming soon',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            paymentSelect[1] == true
                                                ? Align(
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color:
                                                                  Colors.green),
                                                        )),
                                                  )
                                                : Container()
                                          ],
                                        )),
                                  ),
                                )
                              : Container(),
                          setting.value.paypal
                              ? Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10),
                                  child: InkWell(
                                    onTap: () {
                                      setSelectedRadio(2);

                                      selectPayment(2, 'Paypal');
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            right: 10,
                                            bottom: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12
                                                    .withOpacity(0.1),
                                                blurRadius: 1.5,
                                                spreadRadius: 1.5,
                                              ),
                                            ]),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/img/paypal.png'),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Paypal',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline1),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            paymentSelect[2] == true
                                                ? Align(
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color:
                                                                  Colors.green),
                                                        )),
                                                  )
                                                : Container()
                                          ],
                                        )),
                                  ),
                                )
                              : Container(),
                          setting.value.stripe
                              ? Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10),
                                  child: InkWell(
                                    onTap: () {
                                      setSelectedRadio(2);
                                      selectPayment(3, 'Stripe');
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            right: 10,
                                            bottom: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12
                                                    .withOpacity(0.1),
                                                blurRadius: 1.5,
                                                spreadRadius: 1.5,
                                              ),
                                            ]),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/img/stripe.png'),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Stripe',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline1),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            paymentSelect[3] == true
                                                ? Align(
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color:
                                                                  Colors.green),
                                                        )),
                                                  )
                                                : Container()
                                          ],
                                        )),
                                  ),
                                )
                              : Container(),
                          setting.value.flutterWave
                              ? Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10),
                                  child: InkWell(
                                    onTap: () {
                                      setSelectedRadio(2);

                                      selectPayment(4, 'Flutterwave');
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            right: 10,
                                            bottom: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12
                                                    .withOpacity(0.1),
                                                blurRadius: 1.5,
                                                spreadRadius: 1.5,
                                              ),
                                            ]),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/img/flutterwave.png'),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Flutterwave',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline1),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            paymentSelect[4] == true
                                                ? Align(
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color:
                                                                  Colors.green),
                                                        )),
                                                  )
                                                : Container()
                                          ],
                                        )),
                                  ),
                                )
                              : Container(),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                setSelectedRadio(1);
                                selectPayment(5, 'COD');
                              },
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(5.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black12.withOpacity(0.1),
                                          blurRadius: 1.5,
                                          spreadRadius: 1.5,
                                        ),
                                      ]),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: Image(
                                          image:
                                              AssetImage('assets/img/cod.png'),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('COD',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1),
                                            ],
                                          ),
                                        ),
                                      ),
                                      paymentSelect[5] == true
                                          ? Align(
                                              child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green),
                                                  )),
                                            )
                                          : Container()
                                    ],
                                  )),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                if (currentUser.value.walletAmount != '0') {
                                  if (int.parse(
                                          currentUser.value.walletAmount) >
                                      currentCheckout.value.grand_total
                                          .toInt()) {
                                    print(currentUser.value.walletAmount);
                                    setSelectedRadio(1);
                                    selectPayment(6, 'wallet');
                                  } else {
                                    _con.showToast(
                                        "Low balance Please recharge",
                                        gravity: Toast.BOTTOM,
                                        duration: Toast.LENGTH_SHORT);
                                  }
                                } else {
                                  _con.showToast(
                                      "Your wallet balance is 0 Please recharge",
                                      gravity: Toast.BOTTOM,
                                      duration: Toast.LENGTH_SHORT);
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(5.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black12.withOpacity(0.1),
                                          blurRadius: 1.5,
                                          spreadRadius: 1.5,
                                        ),
                                      ]),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: Image(
                                          image: AssetImage(
                                              'assets/img/wallet.png'),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  '${S.of(context).wallet}   (Balance ${Helper.pricePrint(currentUser.value.walletAmount)}) ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1),
                                            ],
                                          ),
                                        ),
                                      ),
                                      paymentSelect[6] == true
                                          ? Align(
                                              child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green),
                                                  )),
                                            )
                                          : Container()
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      width: double.infinity,
                      height: 140.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Column(
                          children: [
                            Text(
                              '${S.of(context).you_save} ${Helper.pricePrint(currentCheckout.value.discount)} ${S.of(context).on_this_order}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .merge(TextStyle(
                                    color: Theme.of(context)
                                        .backgroundColor
                                        .withOpacity(0.7),
                                  )),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(S.of(context).item_total,
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                                Text(
                                    '${Helper.pricePrint(currentCheckout.value.sub_total)}',
                                    style:
                                        Theme.of(context).textTheme.subtitle2)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(S.of(context).delivery_fee,
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                                Text(
                                    '${Helper.pricePrint(currentCheckout.value.delivery_fees)}',
                                    style:
                                        Theme.of(context).textTheme.subtitle2)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(S.of(context).discount,
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                                Text(
                                    '${Helper.pricePrint(currentCheckout.value.discount)}',
                                    style:
                                        Theme.of(context).textTheme.subtitle2)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Tax',
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                                Text(
                                    '${Helper.pricePrint(currentCheckout.value.tax)}',
                                    style:
                                        Theme.of(context).textTheme.subtitle2)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(S.of(context).to_pay,
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                                Text(
                                    '${Helper.pricePrint(currentCheckout.value.grand_total)}',
                                    style:
                                        Theme.of(context).textTheme.subtitle2)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () {
                          if (currentCheckout.value.payment.method == '' ||
                              currentCheckout.value.payment.method == null) {
                            // ignore: deprecated_member_use
                            _con.scaffoldKey?.currentState
                                ?.showSnackBar(SnackBar(
                              content: Text('Please select your payment'),
                            ));
                          } else {
                            if (currentCheckout.value.payment.method ==
                                'online') {
                              if (currentCheckout.value.payment.paymentType ==
                                  'RayzorPay') {
                                openCheckout();
                              } else if (currentCheckout
                                      .value.payment.paymentType ==
                                  'UPI') {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PaymentUPI()));
                              }
                              if (currentCheckout.value.payment.paymentType ==
                                  'Paypal') {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        PayPalPaymentWidget()));
                              }
                              if (currentCheckout.value.payment.paymentType ==
                                  'Stripe') {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        StripePaymentWidget()));
                              }
                              if (currentCheckout.value.payment.paymentType ==
                                  'Flutterwave') {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        FlutterWavePaymentWidget()));
                              }
                              if (currentCheckout.value.payment.paymentType ==
                                  'wallet') {
                                _con.bookOrder(currentCheckout.value);
                              }
                            } else {
                              _con.bookOrder(currentCheckout.value);
                            }
                          }
                        },
                        child: Center(
                            child: Text(
                          S.of(context).done,
                          style: Theme.of(context).textTheme.headline3.merge(
                              TextStyle(
                                  color: Theme.of(context).primaryColorLight)),
                        )),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
