

class Coupon{
  String title;
  String addedBy;
  String till;
  String code;
  String status;
  String image;
  String discountType;
  double discount;
  String terms;
  double minimumPurchasedAmount;
  String limit;
  String couponType;


  Coupon();
  Coupon.fromJSON(Map<String,dynamic> jsonMap){
    title=jsonMap['title'];
    addedBy=jsonMap['addedBy'];
    till=jsonMap['till'];
    code=jsonMap['code'];
    status=jsonMap['status'];
    image = jsonMap['image'];
    couponType=jsonMap['couponType'];
    limit=jsonMap['limit'];
    discountType=jsonMap['discountType'];
    discount=jsonMap['discount'].toDouble()!= null ? jsonMap['discount'].toDouble() :  0.0;
    terms=jsonMap['terms'];
    minimumPurchasedAmount= jsonMap['minimumPurchasedAmount'].toDouble()!= null ? jsonMap['minimumPurchasedAmount'].toDouble() :  0.0;
  }
Map toMap(){
    var map=Map<String,dynamic>();
    map['title']=title;
    map['addedBy']=addedBy;
    map['till']=till;
    map['code']=code;
    map['status']=status;
    map['discountType']=discountType;
    map['discount']=discount;
    map['terms']=terms;
    map['couponType']=couponType;
    map['limit']=limit;
    map['minimumPurchasedAmount']=minimumPurchasedAmount;
    return map;
}
}