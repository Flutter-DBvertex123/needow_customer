import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/profile/controller/privacyPolicyController.dart';
import 'package:newdow_customer/features/profile/model/privacyPolicyModel.dart';
import 'package:newdow_customer/widgets/appbar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
   PrivacyPolicyScreen({super.key});
final privacyCon = Get.find<Privacypolicycontroller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
            slivers: [
              DefaultAppBar(titleText: "Privacy Policy", isFormBottamNav: false),
              SliverToBoxAdapter(
                child: FutureBuilder<Privacypolicymodel>(
                  future: privacyCon.getPrivacyPolicy(),
                  builder: (context, asyncSnapshot) {
                    print("data of privacy ${asyncSnapshot.data}");
                    if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (asyncSnapshot.hasError) {
                      return Center(child: Text("Error: ${asyncSnapshot.error}"));
                    }
                    if (!asyncSnapshot.hasData) {
                      return Center(child: Text("Privacy Policy is not available"));
                    }
                    final data  = asyncSnapshot.data;
                    print("privacy and policy $data");
                    return Html(
                      data: data!.content,
                      style: {
                        "h2": Style(color: Colors.blue, fontSize: FontSize.xLarge),
                        "h3": Style(color: Colors.black87, fontWeight: FontWeight.w600),
                        "p": Style(fontSize: FontSize.medium, lineHeight: LineHeight(1.6)),
                      },
                    );
                  }
                ),
              )
            ],
          )),
    );
  }
}
