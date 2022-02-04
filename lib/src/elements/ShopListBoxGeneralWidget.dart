import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/vendor_controller.dart';
import '../Widget/custom_divider_view.dart';
import 'NoShopFoundWidget.dart';
import 'RectangularLoaderWidget.dart';
import 'ShopListWidget.dart';

// ignore: must_be_immutable
class ShopListBoxGeneralWidget extends StatefulWidget {
  VendorController con;
  String superId;
  String pageTitle;
  String coverImage;
  String offer;
  String offerType;
  ShopListBoxGeneralWidget(
      {Key key,
      this.con,
      this.pageTitle,
      this.offer,
      this.superId,
      this.offerType,
      this.coverImage})
      : super(key: key);
  @override
  _ShopListBoxGeneralWidgetState createState() =>
      _ShopListBoxGeneralWidgetState();
}

class _ShopListBoxGeneralWidgetState
    extends StateMVC<ShopListBoxGeneralWidget> {
  bool ratingOne = false;

  @override
  void initState() {
    super.initState();
    if (widget.offer != 'no') {
      widget.con.listenForVendorListOffer(
          widget.superId, widget.offer, widget.offerType);
    } else {
      widget.con.listenForFavoritesShop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.con.vendorList.isEmpty
        ? RectangularLoaderWidget()
        : Container(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                      child: Text(widget.pageTitle,
                          style: Theme.of(context).textTheme.headline1)),
                  Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                      child: Text(
                          '${S.of(context).fast_on_authentic} ${widget.pageTitle}',
                          style: Theme.of(context).textTheme.caption)),
                  CustomDividerView(
                      dividerHeight: 1.0,
                      color: Theme.of(context).dividerColor),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                                '${widget.con.vendorList.length} STORES NEAR BY',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .merge(TextStyle(
                                        color: Theme.of(context)
                                            .backgroundColor))),
                          ),
                          /**  Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Icon(Icons.filter_list, size: 19),
                        ),
                        SizedBox(width: 8),
                        Text('SORT/FILTER', style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).backgroundColor))) 
                        **/
                        ],
                      ),
                    ),
                  ),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.con.vendorList.length,
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.only(top: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      return widget.con.vendorList[index].shopId == 'not_found'
                          ? NoShopFoundWidget()
                          : ShopList(
                              choice: widget.con.vendorList[index],
                              shopType: int.parse(
                                  widget.con.vendorList[index].shopType),
                              focusId: int.parse(
                                  widget.con.vendorList[index].focusType),
                              previewImage: widget.coverImage,
                            );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 0);
                    },
                  ),
                  SizedBox(height: 50)
                ])),
          );
  }
}
