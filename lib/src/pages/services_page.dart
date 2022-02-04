import 'package:flutter/material.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/providerlist.dart';
import 'package:multisuperstore/src/models/servicemodel.dart';
import 'package:multisuperstore/src/models/userreview.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// ignore: must_be_immutable
class ServicesPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  ProviderList providerData;


  ServicesPage({Key key, this.parentScaffoldKey, this.providerData}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends StateMVC<ServicesPage> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Stack(children: [
                Container(
                    height: MediaQuery.of(context).size.height - 60.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent),
                Positioned(
                    top: 75.0,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(75.0)),
                        ),
                        height: MediaQuery.of(context).size.height - 100.0,
                        width: MediaQuery.of(context).size.width,
                        child:Column(
                          children:[
    Expanded(
                            child:ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemCount: 1,
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.only(top: 16,right: 2),
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, int index) {
                                return Padding(
                                    padding: const EdgeInsets.only(top: 130),
                                    child:Container(
                                        height:
                                        MediaQuery.of(context).size.height -
                                            300.0,
                                        child: ListView(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left:15,right:15),
                                                child: Text(S.of(context).services,

                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3

                                                ),
                                              ),
                                              ListView.builder(
                                                  itemCount: widget.providerData.service.length,
                                                  shrinkWrap: true,
                                                  itemBuilder: (BuildContext context, int index) {

                                                    return Serviceblock(choice: widget.providerData.service.elementAt(index));
                                                  }),



                                              SizedBox(height: 20.0),
                                            /** ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: _con.review.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return Reviewblock(review: _con.review[index]);
                                                  }) */



                                            ]))
                                  );


                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 20);
                              },
                            ),
    ),


















                        ]),
                    )),
                Positioned(
                  top: 10.0,
                  left: MediaQuery.of(context).size.width * 0.1 ,
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                  image: NetworkImage(widget.providerData.image),
                                  fit: BoxFit.cover)),
                          height: 158.0,
                          width: size.width > 769 ? size.width * 0.1: size.width * 0.3),
                      SizedBox(width: 7.0),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 79.0),
                            Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Text(currentBookDetail.value.providerName,

                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2

                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top:size.width > 769 ? 10 :0,),
                              child:Text(currentBookDetail.value.categoryName,

                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),

                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 1,
                                  itemSize: 19,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },

                                ),
                                SizedBox(width: 5.0),
                                Text('2.5(56)',

                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      /*container end */
                    ],
                  ),
                ),
                Positioned(
                  top: 45.0,
                  right: size.width > 769 ? size.width * 0.1 :(MediaQuery.of(context).size.width / 2) - 175.0,
                  child: new Container(
                    width: 50.0,
                    height: 50.0,
                    child: Card(
                      child: new CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.favorite_border,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      elevation: 18.0,
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                    ),
                  ),
                ),
              ])
            ]));
  }


}
class Serviceblock extends StatefulWidget {
  const Serviceblock({Key key, this.choice}) : super(key: key);
  final Servicemodel choice;

  @override
  _ServiceblockState createState() => _ServiceblockState();
}

class _ServiceblockState extends State<Serviceblock> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child:Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(height: 20.0),
                    Text(widget.choice.services_name,
                        overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyle(fontSize: 14.0)),
                    Text('1 hrs', style: TextStyle(fontSize: 15.0, color: Colors.grey))
                  ]),
                ),
                Container(
                  width:MediaQuery.of(context).size.width * 0.2,
                  child: Text(Helper.pricePrint(widget.choice.amount),
                      style:Theme.of(context).textTheme.subtitle2),
                ),

                Container(
                    height: 40.0,
                    width: MediaQuery.of(context).size.width * 0.22,
                    decoration: BoxDecoration(color:Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(30.0)),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () {
                        currentBookDetail.value.service = widget.choice.services_name;
                        currentBookDetail.value.chargeperhrs = widget.choice.amount;

                        Navigator.of(context).pushNamed('/H_Booking');
                      },
                      color: Theme.of(context).colorScheme.secondary,
                      child: Center(
                          child: Text(
                           S.of(context).book,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.white,

                            ),
                          )),
                    )),
              ],
            )));
  }
}

class Reviewblock extends StatelessWidget {
  Reviewblock({Key key, this.review}) : super(key: key);
  final HReview review;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.purple),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 60.0,
                  child: Text('',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
                Text(review.date,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    )),
                RatingBar.builder(
                  initialRating: double.parse(review.rate),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 12,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Text(review.review,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                )),
          ),
        ]),
      ),
    );
  }
}