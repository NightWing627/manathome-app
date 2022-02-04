import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/models/addon.dart';
import '../models/cart_responce.dart';
import '../controllers/cart_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/helper.dart';

// ignore: must_be_immutable
class ProductBox3Widget extends StatefulWidget {
  ProductBox3Widget({Key key, this.con, this.productDetails}) : super(key: key);
  CartController con;
  CartResponce productDetails;

  @override
  _ProductBox3WidgetState createState() => _ProductBox3WidgetState();
}

class _ProductBox3WidgetState extends StateMVC<ProductBox3Widget> {
  @override
  void initState() {
    super.initState();
    print(widget.productDetails.image);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  color: Colors.white,
                  width: 130,
                  child: CachedNetworkImage(
                    imageUrl: widget.productDetails.image,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  )),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 2, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      top: 6,
                    ),
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.productDetails.product_name,
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Text(
                            '${widget.productDetails.unit} ${widget.productDetails.quantity}')
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child:
                              Wrap(alignment: WrapAlignment.center, children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  direction: Axis.vertical,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 25),
                                      child: Text(
                                        Helper.pricePrint(
                                            widget.productDetails.strike),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .merge(TextStyle(
                                                decoration: TextDecoration
                                                    .lineThrough)),
                                      ),
                                    ),
                                    Text(
                                        Helper.pricePrint(
                                            widget.productDetails.price),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       left: 10, right: 8, top: 4),
                                    //   child: Container(
                                    //     child: Text(
                                    //       S.of(context).offer,
                                    //       style: Theme.of(context)
                                    //           .textTheme
                                    //           .subtitle2
                                    //           .merge(TextStyle(
                                    //             color: Theme.of(context)
                                    //                 .backgroundColor
                                    //                 .withOpacity(0.7),
                                    //           )),
                                    //     ),
                                    //   ),
                                    // ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 17),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.con.decrementQty(
                                            widget.productDetails.id,
                                            widget.productDetails.variant);
                                      });
                                    },
                                    iconSize: 27,
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.orange[700],
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 0),
                                    child: Text(
                                      widget.con.showQty(
                                          widget.productDetails.id,
                                          widget.productDetails.variant),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.con.incrementQty(
                                            widget.productDetails.id,
                                            widget.productDetails.variant);
                                      });
                                    },
                                    iconSize: 27,
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.orange[700],
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                  widget.productDetails.addon.length != 0
                      ? Wrap(
                          children: List.generate(
                              widget.productDetails.addon.length, (index) {
                          AddonModel _addData =
                              widget.productDetails.addon.elementAt(index);
                          return Container(
                              child: Text(
                                  '${_addData.name}  ${Helper.pricePrint(_addData.price)}',
                                  style: Theme.of(context).textTheme.caption));
                        }))
                      : Text(''),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
