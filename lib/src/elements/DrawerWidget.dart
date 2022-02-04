import 'package:flutter/material.dart';
import 'package:multisuperstore/src/social_login/google.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../../generated/l10n.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  @override
  void initState() {
    print('image show${currentUser.value.image}');
    // TODO: implement initState
    super.initState();
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(2),
        children: <Widget>[
          GestureDetector(
            onTap: () {
              currentUser.value.apiToken != null
                  ? Navigator.of(context).pushNamed('/Profile')
                  : Navigator.of(context).pushNamed('/Login');
            },
            child: currentUser.value.apiToken != null
                ? UserAccountsDrawerHeader(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0x1D, 0x1D, 0x1F, 1.0),
                    ),
                    accountName: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentUser.value.name,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ]),
                    accountEmail: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentUser.value.displayEmail,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ]),
                    currentAccountPictureSize:
                        Size(MediaQuery.of(context).size.width / 1.5, 100),
                    currentAccountPicture: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      color: Colors.transparent,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                                child: Image.asset(
                              "assets/img/profile_placeholder.png",
                              fit: BoxFit.cover,
                              width: 100.0,
                              height: 100.0,
                            )),
                          ]),
                    )
                    // currentAccountPicture: CircleAvatar(
                    //   // backgroundColor: Theme.of(context).colorScheme.secondary,
                    //   backgroundColor: Colors.red,
                    //   backgroundImage: /*currentUser.value.image != 'no_image' && currentUser.value.image != null
                    //       ? NetworkImage(currentUser.value.image)
                    //       : */AssetImage(
                    //     // 'assets/img/userImage.png',
                    //     'assets/img/profile_placeholder.png',
                    //   ),
                    // ),
                    )
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          size: 32,
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(1),
                        ),
                        SizedBox(width: 30),
                        Text(
                          S.of(context).guest,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
          ),

          ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 2);
              },
              // leading: Icon(
              //   Icons.home,
              //   color: Theme.of(context).focusColor.withOpacity(1),
              // ),
              title: Image.asset(
                "assets/img/menu_home.png",
                fit: BoxFit.fitWidth,
              )),

          currentUser.value.apiToken != null
              ? ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Profile');
                  },
                  // leading: Icon(
                  //   Icons.person,
                  //   color: Theme.of(context).focusColor.withOpacity(1),
                  // ),
                  title: Image.asset(
                    "assets/img/menu_profile.png",
                    fit: BoxFit.fitWidth,
                  ))
              : Container(),

          ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Orders');
              },
              // leading: Icon(
              //   Icons.panorama_wide_angle,
              //   color: Theme.of(context).focusColor.withOpacity(1),
              // ),

              title: Image.asset(
                "assets/img/menu_i_miei_ordini.png",
                fit: BoxFit.fitWidth,
              )),

          ListTile(
              onTap: () {
                if (currentUser.value.apiToken != null) {
                  Navigator.of(context).pushNamed('/H_MyBooking');
                } else {
                  Navigator.of(context).pushNamed('/Login');
                }
              },
              // leading: Icon(
              //   Icons.panorama_wide_angle,
              //   color: Theme.of(context).focusColor.withOpacity(1),
              // ),
              title: Image.asset(
                "assets/img/menu_servizi.png",
                fit: BoxFit.fitWidth,
              )),
          ListTile(
              onTap: () {
                if (currentUser.value.apiToken != null) {
                  Navigator.of(context).pushNamed('/TableBookings');
                } else {
                  Navigator.of(context).pushNamed('/Login');
                }
              },
              // leading: Icon(
              //   Icons.panorama_wide_angle,
              //   color: Theme.of(context).focusColor.withOpacity(1),
              // ),
              title: Image.asset(
                "assets/img/menu_le_miei_prenotazioni.png",
                fit: BoxFit.fitWidth,
              )),
          ListTile(
              onTap: () {
                if (currentUser.value.apiToken != null) {
                  Navigator.of(context).pushNamed('/wallet');
                } else {
                  Navigator.of(context).pushNamed('/Login');
                }
              },
              // leading: Icon(
              //   Icons.account_balance_wallet,
              //   color: Theme.of(context).focusColor.withOpacity(1),
              // ),
              title: Image.asset(
                "assets/img/menu_portafoglio.png",
                fit: BoxFit.fitWidth,
              )),
          ListTile(
              onTap: () {
                if (currentUser.value.apiToken != null) {
                  Navigator.of(context).pushNamed('/Chat', arguments: 4);
                } else {
                  Navigator.of(context).pushNamed('/Login');
                }
              },
              // leading: Icon(
              //   Icons.chat,
              //   color: Theme.of(context).focusColor.withOpacity(1),
              // ),
              title: Image.asset(
                "assets/img/menu_chat.png",
                fit: BoxFit.fitWidth,
              )),
          ListTile(
              onTap: () {
                if (currentUser.value.apiToken != null) {
                  Navigator.of(context).pushNamed('/My_FavoriteStore');
                } else {
                  Navigator.of(context).pushNamed('/Login');
                }
              },
              // leading: Icon(
              //   Icons.store,
              //   color: Theme.of(context).focusColor.withOpacity(1),
              // ),
              title: Image.asset(
                "assets/img/menu_preferiti.png",
                fit: BoxFit.fitWidth,
              )),
          ListTile(
              onTap: () {
                if (currentUser.value.apiToken != null) {
                  Navigator.of(context).pushNamed('/Settings');
                } else {
                  Navigator.of(context).pushNamed('/Login');
                }
              },
              // leading: Icon(
              //   Icons.settings,
              //   color: Theme.of(context).focusColor.withOpacity(1),
              // ),
              title: Image.asset(
                "assets/img/menu_impostazioni.png",
                fit: BoxFit.fitWidth,
              )),
          ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/Languages');
              },
              // leading: Icon(
              //   Icons.translate,
              //   color: Theme.of(context).focusColor.withOpacity(1),
              // ),
              title: Image.asset(
                "assets/img/menu_lingua.png",
                fit: BoxFit.fitWidth,
              )),
          // ListTile(
          //   onTap: () {
          //     if (Theme.of(context).brightness == Brightness.dark) {
          //       // setBrightness(Brightness.light);
          //       setting.value.brightness.value = Brightness.light;
          //     } else {
          //       setting.value.brightness.value = Brightness.dark;
          //       //  setBrightness(Brightness.dark);
          //     }
          //     // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          //     setting.notifyListeners();
          //   },
          //   // leading: Icon(
          //   //   Icons.brightness_6,
          //   //   color: Theme.of(context).focusColor.withOpacity(1),
          //   // ),
          //     title: Image.asset(
          //       "assets/img/menu_lingua.png",
          //       fit: BoxFit.fitWidth,
          //     )
          // ),
          ListTile(
              onTap: () {
                if (currentUser.value.apiToken != null) {
                  logout().then((value) {
                    signoutSocials();
                    showToast(
                        "${S.of(context).logout} ${S.of(context).successfully}",
                        gravity: Toast.BOTTOM,
                        duration: Toast.LENGTH_SHORT);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/Login', (Route<dynamic> route) => false,
                        arguments: 1);
                  });
                } else {
                  signoutSocials();
                  Navigator.of(context).pushNamed('/Login');
                }
              },
              // leading: Icon(
              //   Icons.exit_to_app,
              //   color: Theme.of(context).focusColor.withOpacity(1),
              // ),
              title: Image.asset(
                "assets/img/menu_logout.png",
                fit: BoxFit.fitWidth,
              )),

          ListTile(
            dense: true,
            title: Text(
              '${S.of(context).version} 2.1',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          )
        ],
      ),
    );
  }
}
