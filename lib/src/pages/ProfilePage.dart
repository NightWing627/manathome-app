import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/elements/PermissionDeniedWidget.dart';
import 'package:multisuperstore/src/models/user.dart';
import 'package:multisuperstore/src/repository/settings_repository.dart';
import 'package:multisuperstore/src/social_login/google.dart';
import 'package:toast/toast.dart';
import '../repository/user_repository.dart' as userRepo;
import 'package:multisuperstore/src/repository/user_repository.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Image(
                              image: AssetImage('assets/img/screenshot_1.jpg'),
                              height: 280,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 210),
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                              child: Column(
                                children: [
                                  Text('hh',
                                      style:
                                          TextStyle(color: Colors.transparent))
                                ],
                              ),
                            ),
                            Positioned(
                                top: 150,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: 90.0,
                                      width: 90.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: GestureDetector(
                                        onTap: () {
                                          Imagepickerbottomsheet();
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage:
                                              currentUser.value.image !=
                                                          'no_image' &&
                                                      currentUser.value.image !=
                                                          null
                                                  ? NetworkImage(
                                                      currentUser.value.image)
                                                  : AssetImage(
                                                      'assets/img/userImage.png',
                                                    ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Container(
                          color: Theme.of(context).primaryColor,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            currentUser.value.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(currentUser.value.displayEmail,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  .merge(TextStyle(
                                                      color: Colors.grey))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /**
                        Container(
                          margin: EdgeInsets.only(top:20,left:20,right:10),
                          child:Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child:Column(
                                  children: [
                                    Text('123343', textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline1,),
                                    SizedBox(height:5),
                                    Text('Like',style:Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Colors.grey)))
                                  ],
                                ),
                              ),
                              SizedBox(width:40),
                              Container(
                                child:Column(
                                  children: [
                                    Text('123343', textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline1,),
                                    SizedBox(height:5),
                                    Text('Comment',style:Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Colors.grey)))
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ), */
                            ],
                          )),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(top: 0),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/Pages', arguments: 2);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25),
                                        height: 60,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              S.of(context).home,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  .merge(TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Icon(
                                              Icons.home_outlined,
                                              color: Theme.of(context)
                                                  .backgroundColor
                                                  .withOpacity(0.5),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/Settings');
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25),
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              S.of(context).settings,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  .merge(TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Icon(
                                                Icons
                                                    .settings_applications_rounded,
                                                color: Theme.of(context)
                                                    .backgroundColor
                                                    .withOpacity(0.5))
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/Orders');
                                        // Navigator.of(context).pushNamed('/Pages', arguments: 4);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25),
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              S.of(context).my_orders,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  .merge(TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Icon(
                                              Icons.shopping_bag_outlined,
                                              color: Theme.of(context)
                                                  .backgroundColor
                                                  .withOpacity(0.5),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (Theme.of(context).brightness ==
                                            Brightness.dark) {
                                          // setBrightness(Brightness.light);
                                          setting.value.brightness.value =
                                              Brightness.light;
                                        } else {
                                          setting.value.brightness.value =
                                              Brightness.dark;
                                          //  setBrightness(Brightness.dark);
                                        }
                                        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                        setting.notifyListeners();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25),
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              Theme.of(context).brightness ==
                                                      Brightness.dark
                                                  ? S.of(context).light_mode
                                                  : S.of(context).dark_mode,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  .merge(TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Icon(
                                              Icons.brightness_6,
                                              color: Theme.of(context)
                                                  .backgroundColor
                                                  .withOpacity(0.5),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        logout().then((value) {
                                          signoutSocials();
                                          showToast(
                                              "${S.of(context).logout} ${S.of(context).successfully}",
                                              gravity: Toast.BOTTOM,
                                              duration: Toast.LENGTH_SHORT);
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/Login',
                                                  (Route<dynamic> route) =>
                                                      false,
                                                  arguments: 2);
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25),
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              S.of(context).logout,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  .merge(TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Icon(Icons.exit_to_app,
                                                color: Theme.of(context)
                                                    .backgroundColor
                                                    .withOpacity(0.5))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.camera),
                  title: new Text('Camera'),
                  onTap: () => getImage(),
                ),
                new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text('Gallery'),
                  onTap: () => getImagegaller(),
                ),
              ],
            ),
          );
        });
  }

  File _image;
  int currStep = 0;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        register(_image);
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImagegaller() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        register(_image);

        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }

  void register(File image) async {
    User _user = userRepo.currentUser.value;

    final String _apiToken = 'api_token=${_user.apiToken}';
    // ignore: deprecated_member_use
    final uri = Uri.parse(
        "${GlobalConfiguration().getString('base_url')}Api/profileimage/${currentUser.value.id}?$_apiToken");
    var request = http.MultipartRequest('POST', uri);
    var pic = await http.MultipartFile.fromPath('image', image.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      // Navigator.of(context).pushReplacementNamed('/Success');

      setState(() {
        currentUser.value.image = 'no_image';
        // ignore: deprecated_member_use
        currentUser.value.image =
            '${GlobalConfiguration().getString('api_base_url')}uploads/user_image/user_${currentUser.value.id}.jpg';
      });
      setCurrentUserUpdate(currentUser.value);
    } else {}
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }
}
