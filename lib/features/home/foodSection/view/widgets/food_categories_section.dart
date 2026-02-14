
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newdow_customer/features/browseProducts/view/browse_products_screen.dart';
import 'package:newdow_customer/features/home/controller/categoryAndSubcategoryController.dart';
import 'package:newdow_customer/features/home/foodSection/restaurent/controller/restaurentController.dart';
import 'package:newdow_customer/features/home/foodSection/view/screens/allRestaurentScreen.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

import '../../../model/models/categoryAndSubCategoryModel.dart';
import '../../restaurent/model/restaurentModel.dart';






class FoodCategorySection extends StatefulWidget {
  String businessTypeId;
  FoodCategorySection({Key? key, required this.businessTypeId}) : super(key: key);

  @override
  State<FoodCategorySection> createState() => _FoodCategorySectionState();
}

class _FoodCategorySectionState extends State<FoodCategorySection> {
  int selectedCategory = 0;
  final restaurantCtrl = Get.find<ResturentController>();
  @override
  void initState() {
    // TODO: implement initState
    loadCategories();
    super.initState();
  }
  void loadCategories() async {
    //await Get.find<CategoryAndSubcategoryController>().getCategories(widget.businessTypeId);
    await restaurantCtrl.fetchCuisineTypes();
  }
  @override
  Widget build(BuildContext context) {
    //final categories = DummyData.categories;
    List<Map<String,dynamic>> categories = [
      {
        'name': 'Sweet',
        'icon': food_categorie_icon,
      },
      {
        'name': 'Dessert',
        'icon': grocery_categorie_icon,
      },
      {
        'name': 'Breakfast',
        'icon': pharmacy_categorie_icon,
      }
      ];



    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            // child: FutureBuilder<List<CategoryModel>>(
            //   future: Get.find<CategoryAndSubcategoryController>().getCategories(widget.businessTypeId),
            //   builder: (context, asyncSnapshot) {
            //     if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            //       return Center(child: _buildShimmerLoader());
            //     } else if (asyncSnapshot.hasError) {
            //       return Center(child: Text('Error: ${asyncSnapshot.error}'));
            //     } else if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
            //       return Center(child: Text('No categories found'));
            //     }
                child:  Obx(() => ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    //itemCount: asyncSnapshot.data?.length ??0,
                    itemCount: restaurantCtrl.cuisineTypes.length ??0,
                    separatorBuilder: (context, index) => SizedBox(width: 25),
                    itemBuilder: (context, index) {
                     // return catagoryIcon(asyncSnapshot.data![index],index);
                      return catagoryIcon(restaurantCtrl.cuisineTypes[index],index);
                    },
                  ),
                ),
            //   }
            // ),
          ),
        ],
      ),
    );
  }

  Widget catagoryIcon(String category,int index) {
    String imageString = "";
    if(category == 'Indian'){
      imageString = indian_cusine_icon;
    }else if(category == 'Chinese'){
      imageString = chienes_cusine;
    }else if (category == 'Arabic'){
      imageString = arabic_cusine_icon;
    }
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              print("category id:${category}");
                // Get.to(BrowseProductsScreen(
                //  loadFor: LoadProductFor.fromCategory,
                //   params: category.id,
                // ));
              Get.to(() => AllRestaurantsScreen(cuisine: category,));
            },
            child: CircleAvatar(
                //backgroundColor: selectedCategory == index ? AppColors.primary : Color(0x4DD9D9D9),
              backgroundColor: Color(0x4DD9D9D9),
                radius: 30,
              /* backgroundImage : NetworkImage(category!.imageUrl?.first ?? "",
                 *//* colorFilter: ColorFilter.mode(
                    selectedCategory == index ? Colors.white : AppColors.primary,
                    BlendMode.srcIn,
                  ),*//*//)),*/
              backgroundImage: AssetImage(imageString),
          ),),
          SizedBox(height: 8),
          Text(
            category,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildShimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (context, index) => SizedBox(width: 25),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 30,
                ),
                SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}



