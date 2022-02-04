import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../repository/product_repository.dart';
import '../elements/NoDataFoundWidget.dart';
import '../Widget/custom_divider_view.dart';
import '../elements/Productbox2Widget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../elements/ProductListBottomWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/product_controller.dart';
import '../elements/SearchWidget.dart';
import '../elements/BottomBarWidget.dart';
import '../elements/CircularLoadingWidget.dart';
import '../../generated/l10n.dart';

// ignore: must_be_immutable
class ProductList extends StatefulWidget {
  // ignore: non_constant_identifier_names
  ProductList(
      {Key key, this.pageType, this.offer, this.subcategory_Id, this.pageTitle})
      : super(key: key);
  String pageType;
  String offer;
  // ignore: non_constant_identifier_names
  String subcategory_Id;
  String pageTitle;
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends StateMVC<ProductList> {
  int dropDownValue = 0;
  int selectedRadio;
  ProductController _con;

  _ProductListState() : super(ProductController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    if (widget.pageType == 'category_wise_offer') {
      setState(() => _con.pageTitle = widget.pageTitle);
      // _con.listenForProduct_type(widget.offer, widget.subcategory_Id);
    } else if (widget.pageType == 'most_popular') {
      setState(() => _con.pageTitle = widget.pageTitle);
      //   _con.listenForProduct_type('no', widget.subcategory_Id);
    } else {
      _con.listenForProductList('popularity');
    }
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  void showModal() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 300,
              color: Color(0xff737373),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      BottomSheetPart(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** floatingActionButton: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),

          child: Container(
              height: MediaQuery.of(context).size.width * 0.15,
              color: Colors.transparent,
              child: Center(
                child: Card(
                  elevation: 5,
                  shape: StadiumBorder(),
                  color: Colors.blueAccent,
                  child: FlatButton(
                      onPressed: () {
                        showModal();
                      },
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                      color: Colors.blueAccent,
                      shape: StadiumBorder(),
                      child: Wrap(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(
                              Icons.local_dining,
                              color: Colors.white,
                              size: 17,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Text(
                            'BROWSE MENU',
                            style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      )),
                ),
              ))), */
      floatingActionButton: BottomBarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 0, right: 0, top: 15),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Theme.of(context).primaryColorLight,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                currentSearch.value.shopName ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.headline4.merge(TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    )),
              ),
              trailing: Wrap(children: [
                IconButton(
                  icon: Icon(Icons.search),
                  color: Theme.of(context).primaryColorLight,
                  onPressed: () {
                    Navigator.of(context).push(SearchModal());
                  },
                ),
                _con.loadCart
                    ? SizedBox(
                        width: 60,
                        height: 60,
                        child: RefreshProgressIndicator(),
                      )
                    : ShoppingCartButtonWidget(
                        iconColor: Theme.of(context).hintColor,
                        labelColor: Theme.of(context).colorScheme.secondary,
                      ),
              ]),
              onTap: () {},
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: SingleChildScrollView(
                  child: _con.productList.isEmpty
                      ? CircularLoadingWidget(height: 500)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                top: 5,
                                right: 20,
                              ),
                              child: Wrap(
                                children: [
                                  Text(S.of(context).search_instead_for),
                                  SizedBox(width: 3),
                                  Text('currentSearch.value.searchTxt',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ))),
                                ],
                              ),
                            ),
                            ListView.separated(
                              scrollDirection: Axis.vertical,
                              itemCount: _con.productList.length,
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.only(top: 10),
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, int index) {
                                if (_con.productList[index].id != 'No_data') {
                                  return ProductBox2Widget(
                                    choice: _con.productList[index],
                                    con: _con,
                                    shopId: currentSearch.value.shopId,
                                    shopName: currentSearch.value.shopName,
                                    subtitle: currentSearch.value.subtitle,
                                    km: currentSearch.value.km,
                                    shopTypeID: currentSearch.value.shopTypeID,
                                    latitude: currentSearch.value.latitude,
                                    longitude: currentSearch.value.longitude,
                                  );
                                  /**
                                   * ProductBox2Widget(
                                      choice: _con.productList[index],
                                      con: _con,
                                      );
                                   */
                                } else {
                                  return NoDataFoundWidget();
                                }
                              },
                              separatorBuilder: (context, index) {
                                return CustomDividerView(
                                    dividerHeight: 1.0,
                                    color: Theme.of(context).dividerColor);
                              },
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetPart extends StatefulWidget {
  @override
  _BottomSheetPartState createState() => _BottomSheetPartState();
}

class _BottomSheetPartState extends State<BottomSheetPart> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).dividerColor,
            border: Border(
                bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 1,
            ))),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      'Fruits & Vegetables',
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      'Top Product',
                      style: Theme.of(context).textTheme.caption,
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
              Icon(Icons.close)
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ProductListBottomWidget(),
      ),
    ]);
  }
}
