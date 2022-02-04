
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/Widget/horizontal_time_picker.dart';
import 'package:multisuperstore/src/controllers/order_controller.dart';
import 'package:multisuperstore/src/elements/EmptyOrdersWidget.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/models/cart_responce.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:toast/toast.dart';

import 'category_product.dart';
import 'map.dart';

// ignore: must_be_immutable
class BookingDetailsService extends StatefulWidget {
  BookingDetailsService({Key key}) : super(key: key);
  @override
  _BookingDetailsServiceState createState() => _BookingDetailsServiceState();
}

class _BookingDetailsServiceState extends StateMVC<BookingDetailsService> {
  TextEditingController _timeController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String _hour, _minute, _time;
  int numberOfItems = 0;
  File _image;

  _BookingDetailsServiceState() : super() {
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    _timeController.text = '09:00 AM';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children:[
            SingleChildScrollView(
              child: Column(
                children: [
                  Ink.image(
                      image: AssetImage('assets/img/servicedefaultbg.jpg',),
                      width:double.infinity,
                      height:200,
                      fit:BoxFit.fill
                  ),
                  SizedBox(height: 15,),
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Autofficina Rossi',
                              style: Theme.of(context).textTheme.headline3
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Kochi',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child:Div(
                        child:Wrap(
                          children: [
                            Icon(Icons.star,
                              size: 18,
                              color: Colors.orange,
                            ),
                            Container(
                                padding: EdgeInsets.only(top:2,left:5),
                                child: Text('5',style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Theme.of(context).backgroundColor.withOpacity(0.9))))
                            ),
                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 15,),
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text('BOOK A SERVICE',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: DatePicker(
                                DateTime.now(),
                                width: 50,
                                height: 100,
                                initialSelectedDate: DateTime.now(),
                                selectionColor: Colors.black,
                                selectedTextColor: Colors.white,
                                onDateChange: (date) {
                                  // New date selected
                                  setState(() {
                                    // _con.addTodate(date.toString());
                                    var formatter = new DateFormat('yyyy-MM-dd');
                                    String formattedDate = formatter.format(date);
                                    print(formattedDate);
                                  });
                                },
                              ),
                            ),
                          ])),
                  SizedBox(height: 10,),
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text('SELECT TIME',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 20, left: 20),
                    child: HorizontalTimePicker(
                      key: UniqueKey(),
                      startTimeInHour: 9,
                      endTimeInHour: 24,
                      dateForTime: DateTime.now(),
                      selectedTimeTextStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: "Helvetica Neue",
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        height: 1.0,
                      ),
                      timeTextStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: "Helvetica Neue",
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        height: 1.0,
                      ),
                      defaultDecoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border.fromBorderSide(BorderSide(
                          color: Color.fromARGB(255, 151, 151, 151),
                          width: 1,
                          style: BorderStyle.solid,
                        )),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Colors.black,
                        border: Border.fromBorderSide(BorderSide(
                          color: Color.fromARGB(255, 151, 151, 151),
                          width: 1,
                          style: BorderStyle.solid,
                        )),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      disabledDecoration: const BoxDecoration(
                        color: Colors.black26,
                        border: Border.fromBorderSide(BorderSide(
                          color: Color.fromARGB(255, 151, 151, 151),
                          width: 1,
                          style: BorderStyle.solid,
                        )),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      showDisabled: true,
                    ),
                  ),
                  /*InkWell(
                onTap: () {
                  _selectTime(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, right: 20, left: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Theme.of(context).dividerColor),
                  child: TextFormField(
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                    onSaved: (String val) {

                    },
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _timeController,
                    decoration: InputDecoration(
                        disabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                        // labelText: 'Time',
                        contentPadding: EdgeInsets.all(5)),
                  ),
                ),
              ),*/

                  SizedBox(height: 10,),
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Inserisci i tuoi commenti',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextFormField(

                          decoration: InputDecoration(fillColor: Colors.grey[300], filled: true, border: InputBorder.none,),
                          minLines: 6, // any number you need (It works as the rows for the textarea)
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      )
                    ],
                  ),
                  // _guestNumber(),
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Carica foto del danno',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.15,
                    child: GestureDetector(
                      onTap: () {
                        Imagepickerbottomsheet();
                      },
                      child: _image == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                        height: double.infinity,
                        width:double.infinity,
                        fit: BoxFit.fill,
                      ): Image.file(_image),),
                  ),
                  SizedBox(height: 70,),

                ],
              ),
            ),
            Container(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 27.0, left: 10.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            new Positioned(
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  margin: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: FlatButton(
                    child: Text('Proceed to pay', style: TextStyle(fontSize: 18.0),),
                    color: Theme.of(context).colorScheme.secondary,
                    textColor: Colors.white,
                    onPressed: () {
                      // showToast("Your Booking is ordered successfully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
                      // Navigator.pop(context);
                      Navigator.of(context).pushNamed('/Payment');
                    },
                  ),
                ),
              ),
            )
          ]
      ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });}

  Widget _guestNumber() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _decrementButton(),
          Text(
            '${numberOfItems}',
            style: TextStyle(fontSize: 16.0),
          ),
          _incrementButton(),
        ],
      ),
    );
  }

  Widget _incrementButton() {
    return FloatingActionButton(
      heroTag: "btnIncrease",
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      onPressed: () {
        setState(() {
          numberOfItems++;
        });
      },
    );
  }

  Widget _decrementButton() {
    return FloatingActionButton(
        heroTag: "btndecrease",
        onPressed: () {
          setState(() {
            numberOfItems--;
          });
        },
        child: Icon(Icons.remove, color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.secondary);
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

  int currStep = 0;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // widget.con.bannerData.uploadImage = _image;
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImagegaller() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // widget.con.bannerData.uploadImage =_image;

        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }
}















