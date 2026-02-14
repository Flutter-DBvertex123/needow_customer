import 'package:get/get.dart';
import 'package:newdow_customer/features/product/models/model/ProductModel.dart';
import 'package:newdow_customer/utils/constants.dart';

import '../model/categoryAndSubcategoryServices/categoryAndSubcategoryService.dart';
import '../model/models/categoryAndSubCategoryModel.dart';

class CategoryAndSubcategoryController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<SubCategoryModel> subcategories = <SubCategoryModel>[].obs;




  Future<List<CategoryModel>> getCategories(String businessType) async {
    final data = await Get.find<CategoryAndSubcategoryService>().getCategories(businessType);
    if(data["success"]){
      categories.value = data["data"];
    }
    //errorMessage.value.toString();
    //await categoryAndSubcaregoryCon.getSubCategory(categoryAndSubcaregoryCon.categories[0].id);
    await getSubCategory(categories[0].id);

    return data['data'];
  }

  Future<void> getSubCategory(String categoryId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final data = await Get.find<CategoryAndSubcategoryService>().getSubCategories(categoryId); // your existing API call
      if(data["success"]){
        print("in controller ${data["data"]}");
        subcategories.value = data["data"];

        return data['data'];
      }else{
        errorMessage.value = data['message'];
      }
       // result should be a List
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

}