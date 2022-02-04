import 'package:multisuperstore/src/pages/flutterwave_payment.dart';
import 'package:multisuperstore/src/pages/paypal_payment.dart';
import 'package:multisuperstore/src/pages/stripe_payment.dart';
import 'package:multisuperstore/src/pages/uip_india.dart';
import '../repository/settings_repository.dart';
import '../controllers/cart_controller.dart';
import '../repository/order_repository.dart';
import '../../generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
// ignore: must_be_immutable
class PaymentWalletPage extends StatefulWidget {
  String amount;
  PaymentWalletPage({Key key, this.amount}) : super(key: key);
  @override
  _PaymentWalletPageState createState() => _PaymentWalletPageState();
}

class _PaymentWalletPageState extends StateMVC<PaymentWalletPage> {
  CartController _con;
  String paymentMethod;
  String paymentMode;

  _PaymentWalletPageState() : super(CartController()) {
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


    for(int i=0; i<=7; i++){
      paymentSelect[i] = false;
    }

  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      if (val == 1) {
        paymentMethod= 'cash on delivery';
      } else {
        paymentMethod = 'online';
      }
    });
  }

  selectPayment(id, paymentType){
    paymentMode = paymentType;
    setState(() {
      for(int i=0; i<=7; i++){
        if(id==i) {
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
      'amount': double.parse(widget.amount) * 100,
      'name': setting.value.appName,
      'description': 'Online Shopping',
      'prefill': {'contact': currentUser.value.phone, 'email': currentUser.value.email},
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
        decoration: BoxDecoration(color:Theme.of(context).dividerColor),
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
                  Text(S.of(context).payment,
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
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:40),
                          setting.value.rayzorPay?Container(
                            padding: EdgeInsets.only(left:20,right:20,bottom:10),
                            child:InkWell(
                              onTap: (){
                                setSelectedRadio(2);
                                selectPayment(0,'RayzorPay');

                              },
                              child: Container(
                                  padding: EdgeInsets.only(top: 10, left: 10, right: 10,bottom:10),
                                  decoration: BoxDecoration(
                                      color:Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(5.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12.withOpacity(0.1),
                                          blurRadius: 1.5,
                                          spreadRadius: 1.5,
                                        ),
                                      ]),
                                  child:Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:50,height:50,
                                        child: Image(image:AssetImage('assets/img/razorpay.png'),
                                        ),
                                      ),
                                      SizedBox(width:20),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('RayzorPay',style: Theme.of(context).textTheme.headline1),

                                            ],
                                          ),
                                        ),
                                      ),
                                      paymentSelect[0]==true?Align(
                                        child: Container(
                                            padding: EdgeInsets.only(left:10),
                                            child: IconButton(
                                              onPressed: (){},
                                              icon:Icon(Icons.check_circle,color:Colors.green),
                                            )
                                        ),
                                      ):Container()
                                    ],
                                  )
                              ),
                            ),
                          ):Container(),

                          setting.value.paypal? Container(
                            padding: EdgeInsets.only(left:20,right:20,bottom:10),
                            child:InkWell(
                              onTap: (){
                                setSelectedRadio(2);

                                selectPayment(2,'Paypal');
                              },
                              child: Container(
                                  padding: EdgeInsets.only(top: 10, left: 10, right: 10,bottom:10),
                                  decoration: BoxDecoration(
                                      color:Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(5.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12.withOpacity(0.1),
                                          blurRadius: 1.5,
                                          spreadRadius: 1.5,
                                        ),
                                      ]),
                                  child:Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:50,height:50,
                                        child: Image(image:AssetImage('assets/img/paypal.png'),
                                        ),
                                      ),
                                      SizedBox(width:20),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Paypal',style: Theme.of(context).textTheme.headline1),

                                            ],
                                          ),
                                        ),
                                      ),
                                      paymentSelect[2]==true?Align(
                                        child: Container(
                                            padding: EdgeInsets.only(left:10),
                                            child: IconButton(
                                              onPressed: (){},
                                              icon:Icon(Icons.check_circle,color:Colors.green),
                                            )
                                        ),
                                      ):Container()
                                    ],
                                  )
                              ),
                            ),
                          ):Container(),
                          setting.value.stripe? Container(
                            padding: EdgeInsets.only(left:20,right:20,bottom:10),
                            child:InkWell(
                              onTap: (){
                                setSelectedRadio(2);
                                selectPayment(3,'Stripe');

                              },
                              child: Container(
                                  padding: EdgeInsets.only(top: 10, left: 10, right: 10,bottom:10),
                                  decoration: BoxDecoration(
                                      color:Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(5.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12.withOpacity(0.1),
                                          blurRadius: 1.5,
                                          spreadRadius: 1.5,
                                        ),
                                      ]),
                                  child:Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:50,height:50,
                                        child: Image(image:AssetImage('assets/img/stripe.png'),
                                        ),
                                      ),
                                      SizedBox(width:20),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Stripe',style: Theme.of(context).textTheme.headline1),

                                            ],
                                          ),
                                        ),
                                      ),
                                      paymentSelect[3]==true?Align(
                                        child: Container(
                                            padding: EdgeInsets.only(left:10),
                                            child: IconButton(
                                              onPressed: (){},
                                              icon:Icon(Icons.check_circle,color:Colors.green),
                                            )
                                        ),
                                      ):Container()
                                    ],
                                  )
                              ),
                            ),
                          ):Container(),
                          setting.value.flutterWave?      Container(
                            padding: EdgeInsets.only(left:20,right:20,bottom:10),
                            child:InkWell(
                              onTap: (){
                                setSelectedRadio(2);

                                selectPayment(4,'Flutterwave');
                              },
                              child: Container(
                                  padding: EdgeInsets.only(top: 10, left: 10, right: 10,bottom:10),
                                  decoration: BoxDecoration(
                                      color:Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(5.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12.withOpacity(0.1),
                                          blurRadius: 1.5,
                                          spreadRadius: 1.5,
                                        ),
                                      ]),
                                  child:Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:50,height:50,
                                        child: Image(image:AssetImage('assets/img/flutterwave.png'),
                                        ),
                                      ),
                                      SizedBox(width:20),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Flutterwave',style: Theme.of(context).textTheme.headline1),

                                            ],
                                          ),
                                        ),
                                      ),
                                      paymentSelect[4]==true? Align(
                                        child: Container(
                                            padding: EdgeInsets.only(left:10),
                                            child: IconButton(
                                              onPressed: (){},
                                              icon:Icon(Icons.check_circle,color:Colors.green),
                                            )
                                        ),
                                      ):Container()
                                    ],
                                  )
                              ),
                            ),
                          ):Container(),




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
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () {


                          if (paymentMethod == '' || paymentMethod == null ) {
                            // ignore: deprecated_member_use
                            _con.scaffoldKey?.currentState?.showSnackBar(SnackBar(
                              content: Text('Please select your payment'),
                            ));
                          } else {
                            if (paymentMethod== 'online') {
                              if(paymentMode == 'RayzorPay') {
                                openCheckout();
                              } else if(paymentMode== 'UPI'){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentUPI()));
                              } if(paymentMode == 'Paypal'){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PayPalPaymentWidget()));
                              }if(paymentMode == 'Stripe'){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => StripePaymentWidget()));
                              }if(paymentMode == 'Flutterwave'){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlutterWavePaymentWidget()));
                              }
                            }
                          }
                        },
                        child: Center(
                            child: Text(
                              S.of(context).done,
                              style: Theme.of(context).textTheme.headline3.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
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
