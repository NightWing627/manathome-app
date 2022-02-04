import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import '../models/cart_responce.dart';

// ignore: must_be_immutable
class OrderItemProductWidget extends StatelessWidget {
  CartResponce productDetails;
   OrderItemProductWidget({
    Key key,
    this.productDetails
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.secondary,
      focusColor: Theme.of(context).colorScheme.secondary,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: new Image.network(
                // ignore: deprecated_member_use
                '${GlobalConfiguration().getString('api_base_url')}uploads/product_image/product_${productDetails.id}_1_thumb.jpg',
                height: 60.0,
                width:70,
                fit: BoxFit.cover,
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
                          productDetails.product_name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        Text(
                          '${productDetails.quantity} ${productDetails.unit}',
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
                      //Text('\$45.0', style: Theme.of(context).textTheme.subtitle1),
                      Text(
                        " x " + productDetails.qty.toString(),
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
