import 'package:flutter/material.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class CutomerSupportScreen extends StatefulWidget {
   CutomerSupportScreen({super.key});

  @override
  State<CutomerSupportScreen> createState() => _CutomerSupportScreenState();
}

class _CutomerSupportScreenState extends State<CutomerSupportScreen> {
List<String> queries =
[
  "Can i track my order delivery status ?",
  "Is there a return policy?",
  "Can i save my favorite item for later ?",
  "Can i share orders with my friends ?",
  "How do i connect customer support ?",
  "What payment methods are approved ?",
  "How to add reviews ?"
];
final TextEditingController searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            DefaultAppBar(titleText: "Help And Support",isFormBottamNav: true,),
            SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                child: Column(
                  children: [
                    TextField(
                      controller: searchCon,
                      decoration: InputDecoration(
                        hintText: "How can we help you ?",
                        prefixIcon: Icon(Icons.search,color: AppColors.textSecondary,size: 30,),
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        fillColor: AppColors.secondary,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        ),
                      ),

                    Container(
                      height: 0.8.toHeightPercent(),
                      width: 1.toWidthPercent(),
                      child: ListView.separated(
                        itemCount: queries.length,
                          separatorBuilder: (context,index){
                            return SizedBox(height: 16,);
                          },
                          itemBuilder:(context,index){
                            return InkWell(
                              onTap: () async{
                                openWhatsApp("918078199781", queries[index]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: AppColors.secondary,
                                ),
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),


                                child: Text(queries[index],style: TextStyle(fontSize: 18),),
                              ),
                            );
                          } ),
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }


void openWhatsApp(String number, String message) async {
  final Uri url = Uri.parse("https://wa.me/$number?text=${Uri.encodeFull(message)}");

  await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  );
}

}
