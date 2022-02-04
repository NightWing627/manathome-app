import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import '../models/timeslot.dart';
import '../repository/order_repository.dart';
import 'package:intl/intl.dart';

class TimeSlotWidget extends StatefulWidget {
  const TimeSlotWidget({Key key, this.choice}) : super(key: key);
  final List<TimeSlot> choice;
  @override
  _TimeSlotWidgetState createState() => _TimeSlotWidgetState();
}

class _TimeSlotWidgetState extends State<TimeSlotWidget> {
  DatePickerController _controller = DatePickerController();

  DateTime now = new DateTime.now();
  String selectDate;
  String selectTime;
  bool changeDate = false;
  @override
  void initState() {
    var formatter = new DateFormat('yyyy-MM-dd');
    selectDate = formatter.format(now);
    super.initState();
    int i = 0;
    widget.choice.forEach((element) {
      if (i == 0) {
        selectTime = element.fromTime;
      }
      i++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                )),
              ),
              child: Text(S.of(context).select_your_delivery_time_slot, style: Theme.of(context).textTheme.headline1)),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Container(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                child: DatePicker(
                  DateTime.now(),
                  width: 65,
                  height: 100,
                  controller: _controller,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      // _selectedValue = date;
                      // _con.addTodate(date.toString());
                      var formatter = new DateFormat('yyyy-MM-dd');
                      String formattedDate = formatter.format(date);
                      //currentbookdetail.value.date = formattedDate;
                      //print(formattedDate);
                      selectDate = formattedDate;

                      if (currentCheckout.value.deliveryTime == '' || currentCheckout.value.deliveryTime == null) {
                        currentCheckout.value.deliveryTimeSlot = formattedDate + '  ' + selectTime;
                      } else {
                        currentCheckout.value.deliveryTimeSlot = formattedDate + '  ' + currentCheckout.value.deliveryTime;
                      }
                    });
                  },
                ),
              ),
            ])),
          ),
        ]),
      ),
      changeDate == false
          ? Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.choice.length,
                    itemBuilder: (context, index) {
                      TimeSlot _datetime = widget.choice.elementAt(index);

                      var now = new DateTime.now();
                      var formatter = new DateFormat('yyyy-MM-dd');
                      String currentDate = formatter.format(now);

                      if (now.hour >= _datetime.timeid && _datetime.timeid != 1 && selectDate == currentDate) {
                        return Container();
                      } else {
                        return Row(
                          children: <Widget>[
                            GestureDetector(
                                onTap: () => {
                                      widget.choice.forEach((_l) {
                                        setState(() {
                                          _l.selected = false;
                                        });
                                      }),
                                      _datetime.selected = true,
                                      currentCheckout.value.deliveryTime = _datetime.fromTime +' '+_datetime.toTime,
                                      currentCheckout.value.deliveryTimeSlot = selectDate + '  ' + currentCheckout.value.deliveryTime,
                                    },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: _datetime.selected ? Colors.blueAccent : Theme.of(context).dividerColor,
                                  ),
                                  child: Center(
                                      child: Text('${_datetime.fromTime} to ${_datetime.toTime}',
                                          style: TextStyle(
                                              fontSize: 11.0, color: _datetime.selected ? Colors.white : Colors.black, fontWeight: FontWeight.w700))),
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.06,
                            ),
                          ],
                        );
                      }
                    }),
              ),
            )
          : Container(),
      SizedBox(height: 10.0),
    ]);
  }
}

class Datetime {
  Datetime({this.timeid, this.time, this.selected});
  int timeid;
  String time;
  bool selected;
}

List<Datetime> timeclock = <Datetime>[
  Datetime(timeid: 1, time: 'Any Time 11.30 to 20.30', selected: true),
  Datetime(timeid: 14, time: '11.30 to 14.00', selected: false),
  Datetime(timeid: 18, time: '15.30 TO 17.30', selected: false),
  Datetime(timeid: 20, time: '18.30 TO 20.30', selected: false),
];
