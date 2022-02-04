import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/elements/CategoryLoaderWidget.dart';
import 'package:multisuperstore/src/elements/CategoryshopType.dart';
import 'package:multisuperstore/src/elements/CustomAppBar.dart';
import 'package:multisuperstore/src/elements/LocationWidget.dart';
import 'package:multisuperstore/src/elements/SearchBarWidget.dart';
import 'package:multisuperstore/src/elements/SearchWidgetShop.dart';
import 'package:multisuperstore/src/elements/ShopTypesSlider.dart';
import 'package:multisuperstore/src/elements/ShoppingCartButtonWidget.dart';
import 'package:multisuperstore/src/models/shop_type.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:multisuperstore/src/repository/vendor_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/map_controller.dart';

import '../elements/CircularLoadingWidget.dart';

class VendorMapWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  VendorMapWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _VendorMapWidgetState createState() => _VendorMapWidgetState();
}

class _VendorMapWidgetState extends StateMVC<VendorMapWidget> {
  MapController _con;

  _VendorMapWidgetState() : super(MapController()) {
    _con = controller;
  }

  @override
  void initState() {
    /** _con.currentMarket = widget.routeArgument?.param as Market;
        if (_con.currentMarket?.latitude != null) {
        // user select a market
        _con.getMarketLocation();
        _con.getDirectionSteps();
        } else {
        _con.getCurrentLocation();
        } 
        **/

    _con.getCurrentLocation();
    _con.listenForShopType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        parentScaffoldKey: widget.parentScaffoldKey,
        showModal: showModal,
      ),
      body: Stack(
//        fit: StackFit.expand,
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          _con.cameraPosition == null
              ? CircularLoadingWidget(height: 0)
              : GoogleMap(
                  mapToolbarEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: _con.cameraPosition,
                  markers: Set.from(_con.allMarkers),
                  onMapCreated: (GoogleMapController controller) {
                    _con.mapController.complete(controller);
                  },
                  onCameraMove: (CameraPosition cameraPosition) {
                    _con.cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    _con.getMarketsOfArea();
                  },
                  polylines: _con.polylines,
                ),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Row(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: []),
                  Expanded(
                    child: SearchBarWidget(
                      onClickFilter: (event) {},
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SearchResultWidgetShop();
                      }));
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            //    color: Color(0xFFaeaeae).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4)),
                        child: Icon(
                          Icons.mic,
                          color: Theme.of(context).hintColor,
                          size: 40,
                        )),
                  ),
                ]),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0),
              child: Container(
                color: Colors.white,
                height: 100,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: List<Widget>.generate(_con.shopTypeList.length,
                        (index) {
                      ShopType _shopType = _con.shopTypeList.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                          ),
                          child: Column(children: [
                            Container(
                              width: 57,
                              height: 57,
                              child: GestureDetector(
                                onTap: () {
                                  _con.listenForNearMarketsWithID(
                                      _con.currentAddress,
                                      _con.currentAddress,
                                      _shopType.id);
                                },
                                child: new CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Image.network(
                                    _shopType.previewImage,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              child: Text(
                                _shopType.title.toUpperCase(),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.orange[900],
                                    fontFamily: 'Futura-Book-Bold',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ]),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            _con.shopTypeList.isEmpty
                ? CategoryLoaderWidget()
                : Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: CategoryShopType(
                      shopType: _con.shopTypeList,
                      shopTypeStatic: 1,
                    ),
                  ),

            // ShopTopSlider(
            //   vendorList: _con.topMarkets,
            //   key: null,
            // ),
          ]),
        ],
      ),
    );
  }

  void showModal() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            color: Color(0xff737373),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              LocationModalPart(),
                            ]),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Container(
                        width: double.infinity,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                            onPressed: () {
                              setState(() => currentUser.value);
                              Navigator.pop(context);
                            },
                            padding: EdgeInsets.all(15),
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(1),
                            child: Text(
                              S.of(context).proceed_and_close,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(TextStyle(color: Colors.white)),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
