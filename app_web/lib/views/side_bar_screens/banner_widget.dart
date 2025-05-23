import 'package:app_web/controllers/banner_controller.dart';
import 'package:app_web/models/banner.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  //A Future that will hold the list of banners once loaded from the APi
  late Future<List<BannerModel>> futureBanners;
  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureBanners,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Banners'));
        } else {
          final banner = snapshot.data!;
          return SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: banner.length,
              itemBuilder: (context, index) {
                final banner = snapshot.data![index];
                return Image.network(width: 40, height: 40, banner.image);
              },
            ),
          );
        }
      },
    );
  }
}
