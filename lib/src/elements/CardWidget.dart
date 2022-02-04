import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/models/vendor.dart';
import '../helpers/helper.dart';


// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  Vendor market;
  String heroTag;

  CardWidget({Key key, this.market}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 292,
      margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 15, offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Image of the card
          Stack(
            fit: StackFit.loose,
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: CachedNetworkImage(
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: market.cover,
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(24)),
                    child:Text(
                            '${Helper.calculateTime(double.parse(market.distance.replaceAll(',','')))}',
                            style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                          ),
                  ),
                ],
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Expanded(
                          child: Container(
                            padding:EdgeInsets.only(left:10,right:10,top:15),
                            child:Text(market.shopName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style:Theme.of(context).textTheme.subtitle1),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8,right:8),
                          child:Container(
                            padding: const EdgeInsets.only(left:5,right:5,top:1,bottom:1),
                            decoration: BoxDecoration(
                              color:Theme.of(context).colorScheme.secondary,
                              borderRadius:
                              BorderRadius.all(Radius.circular(7.0)),
                            ),
                            child: Text('${market.rate} ✩',
                              style:Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .merge(TextStyle(color: Theme.of(context).primaryColorLight,)
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                  Padding(
                    padding: EdgeInsets.only(right:10),
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Expanded(
                            child:Container(
                              padding:EdgeInsets.only(left:10,right:10,bottom:5),
                              child:Text(market.subtitle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style:Theme.of(context).textTheme.caption),
                            ),
                          ),
                          Text(Helper.priceDistance(market.distance),
                              style:Theme.of(context)
                                  .textTheme
                                  .caption
                          ),

                        ]
                    ),
                  ),


                ]
            )
          )
        ],
      ),
    );
  }
}
