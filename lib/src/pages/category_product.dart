import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../elements/RectangleLoaderWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/CategorySwipeHeader.dart';
import '../models/category.dart';
import '../controllers/product_controller.dart';
import '../elements/BottomBarWidget.dart';
import '../models/product.dart';


// ignore: must_be_immutable
class CategoryProduct extends StatefulWidget {
  Category categoryData;
  String shopId;
  String shopName;
  String subtitle;
  String km;
  int shopTypeID;
  String latitude;
  String longitude;
  int focusId;
  CategoryProduct({Key key, this.categoryData, this.shopId, this.shopName, this.subtitle, this.km, this.shopTypeID, this.latitude, this.longitude, this.focusId}) : super(key: key);
  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class _CategoryProductState extends StateMVC<CategoryProduct> {
  ProductController _con;

  _CategoryProductState() : super(ProductController()) {
    _con = controller;
  }
  bool popperShow = false;
  @override
  void initState() {
    super.initState();
    _con.listenForProductsByCategory(int.parse(widget.categoryData.id));
  }

  tabMaker() {
    // ignore: deprecated_member_use
    List<Tab> tabs = List();

    _con.category_products.forEach((element) {
      tabs.add(Tab(
        text: element.subcategory_name,
      ));
    });
    return tabs;
  }

  void callback(bool nextPage) {
    setState(() {
      this.popperShow = nextPage;
    });
  }

  @override
  build(BuildContext context) {
    return DefaultTabController(
      length: _con.category_products.length,
      child: Scaffold(
        key: _con.scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: popperShow?Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: double.infinity,
              height: double.infinity,
              child: FlareActor(
                'assets/img/winners.flr',
                animation: 'boom',
              )
          ),
        ):BottomBarWidget(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool isScrolled) {
            return [
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: SliverCustomHeaderDelegate(
                    collapsedHeight: 50,
                    expandedHeight: 150,
                    paddingTop: MediaQuery.of(context).padding.top,
                    coverImgUrl: widget.categoryData.image,
                    pagetitle: widget.categoryData.name),
              ),
              SliverAppBar(
                pinned: true,
                floating: false,
                primary: false,
                backgroundColor: Theme.of(context).primaryColor,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: TabBar(
                    isScrollable: true,
                    tabs: tabMaker(),
                  ),
                ),
              ),
            ];
          },
          body:  _con.category_products.isEmpty? RectangleLoaderWidget() : MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: TabBarView(
                children: List.generate(
                  _con.category_products.length,
                      (index) {
                    Product _productDetails = _con.category_products.elementAt(index);

                    return CategorySwipeHeader(productData: _productDetails.productdetails, con: _con,shopId: widget.shopId,callback: callback, focusId: widget.focusId,
                       shopName: widget.shopName, subtitle: widget.subtitle,km: widget.km,shopTypeID: widget.shopTypeID,longitude: widget.longitude,latitude: widget.latitude,);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String pagetitle;

  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({this.collapsedHeight, this.expandedHeight, this.paddingTop, this.coverImgUrl, this.pagetitle});

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            this.coverImgUrl,
            height: MediaQuery.of(context).size.height / 0.5,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: EdgeInsets.only(right: 15),
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  padding: EdgeInsets.only(
                    right: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                this.pagetitle,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.headline1.merge(TextStyle(
                                  color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                        ),
                      ),
                      SizedBox(width: 15),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Icon(
                          Icons.search,
                          size: 20,
                          color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
