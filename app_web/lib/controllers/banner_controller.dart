import 'dart:convert';

import 'package:app_web/gloab_variable.dart';
import 'package:app_web/models/banner.dart';
import 'package:app_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class BannerController {
  UploadBanner({required String pickedImage, required context}) async {
    try {
      final clouddinary = CloudinaryPublic("dnh7jblx5", "phinam");

      CloudinaryResponse imageRespones = await clouddinary.uploadFile(
        CloudinaryFile.fromFile(
          pickedImage,
          identifier: 'pickedImage',
          folder: 'banners',
        ),
      );

      String image = imageRespones.secureUrl;

      BannerModel bannerModel = BannerModel(id: '', image: image);

      http.Response response = await http.post(
        Uri.parse("$uri/api/banner"),
        body: bannerModel.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json: charset=UTF-8",
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Banner Uploaded");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  //fetch banner
  Future<List<BannerModel>> loadBanners() async {
    try {
      //send an http request to fetch banners
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          "Content-Type": "application/json: charset=UTF-8",
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        //ok
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();

        return banners;
      } else {
        ///throw an expecption if the sever reponsed with an error status code
        throw Exception('Failed to load Banners');
      }
    } catch (e) {
      throw Exception('Error loading Banners $e');
    }
  }
}
