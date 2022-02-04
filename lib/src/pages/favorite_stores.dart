import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../elements/ShopListBoxWidget.dart';
import '../controllers/vendor_controller.dart';
import '../Widget/custom_divider_view.dart';

// ignore: must_be_immutable
class FavoriteStores extends StatefulWidget {
   int storeType;
   String pageTitle;
   int focusId;
   String coverImage;
   String previewImage;
   FavoriteStores({Key key, this.storeType,this.pageTitle,this.focusId, this.coverImage, this.previewImage}) : super(key: key);
  @override
  _FavoriteStoresState createState() => _FavoriteStoresState();
}

class _FavoriteStoresState extends StateMVC<FavoriteStores> {

  VendorController _con;

  _FavoriteStoresState() : super(VendorController()) {
    _con = controller;
  }
  @override
  void initState() {
    // TODO: implement initState
    _con.listenForVendorList(widget.storeType, widget.focusId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: SliverCustomHeaderDelegate(
                    collapsedHeight: 100,
                    expandedHeight: 150,
                    paddingTop: MediaQuery.of(context).padding.top,
                    shopType: widget.storeType,
                    pageTitle: widget.pageTitle,
                    coverImage: widget.coverImage
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  ShopListBoxWidget(con: _con, pageTitle: widget.pageTitle,shopType: widget.storeType,focusId: widget.focusId,previewImage: widget.previewImage, key: null,),
                ]),
              ),
            ],
          ),
          Column(
              children:[
                Align(
                  alignment: Alignment.topLeft,
                  child:Padding(
                      padding: EdgeInsets.only(top:40,left:10),
                      child:  Container(
                        width:40,height:40,
                        child:IconButton(
                            onPressed: (){
                             Navigator.pop(context);
                            },
                            icon:Icon(Icons.arrow_back_ios),
                            color:Colors.white
                        ),
                      )

                  ),
                ),
              ]
          )
        ]
      ),
    );
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final int shopType;
  final String coverImage;
  final String pageTitle;

  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.shopType,
    this.pageTitle,
    this.coverImage,
  });

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
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 300).clamp(0, 255).toInt();
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
            coverImage,
            height: MediaQuery.of(context).size.height / 0.5,
            width: double.infinity,
            fit: BoxFit.fitWidth,
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
                  padding: EdgeInsets.only(top: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 10, right: 10, top: 25),
                                child: Text(
                                  pageTitle,
                                  style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                                      )),
                                )),
                          ],
                        ),
                        CustomDividerView(
                          dividerHeight: 1.0,
                          color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    S.of(context).stores_near_by,
                                    style: Theme.of(context).textTheme.caption.merge(TextStyle(
                                          color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                                        )),
                                  ),
                                ),
                             /**   Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Icon(
                                    Icons.filter_list,
                                    size: 19,
                                    color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'SORT/FILTER',
                                  style: Theme.of(context).textTheme.caption.merge(TextStyle(
                                        color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                                      )),
                                ), */
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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



