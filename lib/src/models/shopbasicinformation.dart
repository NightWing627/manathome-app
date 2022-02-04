
import 'holidays.dart';
import 'package:multisuperstore/src/helpers/custom_trace.dart';

class ShopBasicInformation{
  String id;
  String storeName;
  String subtitle;
  String companyLegalName;
  String ownerName;
  String proofId;
  String mobile;
  var logo;
  String pickupAddress;
  String pinCode;
  String city;
  String state;
  String landmark;
  String latitude;
  String longitude;
  var addressProofImage;
  String openingTime;
  String closingTime;
  HolidaysModel holidays = new HolidaysModel();

  ShopBasicInformation();

  ShopBasicInformation.fromJSON(Map<String,dynamic> jsonMap){
      try {
        id = jsonMap['id'];
        storeName = jsonMap['storeName'] != null ? jsonMap['storeName'] : '';
        subtitle = jsonMap['subtitle'] != null ? jsonMap['subtitle'] : '';
        companyLegalName = jsonMap['companyLegalName'] != null ? jsonMap['companyLegalName'] : '';
        ownerName  = jsonMap['ownerName'] != null ? jsonMap['ownerName'] : '';
        proofId  = jsonMap['proofId'] != null ? jsonMap['proofId'] : '';
        logo  = jsonMap['logo'];
        mobile  = jsonMap['mobile'] != null ? jsonMap['mobile'] : '';
        pickupAddress=jsonMap['pickupAddress'] != null ? jsonMap['pickupAddress'] : '';
        pinCode=jsonMap['pinCode'] != null ? jsonMap['pinCode'] : '';
        landmark=jsonMap['landmark'] != null ? jsonMap['landmark'] : '';
        latitude=jsonMap['latitude'] != null ? jsonMap['latitude'] : '';
        longitude=jsonMap['longitude'] != null ? jsonMap['longitude'] : '';
        addressProofImage=jsonMap['addressProofImage'];
        openingTime=jsonMap['openingTime'] != null ? jsonMap['openingTime'] : '';
        openingTime=jsonMap['closingTime'] != null ? jsonMap['closingTime'] : '';
        holidays=jsonMap['holidays'] != null ? HolidaysModel.fromJSON(
            jsonMap['holidays']) : HolidaysModel.fromJSON({});
      } catch (e) {
        id = '';
        storeName = '';
        subtitle = '';
        companyLegalName = '';
        ownerName = '';
        proofId= '';
        logo= '';
        mobile = '';
        openingTime='';
        openingTime='';
        holidays=HolidaysModel.fromJSON({});


        print(CustomTrace(StackTrace.current, message: e));
      }
    }

    Map toMap() {
      var map = new Map<String, dynamic>();
      map["id"] = id;
      map["storeName"] = storeName;
      map["ownerName"] = ownerName;
      map["subtitle"] = subtitle;
      map["companyLegalName"] = companyLegalName;
      map["proofId"] = proofId;
      map["logo"] = logo;
      map["mobile"] = mobile;
      map['pickupAddress']=pickupAddress;
      map['pinCode']=pinCode;
      map['landmark']=landmark;
      map['latitude']=latitude;
      map['longitude']=longitude;
      map['addressProofImage']=addressProofImage;
      map['openingTime']=openingTime;
      map['closingTime']=closingTime;
      map['holidays']=holidays.toMap();

      return map;
    }


  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }




  }