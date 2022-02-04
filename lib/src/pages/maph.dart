import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multisuperstore/src/elements/ProviderListWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/map_controller.dart';
import '../elements/CircularLoadingWidget.dart';


class MapWidgetH extends StatefulWidget {

  final GlobalKey<ScaffoldState> parentScaffoldKey;

  MapWidgetH({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends StateMVC<MapWidgetH> {
  MapController _con;

  _MapWidgetState() : super(MapController()) {
    _con = controller;
  }

  @override
  void initState() {

    _con.getCurrentProviderLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        title: Text(
          'Select Provider',
          style: Theme.of(context).textTheme.headline3.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.my_location,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {
              _con.goCurrentLocation();
            },
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {

              Navigator.of(context).pushNamed('/H_All_provider', arguments: _con.providerList);
            },
          ),
        ],
      ),
      body: Stack(
//        fit: StackFit.expand,
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          _con.cameraPosition == null
              ? CircularLoadingWidget(height: 0)
              :
    GoogleMap(
            mapToolbarEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: _con.cameraPosition,
            markers: Set.from(_con.allProviderMarkers),
            onMapCreated: (GoogleMapController controller) {
              _con.mapController.complete(controller);
            },
            onCameraMove: (CameraPosition cameraPosition) {
              _con.cameraPosition = cameraPosition;
            },
            onCameraIdle: () {
              _con.getProvider();
            },
            polylines: _con.polylines,
          ),
         ProviderListWidget(
            providerList: _con.providerList,
          ), 
        ],
      ),
    );
  }
}
