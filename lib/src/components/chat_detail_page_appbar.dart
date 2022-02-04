import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
// ignore: must_be_immutable
class ChatDetailPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  ChatDetailPageAppBar({Key key, this.shopId, this.shopName, this.shopMobile}) : super(key: key);
  String shopId;
  String shopName;
  String shopMobile;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                color: Theme.of(context).backgroundColor,
              ),
              SizedBox(
                width: 2,
              ),
              CircleAvatar(
                // ignore: deprecated_member_use
                backgroundImage: NetworkImage("${GlobalConfiguration().getString('base_upload')}uploads/vendor_image/vendor_$shopId.png"),
                maxRadius: 20,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$shopName ID:$shopId',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              ),
             /** IconButton(
                icon: Icon(Icons.call),
                tooltip: 'Call',
                onPressed: () {
                  //_callNumber();
                },
              ), */
            ],
          ),
        ),
      ),
    );
  }



  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
