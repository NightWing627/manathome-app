import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:multisuperstore/src/controllers/stripe_controller.dart';
import 'package:multisuperstore/src/repository/order_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:webview_flutter/webview_flutter.dart';



// ignore: must_be_immutable
class StripePaymentWidget extends StatefulWidget {

  StripePaymentWidget({Key key, }) : super(key: key);
  @override
  _StripePaymentWidgetState createState() => _StripePaymentWidgetState();
}

class _StripePaymentWidgetState extends StateMVC<StripePaymentWidget> {
  StripeController _con;
  _StripePaymentWidgetState() : super(StripeController()) {
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Stripe',
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
              initialUrl: _con.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller) {
                _con.webView = controller;
              },
              onPageStarted: (String url) {
                setState(() {
                  _con.url = url;
                });
                // ignore: deprecated_member_use
                if (url == "${GlobalConfiguration().getString('api_base_url')}Stripe/success") {
                  _con.bookOrder(currentCheckout.value);
                }
              },
              onPageFinished: (String url) {
                setState(() {
                  _con.progress = 1;
                });
              }),
          _con.progress < 1
              ? SizedBox(
                  height: 3,
                  child: LinearProgressIndicator(
                    backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
