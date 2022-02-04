import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/helper.dart';
import '../repository/user_repository.dart';
import '../repository/product_repository.dart' as cartRepo;
import '../repository/product_repository.dart';
import '../controllers/cart_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';

class BottomBarWidget extends StatefulWidget {
  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends StateMVC<BottomBarWidget> {
  CartController _con;

  _BottomBarWidgetState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: cartRepo.currentCart,
        builder: (context, _setting, _) {


          return currentCart.value.length != 0
              ? Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.15,
                  color: Theme.of(context).primaryColorDark,
                  child: Row(
                    children: [
                      Container(
                          child: Image(
                        image: AssetImage('assets/img/paymentwaiting.gif'),
                        height: 30,
                        width: 30,
                        fit: BoxFit.fitHeight,
                      )),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                                ' ${currentCart.value.length} ${S.of(context).items}  & ${S.of(context).item_total} '+Helper.pricePrint(_con.calculateAmount()).toString(),
                                style: Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                            )),
                      ),
                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () {
                          if (currentUser.value.apiToken != null) {
                            Navigator.of(context).pushNamed('/Checkout');
                          } else {
                            Navigator.of(context).pushNamed('/Login');
                          }
                        },
                        color: Theme.of(context).colorScheme.secondary,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          S.of(context).go_cart,
                          style: Theme.of(context).textTheme.headline1.merge(TextStyle(color: Theme.of(context).primaryColorLight)),
                        ),
                      ),
                    ],
                  )): Container();

        });
  }
}
