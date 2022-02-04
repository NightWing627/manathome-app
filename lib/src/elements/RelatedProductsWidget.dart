import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RelatedProductsWidget extends StatefulWidget {
  @override
  _RelatedProductsWidgetState createState() => _RelatedProductsWidgetState();
}

class _RelatedProductsWidgetState extends State<RelatedProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: choices.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: 10,
            right: 20,
          ),
          itemBuilder: (context, index) {
            return Padding(padding: EdgeInsets.only(left: 5), child: RelatedProductssSliderList(choice: choices[index]));
          }),
    );
  }
}

class RelatedProductssSliderList extends StatelessWidget {
  const RelatedProductssSliderList({Key key, this.choice}) : super(key: key);
  final RelatedProductssSliderListItem choice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Padding(
            padding: EdgeInsets.only(
              bottom: 5.0,
            ),
            child: InkWell(
                onTap: () {},
                child: Container(
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(
                        height: 150.0,
                        width: 150,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          image: DecorationImage(
                            image: AssetImage(choice.icon),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Icon(
                                  Icons.favorite,
                                  color: Theme.of(context).focusColor.withOpacity(1),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(choice.title, overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Wrap(alignment: WrapAlignment.spaceBetween, children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text(choice.price, style: Theme.of(context).textTheme.headline1),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            choice.marginprice,
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .merge(TextStyle(color: Theme.of(context).disabledColor, decoration: TextDecoration.lineThrough)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 8, top: 2),
                          child: Container(
                            child: Text(
                              choice.offer,
                              style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                  )),
                            ),
                          ),
                        ),
                      ]),
                    ])))),
      ),
    );
  }
}

class RelatedProductssSliderListItem {
  const RelatedProductssSliderListItem({this.title, this.icon, this.offer, this.price, this.marginprice});
  final String title;
  final String icon;
  final String offer;
  final String marginprice;

  final String price;
}

const List<RelatedProductssSliderListItem> choices = const <RelatedProductssSliderListItem>[
  const RelatedProductssSliderListItem(
    title: 'Aashirvaad Multigrains Atta,',
    icon: 'assets/img/ashirvad.png',
    price: '₹238',
    offer: '30% Off',
    marginprice: '₹250',
  ),
  const RelatedProductssSliderListItem(
    title: 'MTR Masala - Garam Masala, 100 g Pouch',
    icon: 'assets/img/garammasala.png',
    price: '₹90',
    offer: '20% Off',
    marginprice: '₹160',
  ),
  const RelatedProductssSliderListItem(
    title: 'Lion Dates',
    icon: 'assets/img/liondats.png',
    price: '₹238',
    offer: '30% Off',
    marginprice: '₹250',
  ),
  const RelatedProductssSliderListItem(
    title: 'Sunsilk Stunning Black Shine 1 l Shampoo',
    icon: 'assets/img/sunsilk.png',
    price: '₹150',
    offer: '10% Off',
    marginprice: '₹205',
  ),
  const RelatedProductssSliderListItem(
    title: 'Harpic & Lizol',
    icon: 'assets/img/harpic1.png',
    price: '₹238',
    offer: '30% Off',
    marginprice: '₹540',
  ),
];
