import 'dart:convert';

import 'package:newdow_customer/features/home/model/models/banner_model.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:http/http.dart' as http;
abstract class BannerService{
  Future<List<BannerModel>>getHomeBanner();
}
class BannerServiceImpl extends BannerService {
  @override
  Future<List<BannerModel>> getHomeBanner() async {
    try{
      Uri uri = Uri.parse("$baseUrl/banners");
      final response = await http.get(uri);
      if(response.statusCode == 200){
        final decondedResponse =  jsonDecode(response.body);
        print(decondedResponse);
        final bannerData = decondedResponse['data']['data'] as List;
        final banners = bannerData.map((e) => BannerModel.fromJson(e)).toList();
        print("Banner ${banners[0]}");
        return banners;
      }else{
        return [];
      }
    }catch(e){
      print("Error :- Get error while getting banner ${e.toString()}");
      return [];

    }
    throw UnimplementedError();
  }

}