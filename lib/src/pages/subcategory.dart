import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/controllers/hservice_controller.dart';
import 'package:multisuperstore/src/elements/CategoryLoaderWidget.dart';
import 'package:multisuperstore/src/models/hsubcategory.dart';
import 'package:multisuperstore/src/pages/table_reservation_service.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';


// ignore: must_be_immutable
class SubCategory extends StatefulWidget {
  String id;

  SubCategory({Key key, this.id,}) : super(key: key);
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends StateMVC<SubCategory> {

  HServiceController _con;

  _SubCategoryState() : super(HServiceController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForSubcategories(widget.id);
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color:Theme.of(context).primaryColorDark),
        child: SafeArea(child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only( left: 10.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                color:Theme.of(context).primaryColorLight.withOpacity(0.8),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 10.0),
                  Text(S.of(context).sub_category,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3.merge(TextStyle(color:Theme.of(context).primaryColorLight.withOpacity(0.8))),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
             Expanded(
              child: Container(
                padding: EdgeInsets.only(top:10,),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _con.subcategory.isEmpty ? CategoryLoaderWidget() :  Container(
                             padding: EdgeInsets.only(top:15,left:20,right:20),
                             child:Wrap(
                               runSpacing: 20,
                               children:List.generate(_con.subcategory.length, (index) {
                                 HSubcategory _subcategory =  _con.subcategory.elementAt(index);
                                 return Div(
                                     colS:4,
                                     colM:size.width > 769 ? 2 : 4,
                                     colL:size.width > 769 ? 2 : 4,
                                     child:Container(
                                         child:Column(
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           children: [
                                             Container(
                                               height:size.width > 769 ? 110 :80,width:size.width > 769 ? 110 :80,
                                               child: GestureDetector(
                                                 onTap: () {
                                                   if (index%3==2) {
                                                     Navigator.of(context).push(
                                                         MaterialPageRoute(
                                                             builder: (_) =>
                                                                 TableReservationServicePage()));
                                                   } else {
                                                     _con.gotoBooking(widget.id,_subcategory.id,_subcategory.name, _subcategory.image);
                                                   }
                                                 },
                                                 child: new CircleAvatar(
                                                   backgroundImage: new NetworkImage(_subcategory.image),
                                                   radius: 80.0,
                                                 ),


                                               ),
                                             ),
                                             SizedBox(height:5),

                                             Text(_subcategory.name,
                                                 textAlign: TextAlign.center,
                                                 style:Theme.of(context).textTheme.bodyText1)
                                           ],
                                         )
                                     )
                                 );
                               })
                             ),


                           )


                    ],
                  ),
                ),
              ),
            ),



          ],
        ),)
      ),
    );




  }
}















