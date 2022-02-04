import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/elements/daily_staples.dart';
import 'package:multisuperstore/src/elements/fruits_vegetables.dart';
import 'package:multisuperstore/src/elements/oil_items.dart';
import 'package:multisuperstore/src/elements/snacks_biscuits.dart';

class CategoryProducts extends StatefulWidget {
  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  build(BuildContext context) {
    return DefaultTabController(
      length: 4,

      child: Scaffold(
      /*  appBar:AppBar(
            elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right:15),
              child: Icon(Icons.search),
            ),
            Padding(
              padding: EdgeInsets.only(right:15),
              child: Icon(Icons.shopping_cart),
            ),



          ],
          title:Text('Category Product',style:Theme.of(context).textTheme.headline1),
          titleSpacing: 0,

        ),*/
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool isScrolled) {
            return [








              SliverAppBar(
                pinned: true,
                floating: true,
                automaticallyImplyLeading: true,

                /*iconTheme: IconThemeData(
                  color: Colors.transparent,
                ),*/
                      title: Text(S.of(context).category_product,style:Theme.of(context).textTheme.headline1),
                     titleSpacing: 0,


                      bottom: TabBar(

                isScrollable: true,


                  tabs: [

                    Tab(text: "Fruits & Vegetables"),
                    Tab(text: "Daily Staples"),
                    Tab(text: "Snacks & Biscuits"),
                    Tab(text: "Oil Items"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              FruitsVegetables(),
              DailyStaples(),
              SnacksBiscuits(),
              OilItems(),

            ],
          ),
        ),
      ),
    );
  }
}
