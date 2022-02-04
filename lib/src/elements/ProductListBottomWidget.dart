import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import '../Widget/custom_divider_view.dart';

class ProductListBottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: choices.length,
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.only(top: 12),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, int index) {
        return CategoryList(choice: choices[index]);
      },
      separatorBuilder: (context, index) {
        return CustomDividerView(dividerHeight: 1.0, color: Theme.of(context).dividerColor);
      },
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({Key key, this.choice}) : super(key: key);
  final CategoryListItemView choice;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 0, right: 0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    choice.icon,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                            padding: EdgeInsets.only(
                          top: 0,
                        )),
                        Wrap(children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4, right: 5),
                            child: Icon(Icons.card_giftcard, size: 14, color: Colors.grey),
                          ),
                          SizedBox(width: 3),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: choice.price, style: Theme.of(context).textTheme.headline6),
                                TextSpan(
                                    text: choice.marginprice,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            padding: EdgeInsets.all(3),
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.deepOrange[400],
                            ),
                            child: Wrap(alignment: WrapAlignment.center, children: [
                              Text(choice.offer,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                                        color: Theme.of(context).primaryColorLight,
                                      )))
                            ]),
                          ),
                        ]),
                        Text(choice.subtitle, style: Theme.of(context).textTheme.caption),
                        Text(choice.title, style: TextStyle(color: Theme.of(context).backgroundColor.withOpacity(0.5))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(choice.quantity, style: Theme.of(context).textTheme.caption),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    height: 31,
                                    width: MediaQuery.of(context).size.width * 0.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          S.of(context).add,
                                          style: TextStyle(color: Colors.transparent),
                                        ),
                                        Text(S.of(context).add,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                .merge(TextStyle(color: Theme.of(context).primaryColorLight, fontWeight: FontWeight.w600))),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
                                            color: Colors.green,
                                          ),
                                          height: double.infinity,
                                          width: 30,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.add),
                                            iconSize: 18,
                                            color: Theme.of(context).primaryColorLight,
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryListItemView {
  const CategoryListItemView({this.icon, this.price, this.marginprice, this.title, this.subtitle, this.offer, this.quantity});

  final String icon;
  final String title;
  final String subtitle;

  final String price;
  final String marginprice;
  final String quantity;
  final String offer;
}

const List<CategoryListItemView> choices = const <CategoryListItemView>[
  const CategoryListItemView(
    icon: 'assets/img/vegetablefruit.png',
    title: 'Tomato 1 Kg',
    subtitle: '₹80 for non members',
    price: '₹79  ',
    marginprice: '₹90',
    quantity: '1 kg',
    offer: '3% OFF',
  ),
  const CategoryListItemView(
    icon: 'assets/img/apple11.png',
    title: 'Royal Gala Apple',
    subtitle: '₹60 for non members',
    price: '₹185  ',
    marginprice: '₹195',
    quantity: '1 kg',
    offer: '5% OFF',
  ),
  const CategoryListItemView(
    icon: 'assets/img/gabbage.png',
    title: 'Red Cabbage',
    subtitle: '₹25 for non members',
    price: '₹38 ',
    marginprice: '₹50',
    quantity: '300 g',
    offer: '3% OFF',
  ),
  const CategoryListItemView(
    icon: 'assets/img/onion.png',
    title: 'Fresh Onion 1Kg',
    subtitle: '₹40 for non members',
    price: '₹52  ',
    marginprice: '₹60',
    quantity: '1 kg',
    offer: '5% OFF',
  ),
  const CategoryListItemView(
    icon: 'assets/img/banana11.png',
    title: 'Banana 1Kg',
    subtitle: '₹70 for non members',
    price: '₹26  ',
    marginprice: '₹45',
    quantity: '1 kg',
    offer: '3% OFF',
  ),
];
