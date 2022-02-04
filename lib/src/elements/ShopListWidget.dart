import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/vendor.dart';
import 'package:multisuperstore/src/pages/grocerystore.dart';
import 'package:multisuperstore/src/pages/store_detail.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:toast/toast.dart';

import 'NoShopFoundWidget.dart';

class ShopList extends StatelessWidget {
  const ShopList(
      {Key key, this.choice, this.shopType, this.focusId, this.previewImage})
      : super(key: key);
  final Vendor choice;
  final int shopType;
  final int focusId;
  final String previewImage;
  @override
  Widget build(BuildContext context) {
    return choice.shopId != 'no_data'
        ? Hero(

            tag: choice.shopId,
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: <
                      Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Stack(children: [
                        Container(
                          decoration: new BoxDecoration(
                            border: Border.all(color: Colors.orange, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              choice.openStatus
                                  ? Colors.black.withOpacity(0)
                                  : Colors.black.withOpacity(
                                      0.6), // 0 = Colored, 1 = Black & White
                              BlendMode.saturation,
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: choice.logo != 'no_image'
                                    ? CachedNetworkImage(
                                        imageUrl: choice.logo,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: previewImage,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                      )),
                          ),
                        )
                      ]),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: choice.marketKey == 'discount'
                            ? Container(
                                padding: EdgeInsets.all(3),
                                //width: MediaQuery.of(context).size.width * 0.20,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.deepOrange[400],
                                ))
                            : SizedBox(),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: choice.marketKey == 'discount'
                            ? Container(
                                padding: EdgeInsets.all(3),
                                //width: MediaQuery.of(context).size.width * 0.20,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.deepOrange[400],
                                ),
                                child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Text('${choice.marketValue ?? ''}% Off',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .merge(TextStyle(
                                                  color: Colors.white)))
                                    ]))
                            : choice.marketKey == 'offer'
                                ? Container(
                                    padding: EdgeInsets.all(3),
                                    //width: MediaQuery.of(context).size.width * 0.20,
                                    width: 100,
                                    height: 37,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: Color(0xFFefbe0f),
                                    ),
                                    child: Column(children: [
                                      Text('- UPTO -',
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: Theme.of(context)
                                                  .primaryColorLight)),
                                      Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            Text(
                                                '${Helper.pricePrint(choice.marketValue)}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorLight)))
                                          ])
                                    ]))
                                : Container(),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    choice.shopName ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 15),
                                    child: Text(choice.subtitle ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 15),
                                    child: Text(
                                      choice.locationMark ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  Wrap(children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(),
                                    //   child: Text(
                                    //       Helper.priceDistance(choice.distance),
                                    //       style: Theme.of(context)
                                    //           .textTheme
                                    //           .bodyText2),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, left: 15),
                                      child: Icon(Icons.star,
                                          color: Colors.orange[500], size: 15),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Text('${choice.rate}     ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2),
                                    ),

                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 3),
                                    //   child: Text('     ${Helper.calculateTime(double.parse(choice.distance.replaceAll(',','')))}', style: Theme.of(context).textTheme.bodyText2),
                                    // ),
                                  ]),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  GestureDetector(
                                    onTap: () {
                                      if (choice.openStatus) {
                                        if (shopType == 1 || shopType == 3) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GroceryStoreWidget(
                                                        shopDetails: choice,
                                                        shopTypeID: shopType,
                                                        focusId: focusId,
                                                      )));
                                        } else {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  StoreViewDetails(
                                                shopDetails: choice,
                                                shopTypeID: shopType,
                                                focusId: focusId,
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: Image.asset(
                                      "assets/img/btn_guarda_il_menu.png",
                                      fit: BoxFit.fitWidth,
                                      width: MediaQuery.of(context).size.width /
                                          2.8,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.8 /
                                              4,
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                  ),
                ),
              ]),

            ),
          )   : NoShopFoundWidget();
  }
}
