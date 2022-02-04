import 'package:flutter/cupertino.dart';
import 'package:multisuperstore/src/repository/vendor_repository.dart';
import '../models/tips.dart';
import '../repository/settings_repository.dart';
import '../helpers/helper.dart';
import '../repository/order_repository.dart';
import '../models/cart_responce.dart';
import '../repository/product_repository.dart';
import '../repository/user_repository.dart';
import '../Widget/custom_divider_view.dart';
import 'package:flutter/material.dart';
import '../controllers/cart_controller.dart';
import 'DeliveryModeWidget.dart';
import 'LocationWidget.dart';
import 'Productbox3Widget.dart';
import '../repository/product_repository.dart' as cartRepo;
import '../../generated/l10n.dart';

import 'TimeSlot.dart';

// ignore: must_be_immutable
class CheckoutListWidget extends StatefulWidget {
  CheckoutListWidget({Key key, this.con, this.callback}) : super(key: key);
  CartController con;
  Function callback;
  @override
  _CheckoutListWidgetState createState() => _CheckoutListWidgetState();
}

class _CheckoutListWidgetState extends State<CheckoutListWidget> {
  bool ratingOne = false;
  int selectedRadio;
  CustomDividerView _buildDivider() => CustomDividerView(
        dividerHeight: 2.0,
        color: Colors.orange[700],
      );

  @override
  void initState() {
    widget.con.grandSummary();
    widget.con.getTimeSlot();
    if (currentCheckout.value.uploadImage == null) {
      currentCheckout.value.uploadImage = 'no';
    }

    super.initState();
    selectedRadio = 1;
  }

  setDeliveryType(int val) {
    setState(() {
      selectedRadio = val;
      currentCheckout.value.deliverType = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ValueListenableBuilder(
            valueListenable: cartRepo.currentCart,
            builder: (context, _setting, _) {
              return ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: currentCart.value.length,
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.only(top: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, int index) {
                  CartResponce _cartresponce =
                      currentCart.value.elementAt(index);
                  return ProductBox3Widget(
                      con: widget.con, productDetails: _cartresponce);
                },
                separatorBuilder: (context, index) {
                  return CustomDividerView(
                      dividerHeight: 1.0,
                      color: Theme.of(context).dividerColor);
                },
              );
            }),

        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Wrap(
            alignment: WrapAlignment.start,
            children: <Widget>[
              Container(
                  child: Row(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.only(top: 7, right: 10),
                  //   child: Icon(Icons.library_books, color: Colors.grey[500]),
                  // ),
                  // SizedBox(width: 10),
                  // Expanded(
                  //   child: Container(
                  //     child: TextField(
                  //         style: Theme.of(context).textTheme.subtitle2,
                  //         textAlign: TextAlign.left,
                  //         autocorrect: true,
                  //         keyboardType: TextInputType.text,
                  //         decoration: InputDecoration(
                  //           hintText: 'Notes to shop',
                  //           hintStyle: Theme.of(context).textTheme.subtitle2,
                  //           enabledBorder: UnderlineInputBorder(
                  //             borderSide: BorderSide(
                  //               color: Colors.transparent,
                  //               width: 1.0,
                  //             ),
                  //           ),
                  //           focusedBorder: UnderlineInputBorder(
                  //             borderSide: BorderSide(
                  //               color: Colors.transparent,
                  //               width: 1.0,
                  //             ),
                  //           ),
                  //         )),
                  //   ),
                  // )
                ],
              )),
            ],
          ),
        ),
        // CustomDividerView(),

        // currentCheckout.value.deliverType == 3
        //     ? CustomDividerView(dividerHeight: 2.0)
        //     : Container(),

