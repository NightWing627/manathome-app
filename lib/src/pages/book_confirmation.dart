import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/controllers/hservice_controller.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class BookConfirmation extends StatefulWidget {
  @override
  _BookConfirmationState createState() => _BookConfirmationState();
}

class _BookConfirmationState extends StateMVC<BookConfirmation> {

  HServiceController _con;

  _BookConfirmationState() : super(HServiceController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color:Theme.of(context).primaryColorDark
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 27.0, left: 10.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 20.0),
                  Text(S.of(context).booking_confirmation,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.88,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text(
                                    '\$4',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w900, color: Colors.transparent),
                                  ),
                                  Text(S.of(context).price_hr, textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, color: Colors.transparent)),
                                ]),
                                Expanded(
                                    child: Column(
                                      children: [
                                        new Container(
                                          width: 110.0,
                                          height: 110.0,
                                          child: Card(
                                            child: new CircleAvatar(
                                              backgroundImage: new NetworkImage(currentBookDetail.value.providerImage),
                                              radius: 80.0,
                                            ),
                                            elevation: 2.0,
                                            shape: CircleBorder(),
                                            clipBehavior: Clip.antiAlias,
                                          ),
                                        ),
                                      ],
                                    )),
                                Column(children: [
                                  Text(
                                      '${Helper.pricePrint(currentBookDetail.value.chargeperhrs)}/Hrs',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.subtitle1
                                  ),

                                ]),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      currentBookDetail.value.providerName,
                                      style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontWeight: FontWeight.w700)),
                                    ),
                                    Text(
                                      currentBookDetail.value.providerMobile,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[

                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[
                                          Text(
                                            S.of(context).booking_services,
                                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontWeight: FontWeight.w800)),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            currentBookDetail.value.service,
                                            style: Theme.of(context).textTheme.subtitle2,
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            S.of(context).date,
                                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontWeight: FontWeight.w800)),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            currentBookDetail.value.date,
                                            style: Theme.of(context).textTheme.subtitle2,
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            S.of(context).time,
                                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontWeight: FontWeight.w800)),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            currentBookDetail.value.time,
                                            style: Theme.of(context).textTheme.subtitle2,
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            S.of(context).confirm_address,
                                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontWeight: FontWeight.w800)),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Container(
                                            width:size.width * 0.7,
                                            child:Text(
                                              currentBookDetail.value.address,
                                              style: Theme.of(context).textTheme.subtitle2,
                                            ),
                                          ),

                                          SizedBox(
                                            height: 20.0,
                                          ),

                                        ]
                                    )
                                  ]
                              ),
                            ],
                          )),
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
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            onPressed: () {

                              _con.book_firebase();
                            },
                            child: Center(
                                child: Text(
                                  S.of(context).book,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
