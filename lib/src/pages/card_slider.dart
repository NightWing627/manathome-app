import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CardSlider extends StatefulWidget {
  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: choices.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10, right: 10),
          itemBuilder: (context, index) {
            return CardsliderList(choice: choices[index]);
          }),
    );
  }
}

class CardsliderList extends StatelessWidget {
  const CardsliderList({Key key, this.choice}) : super(key: key);
  final CardSliderListItemView choice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Padding(
            padding: EdgeInsets.only(bottom: 5.0, left: 5.0),
            child: InkWell(
                onTap: () {},
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 1)],
                        color: Theme.of(context).primaryColor),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                        child: Container(
                          height: 100.0,
                          width: 100.0,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(choice.icon),
                            maxRadius: 30,
                          ),
                          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.15),
                              blurRadius: 8.0,
                            )
                          ]),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBar.builder(
                                initialRating: 2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 3,
                                itemSize: 16,
                                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              SizedBox(width: 5.0),
                              Text(choice.review,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.bodyText2),
                            ],
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: Text(choice.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.headline1),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                            child: Text(choice.subtitle,
                                overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.left, style: Theme.of(context).textTheme.caption),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                          // ignore: deprecated_member_use
                          FlatButton(
                            onPressed: () {
                              /*Navigator.of(context).pushNamed('/Login');*/
                            },
                            padding: EdgeInsets.symmetric(vertical: 5),
                            color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                            shape: StadiumBorder(),
                            child: Text(
                              choice.price,
                              style: Theme.of(context).textTheme.headline1.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                            ),
                          ),
                        ]),
                      ),
                    ])))),
      ),
    );
  }
}

class CardSliderListItemView {
  const CardSliderListItemView({this.title, this.icon, this.subtitle, this.review, this.price});
  final String title;
  final String icon;
  final String subtitle;
  final String review;
  final String price;
}

const List<CardSliderListItemView> choices = const <CardSliderListItemView>[
  const CardSliderListItemView(
    title: 'Cheese Guide ',
    icon: 'assets/img/plate-food1.jpg',
    subtitle: 'special menu from foodie apps for you this is recommended',
    review: '(120 Reviews)',
    price: '\$ 100',
  ),
  const CardSliderListItemView(
    title: 'TARA\'S CLOUD KITCHEN ',
    icon: 'assets/img/cloud_chicken.jpg',
    subtitle: 'Chinese, Italian, Saradha college road, Saradha college road',
    review: '(110 Reviews)',
    price: '\$ 200',
  ),
  const CardSliderListItemView(
    title: 'MANICKAM MESS ',
    icon: 'assets/img/manik_mess.jpg',
    subtitle: 'South Indian, Chinese, Biryani, Saradha college road, Saradha college road',
    review: '(100 Reviews)',
    price: '\$ 200',
  ),
  const CardSliderListItemView(
    title: 'Cheese Guide ',
    icon: 'assets/img/dellhidarbar.jpg',
    subtitle: 'Arabian, Tandoor, Chinese, Junction Main Road, Saradha college road',
    review: '(105 Reviews)',
    price: '\$ 170',
  ),
  const CardSliderListItemView(
    title: 'Salem RR Briyani',
    icon: 'assets/img/Salem RR Briyani.jpg',
    subtitle: 'North Indian, South Indian, Biryani, VIVEKANANDAR NAGAR TRICHY MAINROAD, Seelanaickenpatti',
    review: '(190 Reviews)',
    price: '\$ 200',
  ),
];
