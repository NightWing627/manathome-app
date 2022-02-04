import 'package:flutter/material.dart';
import 'package:multisuperstore/src/Animation/CustomFDelegate.dart';
import 'package:multisuperstore/src/pages/stores.dart';

class MenuG extends StatelessWidget {
  const MenuG({
    Key key,
    @required this.customFDelegate,
    @required this.menuAnimation,
  }) : super(key: key);

  final CustomFDelegate customFDelegate;
  final AnimationController menuAnimation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 9),
        child: SizedBox(
          height: 340,
          width: 100,
          child: Flow(
            delegate: customFDelegate,
            children: [
              Align(
                child: Container(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/img/logo.png',
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Stores(
                        storeType: 1,
                        pageTitle: "Supermercati",
                        focusId: 14,
                        coverImage:
                            "https://new.canaryweb.it/uploads/shoptypecover_image/shoptypecover_14.png",
                        previewImage:
                            "https://new.canaryweb.it/uploads/preview_image/preview_14.png",
                      );
                    }));
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      color: Colors.grey[100],
                      child: Align(
                        child: Image.asset(
                          'assets/img/menu_icons/preview_14.png',
                          width: 70,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Stores(
                        storeType: 2,
                        pageTitle: "Ristoranti",
                        focusId: 15,
                        coverImage:
                            "https://new.canaryweb.it/uploads/shoptypecover_image/shoptypecover_15.png",
                        previewImage:
                            "https://new.canaryweb.it/uploads/preview_image/preview_15.png",
                      );
                    }));
                  },
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: menuAnimation.value == 1 ? 1 : 0,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: menuAnimation.value == 1 ? 100 : 0,
                      height: menuAnimation.value == 1 ? 100 : 0,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        color: Colors.grey[100],
                        child: Align(
                          child: Image.asset(
                            'assets/img/menu_icons/preview_15.png',
                            width: 70,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 400),
                  opacity: menuAnimation.value == 1 ? 1 : 0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    width: menuAnimation.value == 1 ? 100 : 0,
                    height: menuAnimation.value == 1 ? 100 : 0,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      color: Colors.grey[100],
                      child: Align(
                        child: Image.asset(
                          'assets/img/menu_icons/preview_16.png',
                          width: 70,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 600),
                  opacity: menuAnimation.value == 1 ? 1 : 0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 600),
                    width: menuAnimation.value == 1 ? 100 : 0,
                    height: menuAnimation.value == 1 ? 100 : 0,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      color: Colors.grey[100],
                      child: Align(
                        child: Image.asset(
                          'assets/img/menu_icons/preview_17.png',
                          width: 70,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  width: menuAnimation.value == 1 ? 100 : 0,
                  height: menuAnimation.value == 1 ? 100 : 0,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: Colors.grey[100],
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 900),
                      opacity: menuAnimation.value == 1 ? 1 : 0,
                      child: Align(
                        child: Image.asset(
                          'assets/img/menu_icons/preview_18.png',
                          width: 70,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  width: menuAnimation.value == 1 ? 100 : 0,
                  height: menuAnimation.value == 1 ? 100 : 0,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: Colors.grey[100],
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 1100),
                      opacity: menuAnimation.value == 1 ? 1 : 0,
                      child: Align(
                        child: Image.asset(
                          'assets/img/menu_icons/preview_19.png',
                          width: 70,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