        // currentCheckout.value.deliverType == 3
        //     ? Container(
        //         padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        //         child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Row(
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     InkWell(
        //                       onTap: () {
        //                         print('oasdjnfklasndf');
        //                         deliveryMode(context, catchVendor.value);
        //                       },
        //                       child: Text(S.of(context).change_mode,
        //                           style: Theme.of(context).textTheme.subtitle2),
        //                     ),
        //                   ]),
        //             ]))
        //     : Container(),
        // currentCheckout.value.deliverType == 1
        //     ? Container()
        //     : currentCheckout.value.deliverType == 2
        //         ? Container()
        //         : currentCheckout.value.deliverType == 3
        //             ? Container(
        //                 padding: EdgeInsets.only(left: 20, right: 20),
        //                 child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: [
        //                       Column(
        //                           mainAxisAlignment: MainAxisAlignment.start,
        //                           children: [
        //                             Container(
        //                                 width: 60,
        //                                 child: Image(
        //                                   image: AssetImage(
        //                                       'assets/img/onthway.gif'),
        //                                 )),
        //                             // Container(
        //                             //     // child:Text(S.of(context).delivery_mode)
        //                             //     child:Text(S.of(context).delivery_mode)
        //                             // ),
        //                           ]),
        //                       Expanded(
        //                           child: Container(
        //                               padding: EdgeInsets.only(
        //                                 left: 20,
        //                               ),
        //                               child: Text('In Negozio',
        //                                   style: Theme.of(context)
        //                                       .textTheme
        //                                       .subtitle2)))
        //                     ]))
        //             : Container(),

        // currentCheckout.value.deliverType == 3
        //     ? Container(
        //         // currentCheckout.value.deliverType==2?Container(
        //         padding: const EdgeInsets.all(20.0),
        //         child: Row(
        //           children: <Widget>[
        //             Icon(Icons.lock_clock, size: 20.0, color: Colors.grey[700]),
        //             SizedBox(width: 10),
        //             Text('Scegli I orario',
        //                 style: Theme.of(context).textTheme.subtitle2),
        //             Spacer(),
        //             InkWell(
        //               onTap: showSlot,
        //               child: currentCheckout.value.deliveryTimeSlot != null
        //                   ? Text(S.of(context).change,
        //                       style: Theme.of(context).textTheme.caption.merge(
        //                           TextStyle(
        //                               color: Theme.of(context)
        //                                   .colorScheme
        //                                   .secondary,
        //                               fontWeight: FontWeight.w600)))
        //                   : Text(S.of(context).add,
        //                       style: Theme.of(context).textTheme.caption.merge(
        //                           TextStyle(
        //                               color: Theme.of(context)
        //                                   .colorScheme
        //                                   .secondary,
        //                               fontWeight: FontWeight.w600))),
        //             )
        //           ],
        //         ),
        //       )
        //     : Container(),
        // currentCheckout.value.deliverType==2? Padding(
        // currentCheckout.value.deliverType == 3
        //     ? Padding(
        //         padding:
        //             EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 20),
        //         child: currentCheckout.value.deliveryTimeSlot != null
        //             ? Text(
        //                 'Orario e data scelti per la prenotazione ${currentCheckout.value.deliveryTimeSlot}',
        //                 style: Theme.of(context).textTheme.subtitle2,
        //               )
        //             : Text(
        //                 S.of(context).please_select_your_delivery_slot,
        //                 style: Theme.of(context)
        //                     .textTheme
        //                     .subtitle2
        //                     .merge(TextStyle(color: Colors.red)),
        //               ))
        //     : Container(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: CustomDividerView(dividerHeight: 2.0),
        ),
        // currentCheckout.value.deliverType == 3
        //     ? Container()
        //     : Container(
        //         padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        //         child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Row(
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     InkWell(
        //                       onTap: () {
        //                         deliveryMode(context, catchVendor.value);
        //                         print(catchVendor.value.toMap());
        //                       },
        //                       child: Text(S.of(context).change_mode,
        //                           style: Theme.of(context).textTheme.subtitle2),
        //                     ),
        //                   ]),
        //             ])),
        // currentCheckout.value.deliverType == 1
        //     ? Container(
        //         padding: EdgeInsets.only(left: 20, right: 20),
        //         child: Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Column(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children: [
        //                     Container(
        //                         width: 60,
        //                         child: Image(
        //                           image: AssetImage('assets/img/onthway.gif'),
        //                         )),
        //                     Container(
        //                         child: Text(S.of(context).instant_delivery)),
        //                   ]),
        //               Expanded(
        //                   child: Container(
        //                       padding: EdgeInsets.only(
        //                         left: 20,
        //                       ),
        //                       child: Text(S.of(context).instant_delivery,
        //                           style:
        //                               Theme.of(context).textTheme.subtitle2)))
        //             ]))
        //     : currentCheckout.value.deliverType == 2
        //         ? Container(
        //             // 2==2?Container(
        //             padding: EdgeInsets.only(left: 20, right: 20),
        //             child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: [
        //                   Column(
        //                       mainAxisAlignment: MainAxisAlignment.start,
        //                       children: [
        //                         Container(
        //                             width: 60,
        //                             child: Image(
        //                               image:
        //                                   AssetImage('assets/img/onthway.gif'),
        //                             )),
        //                         Container(child: Text(S.of(context).takeaway)),
        //                       ]),
        //                   Expanded(
        //                       child: Container(
        //                           padding: EdgeInsets.only(
        //                             left: 20,
        //                           ),
        //                           child: Text('Scheduled Delivery',
        //                               style: Theme.of(context)
        //                                   .textTheme
        //                                   .subtitle2)))
        //                 ]))
        //         : currentCheckout.value.deliverType == 3
        //             ? /*Container(
        //         padding: EdgeInsets.only(left:20, right: 20),
        //         child:Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children:[
        //               Column(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   children:[
        //                     Container(
        //                         width:60,
        //                         child:Image(
        //                           image:AssetImage('assets/img/onthway.gif'),
        //                         )
        //                     ),
        //                     Container(
        //                         child:Text(S.of(context).delivery_mode)
        //                     ),
        //                   ]
        //               ),

        //               Expanded(
        //                   child:Container(
        //                       padding: EdgeInsets.only(left:20,),
        //                       child:Text('Takeaway',
        //                           style:Theme.of(context).textTheme.subtitle2
        //                       )
        //                   )
        //               )
        //             ]
        //         )
        //     )*/
        //             Container()
        //             : Container(),
        // currentCheckout.value.deliverType == 3
        //     ? Container()
        //     : Container(
        //         // currentCheckout.value.deliverType==2?Container(
        //         padding: const EdgeInsets.all(20.0),
        //         child: Row(
        //           children: <Widget>[
        //             Icon(Icons.lock_clock, size: 20.0, color: Colors.grey[700]),
        //             SizedBox(width: 10),
        //             Text(S.of(context).delivery_time_slot,
        //                 style: Theme.of(context).textTheme.subtitle2),
        //             Spacer(),
        //             InkWell(
        //               onTap: showSlot,
        //               child: currentCheckout.value.deliveryTimeSlot != null
        //                   ? Text(S.of(context).change,
        //                       style: Theme.of(context).textTheme.caption.merge(
        //                           TextStyle(
        //                               color: Theme.of(context)
        //                                   .colorScheme
        //                                   .secondary,
        //                               fontWeight: FontWeight.w600)))
        //                   : Text(S.of(context).add,
        //                       style: Theme.of(context).textTheme.caption.merge(
        //                           TextStyle(
        //                               color: Theme.of(context)
        //                                   .colorScheme
        //                                   .secondary,
        //                               fontWeight: FontWeight.w600))),
        //             )
        //           ],
        //         ),
        //       ),
        // // currentCheckout.value.deliverType==2? Padding(
        // currentCheckout.value.deliverType == 3
        //     ? Container()
        //     : Padding(
        //         padding:
        //             EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 20),
        //         child: currentCheckout.value.deliveryTimeSlot != null
        //             ? Text(
        //                 '${S.of(context).your_order_delivery_time_slot_is} ${currentCheckout.value.deliveryTimeSlot}',
        //                 style: Theme.of(context).textTheme.subtitle2,
        //               )
        //             : Text(
        //                 S.of(context).please_select_your_delivery_slot,
        //                 style: Theme.of(context)
        //                     .textTheme
        //                     .subtitle2
        //                     .merge(TextStyle(color: Colors.red)),
        //               )),

        Center(
          child: Text(
            "COSA PREFERISCI FARE?",
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),

        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              catchVendor.value.schedule != null && catchVendor.value.schedule
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 35,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: currentCheckout.value.deliverType == 0
                              ? Colors.orange
                              : Colors.white,
                          border: Border.all(
                            width: 3,
                            color: Colors.orange,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              currentCheckout.value.deliverType = 0;
                            });
                          },
                          child: Text(
                            'RILASSATI A CASA',
                            style: TextStyle(
                              fontSize: 10,
                              color: currentCheckout.value.deliverType == 0
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              catchVendor.value.takeaway != null && catchVendor.value.takeaway
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 35,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: currentCheckout.value.deliverType == 3
                              ? Colors.orange
                              : Colors.white,
                          border: Border.all(
                            width: 3,
                            color: Colors.orange,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              currentCheckout.value.deliverType = 3;
                            });
                          },
                          child: Text(
                            'RITIRARLO AL LOCALE',
                            style: TextStyle(
                              fontSize: 10,
                              color: currentCheckout.value.deliverType == 3
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              catchVendor.value.instant != null && catchVendor.value.instant
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: currentCheckout.value.deliverType == 2
                              ? Colors.orange
                              : Colors.white,
                          border: Border.all(
                            width: 3,
                            color: Colors.orange,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              currentCheckout.value.deliverType = 2;
                            });
                          },
                          child: Text(
                            'PRENOTA',
                            style: TextStyle(
                              fontSize: 10,
                              color: currentCheckout.value.deliverType == 2
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),

        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8.0),
            child: Container(
              height: 35,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.orange[700],
              ),
              child: TextButton(
                onPressed: () {
                  showSlot();
                },
                child: Text(
                  'SELEZIONA DATA E ORA',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Container(
        //   margin: const EdgeInsets.only(right: 10.0, left: 10, top: 20),
        //   padding: EdgeInsets.all(10),
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     color: Colors.orange[50],
        //     border: Border.all(color: Colors.brown[200], width: 1.0),
        //     borderRadius: BorderRadius.circular(10.0),
        //   ),
        //   child: Row(
        //     children: <Widget>[
        //       /*ClipOval(
        //               child: Image.asset(
        //                 'assets/images/food3.jpg',
        //                 height: 90.0,
        //                 width: 90.0,
        //               ),
        //             ),*/
        //       Flexible(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget>[
        //             Wrap(
        //               children: [
        //                 Theme(
        //                   data: ThemeData(
        //                       unselectedWidgetColor: Colors.deepOrange),
        //                   child: Checkbox(
        //                     checkColor:
        //                         Theme.of(context).scaffoldBackgroundColor,
        //                     activeColor: Colors.deepOrange,
        //                     value: this.ratingOne,
        //                     onChanged: (bool value) {
        //                       setState(() {
        //                         this.ratingOne = value;
        //                       });
        //                     },
        //                   ),
        //                 ),
        //                 SizedBox(width: 2),
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 9),
        //                   child: Text(
        //                     S.of(context).opt_in_for_no_contact_delivery,
        //                     style: Theme.of(context).textTheme.headline1.merge(
        //                         TextStyle(
        //                             color: Colors.deepOrange,
        //                             fontWeight: FontWeight.w700)),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: <Widget>[
        //                   Text(
        //                     S
        //                         .of(context)
        //                         .our_delivery_partner_will_after_reaching_and_leave_the_order_at_your_door_gate_not_applicable_for_cod,
        //                     style: Theme.of(context).textTheme.bodyText1.merge(
        //                         TextStyle(
        //                             color: Colors.brown,
        //                             fontWeight: FontWeight.w300)),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             SizedBox(height: 10),
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 10),
        //     ],
        //   ),
        // ),
        setting.value.deliveryTips
            ? Container(
                margin: const EdgeInsets.only(right: 10.0, left: 10, top: 10),
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(child: Icon(Icons.monetization_on)),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    S.of(context).tip_your_delivery_partner,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                Text(S.of(context).how_it_works,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .merge(TextStyle(color: Colors.blue)))
                              ]),
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 6),
                                Text(
                                  S
                                      .of(context)
                                      .thank_your_delivery_partner_for_helping_you_stay_safe_indoors_support_them_through_these_toug_times_wit_a_trip,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                SizedBox(height: 20),
                                Wrap(
                                    spacing: 10,
                                    children: List.generate(
                                        currentTips.value.length, (index) {
                                      Tips _tipsData =
                                          currentTips.value.elementAt(index);

                                      return GestureDetector(
                                          onTap: () => {
                                                currentTips.value.forEach((_l) {
                                                  setState(() {
                                                    _l.selected = false;
                                                  });
                                                }),
                                                _tipsData.selected = true,
                                                currentCheckout
                                                        .value.delivery_tips =
                                                    _tipsData.amount.toDouble(),
                                                widget.con.grandSummary(),
                                                widget.callback(true),
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 2500),
                                                    () {
                                                  widget.callback(false);
                                                }),
                                              },
                                          child: Container(
                                              width: 65,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                color: _tipsData.selected
                                                    ? Colors.deepPurpleAccent
                                                    : Theme.of(context)
                                                        .primaryColor,
                                              ),
                                              child: Center(
                                                  child: Text(Helper.pricePrint(
                                                      _tipsData.amount)))));
                                    }))
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
        //SizedBox(height: 20),
        //    CustomDividerView(dividerHeight: 15.0),
        ValueListenableBuilder(
            valueListenable: cartRepo.currentCart,
            builder: (context, _setting, _) {
              //widget.con.grandSummary();
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('DETTAGLI PAGAMENTO',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(S.of(context).item_total.toUpperCase(),
                            style: Theme.of(context).textTheme.subtitle2),
                        Text(
                          Helper.pricePrint(currentCheckout.value.sub_total),
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    S.of(context).delivery_fee.toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  currentCheckout.value.delivery_fees != 0
                                      ? Text(
                                          '${Helper.pricePrint(currentCheckout.value.delivery_fees)}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          S.of(context).free,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(S.of(context).tax.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  Text(
                                    '${Helper.pricePrint(currentCheckout.value.tax)}',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              //Row(
                              //mainAxisAlignment:
                              //MainAxisAlignment.spaceBetween,
                              //children: <Widget>[
                              //Text(S.of(context).discount,
                              //style: TextStyle(color: Colors.green)),
                              //Text(
                              //'${Helper.pricePrint(currentCheckout.value.discount)}',
                              //style: Theme.of(context)
                              //.textTheme
                              //.subtitle2
                              //.merge(
                              //TextStyle(color: Colors.green))),
                              //],
                              //),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    _buildDivider(),
                    Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'TOTALE DOVUTO',
                            //  S.of(context).to_pay,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Spacer(),
                          Text(
                            '${Helper.pricePrint(currentCheckout.value.grand_total)}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
        // CustomDividerView(dividerHeight: 15.0),
        // SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 7, right: 10),
                    child: Image.asset(
                      'assets/img/rivedi_il_tuo_ordine.png',
                      width: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                        child: Text(
                            S
                                .of(context)
                                .review_your_order_and_address_details_to_avoid_cancellation,
                            style: Theme.of(context).textTheme.caption)),
                  )
                ],
              )),
              SizedBox(height: 17),
              Container(
                  child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 7, right: 10),
                      child: Image.asset(
                        'assets/img/cancella_il_tuo_ordine.png',
                        width: 40,
                      )
                      //Icon(Icons.timer, color: Colors.deepOrangeAccent[200]),
                      ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                        child: Text(
                            S
                                .of(context)
                                .if_you_choose_to_cancel_you_can_do_it_with_60_seconds_after_placing_the_order,
                            style: Theme.of(context).textTheme.caption)),
                  )
                ],
              )),
              SizedBox(height: 17),
              Container(
                  child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 7, right: 10),
                    child: Image.asset(
                      'assets/img/passati_i_60_secondi.png',
                      width: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                        child: Text(
                            S
                                .of(context)
                                .post_60_seconds_you_will_be_charged_a_100_cancellation_fess_,
                            style: Theme.of(context).textTheme.caption)),
                  )
                ],
              )),
              // SizedBox(height: 10),
              // Container(
              //     child: Row(
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.only(top: 7, right: 10),
              //       child: Icon(Icons.pan_tool,
              //           color: Colors.deepOrangeAccent[200]),
              //     ),
              //     SizedBox(width: 10),
              //     Expanded(
              //       child: Container(
              //           padding: EdgeInsets.only(top: 7),
              //           child: Text(
              //               S
              //                   .of(context)
              //                   .however_in_the_event_of_an_unusual_delay_of_your_order_you_will_not_be_charged_a_cancellation_fees,
              //               style: Theme.of(context).textTheme.caption)),
              //     )
              //   ],
              // )),
              // SizedBox(height: 10),
              // Container(
              //     child: Row(
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.only(top: 7, right: 10),
              //       child: Icon(Icons.thumb_up,
              //           color: Colors.deepOrangeAccent[200]),
              //     ),
              //     SizedBox(width: 10),
              //     Expanded(
              //       child: Container(
              //           padding: EdgeInsets.only(top: 7),
              //           child: Text(
              //               S
              //                   .of(context)
              //                   .this_policy_helps_us_avoid_food_wastage_and_compensate_restaurant_delivey_partners_for_their_reports,
              //               style: Theme.of(context).textTheme.caption)),
              //     )
              //   ],
              // )),
              SizedBox(height: 20),
              Container(
                  child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 7, right: 10),
                    child: Icon(Icons.thumb_up, color: Colors.transparent),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      child: Text(S.of(context).read_policy,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .merge(TextStyle(color: Colors.blue))),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
        // SizedBox(height: 20),
        // CustomDividerView(dividerHeight: 18.0),

        Container(
          padding: EdgeInsets.only(
              top: 20.0,
              left: MediaQuery.of(context).size.width * 0.2 - 50,
              right: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Image.asset(
                        'assets/img/ic_map.png',
                        width: 50,
                      ),
                      Text(S.of(context).delivery_location,
                          style: Theme.of(context).textTheme.subtitle2),
                    ],
                  ),
                ],
              ),
              Spacer(),
              //SizedBox(height: 5),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.2, right: 18, top: 5),
          child: currentUser.value.selected_address != null
              ? Text(
                  currentUser.value.selected_address,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .merge(TextStyle(fontWeight: FontWeight.w600)),
                )
              : Text(
                  S.of(context).please_add_your_location,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .merge(TextStyle(fontWeight: FontWeight.w600)),
                ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.2, right: 18, top: 5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.orange, borderRadius: BorderRadius.circular(5)),
            child: InkWell(
              onTap: () {
                showModal();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: currentUser.value.selected_address != null
                    ? Text(S.of(context).change_address,
                        style: Theme.of(context).textTheme.caption.merge(
                            TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)))
                    : Text(S.of(context).add_address,
                        style: Theme.of(context).textTheme.caption.merge(
                            TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600))),
              ),
            ),
          ),
        ),
        SizedBox(height: 100)
      ])),
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
                              widget.con.calculateDistance(
                                  currentUser.value.latitude,
                                  currentUser.value.longitude,
                                  currentCheckout.value.shopLatitude,
                                  currentCheckout.value.shopLongitude);
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

  void showSlot() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
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
                        child: widget.con.timeSlot.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    TimeSlotWidget(choice: widget.con.timeSlot)
                                  ])
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ]),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: widget.con.timeSlot.isNotEmpty
                        ? Padding(
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
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void deliveryMode(context, shopDetails) {
    Future<void> future = showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              color: Color(0xff737373),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border(
                                bottom: BorderSide(
                              color: Colors.grey[200],
                              width: 1,
                            ))),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                S.of(context).pick_your_preference,
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.left,
                              ),
                            )),
                      ),
                      Expanded(
                          child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DeliveryMode(
                                shopDetails: shopDetails,
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      )),
                    ],
                  )),
            ),
          );
        });

    future.then((void value) => {setState(() => currentUser.value)});
  }
}
