import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';






class SnacksBiscuits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
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
                                child:Text('6 pcs of Chicken Wings with Skin')
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

                                                        style: Theme.of(context).textTheme.subtitle2
                                                    )
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(top:20,right:10,),
                                                    child:Text('\$149',

                                                        style: Theme.of(context).textTheme.subtitle2.merge(TextStyle( decoration: TextDecoration.lineThrough,))
                                                    )
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(top:20,),
                                                    child:Text('15% OFF',

                                                        style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color:Theme.of(context).colorScheme.secondary))
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

                                                      Text(S.of(context).add_to_cart,
                                                          style: Theme.of(context).textTheme.subtitle2.
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
    icon: 'assets/img/goodday.png',
    title: 'Britania Good Day Cashew 600g',
    subtitle: '₹80 for non members',
    price: '₹96 ',
    marginprice: '₹120',
    quantity:'1 kg',
    offer:'5% OFF',
  ),
  const CategoryListItemView(
    icon: 'assets/img/marygold.png',
    title:'Britania Mary Gold',
    subtitle: '₹60 for non members',
    price: '₹54  ',
    marginprice: '₹60',
    quantity:'250 g',
    offer:'5% OFF',
  ),
  const CategoryListItemView(
    icon: 'assets/img/marygold22.png',
    title: 'Britania Mary Gold 300g',
    subtitle: '₹30 for non members',
    price: '₹54 ',
    marginprice: '₹60',
    quantity:'300 g',
    offer:'3% OFF',
  ),
  const CategoryListItemView(
    icon: 'assets/img/darkday.png',
    title: 'Dark Day',
    subtitle: '₹40 for non members',
    price: '₹52  ',
    marginprice: '₹60',
    quantity:'300 g',
    offer:'5% OFF',
  ),
  const CategoryListItemView(
    icon: 'assets/img/oreo.png',
    title: 'Cadburry Oreo Choco Creme 1Kg',
    subtitle: '₹50 for non members',
    price: '₹60  ',
    marginprice: '₹80',
    quantity:'300 g',
    offer:'3% OFF',
  ),


];
