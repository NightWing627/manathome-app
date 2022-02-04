import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import '../helpers/helper.dart';
import '../models/cart_responce.dart';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class ProductOrderItemWidget extends StatelessWidget {
  // ignore: non_constant_identifier_names
  CartResponce product_detailData;
  String orderId;
  String shopTypeId;
  // ignore: non_constant_identifier_names
  ProductOrderItemWidget({Key key, this.product_detailData, this.orderId, this.shopTypeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.secondary,
      focusColor: Theme.of(context).colorScheme.secondary,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
      //  product_details.value.id = orderId;
        Navigator.of(context).pushNamed('/orderDetails', arguments: orderId);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: CachedNetworkImage(
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                // ignore: unrelated_type_equality_checks, deprecated_member_use
                imageUrl: shopTypeId==2?'${GlobalConfiguration().getString('base_upload')}uploads/restaurantproduct_image/restaurantproduct_${product_detailData.variant}.png':
                // ignore: deprecated_member_use
                '${GlobalConfiguration().getString('base_upload')}uploads/product_image/product_${product_detailData.variant}.png',
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product_detailData.product_name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Wrap(
                          children: List.generate(1, (index) {
                            return Text(
                              '${Helper.pricePrint(product_detailData.price)}',
                              style: Theme.of(context).textTheme.headline3.merge(TextStyle(fontWeight: FontWeight.w400)),
                            );
                          }),
                        ),
                        Text(
                          '${product_detailData.offer}% ${S.of(context).offer}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      //  Helper.getPrice(Helper.getOrderPrice(productOrder), context, style: Theme.of(context).textTheme.subtitle1),
                      Text(
                        " x ${product_detailData.qty}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
