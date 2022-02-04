import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';






class FruitsVegetables extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 8,right: 2),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CategoryList(choice: choices[index]);
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

      padding: EdgeInsets.only(
          left: 8, right: 8,),
      child: Material(
        color: Colors.transparent,


                    child:InkWell(
                          onTap: () {


                          },
                          child:  Container(
                            padding:EdgeInsets.only(bottom:10),
                            decoration: BoxDecoration(
                                color:Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.1),
                                    blurRadius: 3.0,
                                    spreadRadius: 1.5,
                                  ),
                                ]),
                            margin: EdgeInsets.only(left:5,right:5, top: 10.0,bottom:10),
                            child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        //borderRadius: BorderRadius.all(Radius.circular(10)),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft:Radius.circular(0),
                                            bottomRight:Radius.circular(0),
                                          ),
                                          child:Image(image:AssetImage('assets/img/loginbg.jpg'),
                                              width:double.infinity,
                                              height:180,
                                              fit:BoxFit.fill
                                          )
                                      ),

                                    ],
                                  ),

                                  Container(
                                      padding: EdgeInsets.only(bottom:10),
                                      child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children:[
                                              Expanded(
                                                child: Container(
                                                  padding:EdgeInsets.only(left:10,right:10,top:15),
                                                  child:Text('Chicken Wings With Skin',
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style:Theme.of(context).textTheme.subtitle1),
                                                ),
                                              ),


                                            ]
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(left:10,right:10,top:7),
                                          child:Text('6 pcs of Chicken Wings with Skin',
                                           style:Theme.of(context).textTheme.subtitle2
                                          )
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left:10,right:10,),
                                            child:Text('Pieces 6 | Net wl, 430gms',
                                                style:Theme.of(context).textTheme.caption
                                            )
                                        ),
                                        Container(
                                          child:Row(
                                            children:[
                                              Expanded(
                                                child:Row(
                                                  children:[
                                                    Container(
                                                        padding: EdgeInsets.only(top:20,left:10,),
                                                        child:Text('\$127',
                                                          style: Theme.of(context).textTheme.headline1,
                                                        )
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets.only(top:20,left:10,),
                                                        child:Text('MRP:',

                                                            style: Theme.of(context).textTheme.bodyText2
                                                        )
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets.only(top:20,right:10,),
                                                        child:Text('\$149',

                                                          style: Theme.of(context).textTheme.bodyText2.merge(TextStyle( decoration: TextDecoration.lineThrough,))
                                                        )
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets.only(top:20,),
                                                        child:Text('15% OFF',

                                                            style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Theme.of(context).colorScheme.secondary))
                                                        )
                                                    ),

                                                  ]
                                                )
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: InkWell(
                                                  onTap: (){

                                                  },
                                                  child:Padding(
                                                    padding: EdgeInsets.only(left: 10, right: 10,top:5),
                                                    child:Container(
                                                        alignment: Alignment.centerRight,
                                                        padding: EdgeInsets.only(left: 10,right:10,),
                                                        height:31,

                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                          color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                        ),

                                                        child:Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [

                                                            Text('ADD TO CART',
                                                                style: Theme.of(context).textTheme.bodyText2.
                                                                merge(TextStyle(color:Theme.of(context).primaryColorLight,fontWeight: FontWeight.w600))
                                                            ),






                                                          ],
                                                        )
                                                    ),
                                                  ),
                                                )
                                              )

                                            ]
                                          )
                                        )


                                      ]
                                  )),
                                ]
                            ),
                          ),




        ),
      ),
    );
  }
}

class CategoryListItemView {
  const CategoryListItemView({this.icon, this.price, this.marginprice, this.title, this.subtitle, this.offer,this.quantity});

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
    title: 'Lays Blue indias magic masala chips (12x30 g) Garlic split nuts making Fresh Fruits zfsdffsdfssgdfddb dgdfghfgddhxvdg sddgd ',
    subtitle: '₹80 for non members',
    price: '₹796899  ',
    marginprice: '₹9069',
    quantity:'1 kg',
    offer:'3% OFF',
  ),
  const CategoryListItemView(
    icon: 'assets/img/apple11.png',
    title: 'Royal Gala Apple',
    subtitle: '₹60 for non members',
    price: '₹185  ',
    marginprice: '₹195',
    quantity:'1 kg',
    offer:'5% OFF',
  ),
  const CategoryListItemView(
    icon: 'assets/img/gabbage.png',
    title: 'Red Cabbage',
    subtitle: '₹25 for non members',
    price: '₹38 ',
    marginprice: '₹50',
    quantity:'300 g',
    offer:'3% OFF',
  ),
  const CategoryListItemView(
    icon: 'assets/img/onion.png',
    title: 'Fresh Onion 1Kg',
    subtitle: '₹40 for non members',
    price: '₹52  ',
    marginprice: '₹60',
    quantity:'1 kg',
    offer:'5% OFF',
  ),
  const CategoryListItemView(
    icon: 'assets/img/banana11.png',
    title: 'Banana 1Kg',
    subtitle: '₹70 for non members',
    price: '₹26  ',
    marginprice: '₹45',
    quantity:'1 kg',
    offer:'3% OFF',
  ),


];
