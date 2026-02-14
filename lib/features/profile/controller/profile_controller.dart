/*
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:newdow_customer/features/auth/model/models/userModel.dart';
import 'package:newdow_customer/features/profile/model/services/profileService.dart';
import 'package:newdow_customer/widgets/snackBar.dart';
import '../../../utils/prefs.dart';
import '../../auth/view/login_screen.dart';
import '../model/userModel.dart';


class ProfileController extends GetxController {



  var savedData = Rx<UserModel?>(null);
  final formKey = GlobalKey<FormState>();

  // Text controllers
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController dobController;
   File? profileImage;


  final genderOptions = ['male', 'female',];
  // Reactive variables
  final RxString selectedGender = 'male'.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isFormValid = false.obs;

  @override
  void onInit() async {
    super.onInit();
     initializeControllers();

  }

  Future<UserModel?> getUser(String userId) async {
   return await  Get.find<ProfileService>().getUserDetails(userId);
  }
  void initializeControllers()  async {
    final user = await AuthStorage.getUserFromPrefs();;
    nameController = TextEditingController(text:  user?.name ?? "");
    emailController = TextEditingController(text: user?.email ?? "");
    if (user?.dob != null && user!.dob!.isNotEmpty) {
      // Convert ISO to dd-MM-yyyy
      DateTime dob = DateTime.parse(user!.dob!);
      dobController = TextEditingController(
        text: DateFormat("dd-MM-yyyy").format(dob),
      );
    } else {
      dobController = TextEditingController(text: "");
    }


    // Listen to text changes for form validation
    nameController.addListener(validateForm);
    emailController.addListener(validateForm);
    dobController.addListener(validateForm);
  }



  void validateForm() {
    isFormValid.value = nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        selectedGender.value.isNotEmpty;
  }
  String? validateName(String? value) {
    if (value == null ) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateDOB(String? value) {
    if (value == null) {
      return 'Please select your date of birth';
    }
    return null;
  }

  String? validateGender(String? value) {
    if (value == null) {
      return 'Please select your gender';
    }
    return null;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dobController.text.isNotEmpty
          ? DateTime.parse(dobController.text)
          : DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      validateForm();
    }
  }

  void setGender(String gender) {
    selectedGender.value = gender;
    validateForm();
  }

  Future<bool> updateProfile() async {
    errorMessage.value = '';
    print("incontroller");
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      print(emailController.text);
      try {
        print("${nameController.text}");
        print("${emailController.text}");
        print("${dobController.text}");
        print("${selectedGender}");
        print("${profileImage}");


        // Add your API call here
        // Example:
        String userId = await AuthStorage.getUserFromPrefs().then((user) => user?.id) ?? "";
         bool isUpdate  = await Get.find<ProfileService>().updateUserProfile(
         userId,
           nameController.text,
           emailController.text,
           dobController.text,
           selectedGender.value,
           profileImage
           //File? profileImage;
        );
         if(isUpdate){
           final user = await Get.find<ProfileController>().getUser(savedData.value?.id ?? "");
           if(user != null ){
             print(user.email);
             print("user is not null in pref");
             await AuthStorage.clearUserData();
             await AuthStorage.saveUserInPrefs(user);
             final con = Get.find<ProfileController>();
             con.savedData.value = await AuthStorage.getUserFromPrefs();
             print(con.savedData.value?.email);
           }
         }


        // Simulate network delay
        return isUpdate;


        // Get.snackbar(
        //   'Success',
        //   'Profile updated successfully!',
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        //   duration: const Duration(seconds: 2),
        // );

        // Navigate back or refresh data
        // Get.back();
      } catch (e) {
        errorMessage.value = 'Error: $e';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      } finally {
        isLoading.value = false;
      }
    }
    return false;
  }

  void resetForm() {
    nameController.text = 'John Doe';
    emailController.text = 'john@example.com';
    dobController.text = '1990-05-15';
    selectedGender.value = 'Male';
    errorMessage.value = '';
    formKey.currentState?.reset();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.onClose();
  }

  Future<void> getProfileData() async {
    savedData.value = await AuthStorage.getUserFromPrefs();
    print("Dev :- fetched profile data${savedData.value?.isProfileComplete}");
  }

  // logout
  Future<void> logout() async {
    await AuthStorage.clearUserData();
    if (savedData.value != null) {
      Get.off(LoginScreen());
    }
  }

  Future<bool> updatePrifilePicture(File image) async {
    String userId = await AuthStorage.getUserFromPrefs().then((user) => user?.id) ?? "";
    final isUpdate = await Get.find<ProfileService>().updateUserProfile(userId,null, null,null,null,image);
    if(isUpdate){
      final user = await Get.find<ProfileController>().getUser(savedData.value?.id ?? "");
      if(user != null ){
        print(user.email);
        print("user is not null in pref");
        await AuthStorage.clearUserData();
        await AuthStorage.saveUserInPrefs(user);
        final con = Get.find<ProfileController>();
        con.savedData.value = await AuthStorage.getUserFromPrefs();
        print(con.savedData.value?.email);
      }
    }else{
      return isUpdate;
    }
    return isUpdate;
  }

}
*/
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:newdow_customer/features/auth/model/models/userModel.dart';
// import 'package:newdow_customer/features/profile/model/services/profileService.dart';
// import 'package:newdow_customer/widgets/snackBar.dart';
// import '../../../utils/prefs.dart';
// import '../../auth/view/login_screen.dart';
// import '../model/userModel.dart';
//
// class ProfileController extends GetxController {
//   var savedData = Rx<UserModel?>(null);
//   final formKey = GlobalKey<FormState>();
//
//   // Text controllers
//   late TextEditingController nameController;
//   late TextEditingController emailController;
//   late TextEditingController dobController;
//   File? profileImage;
//
//   final genderOptions = ['male', 'female'];
//
//   // Reactive variables
//   final RxString selectedGender = 'male'.obs;
//   final RxBool isLoading = false.obs;
//   final RxString errorMessage = ''.obs;
//   final RxBool isFormValid = false.obs;
//
//   @override
//   void onInit() async {
//     super.onInit();
//     await initializeControllers(); // AWAIT the async function
//   }
//
//   Future<UserModel?> getUser(String userId) async {
//     return await Get.find<ProfileService>().getUserDetails(userId);
//   }
//
//   // Changed to async and removed the extra 'async' before the parameter
//   Future<void> initializeControllers() async {
//     try {
//       final user = await AuthStorage.getUserFromPrefs();
//
//       // Initialize controllers with user data
//       nameController = TextEditingController(text: user?.name ?? "");
//       emailController = TextEditingController(text: user?.email ?? "");
//
//       if (user?.dob != null && user!.dob!.isNotEmpty) {
//         DateTime dob = DateTime.parse(user.dob!);
//         dobController = TextEditingController(
//           text: DateFormat("dd-MM-yyyy").format(dob),
//         );
//       } else {
//         dobController = TextEditingController(text: "");
//       }
//
//       // Set gender from user data if available
//       if (user?.gender != null && user!.gender!.isNotEmpty) {
//         selectedGender.value = user.gender!.toLowerCase();
//       }
//
//       // Listen to text changes for form validation
//       nameController.addListener(validateForm);
//       emailController.addListener(validateForm);
//       dobController.addListener(validateForm);
//
//       validateForm(); // Initial validation
//     } catch (e) {
//       print("Error initializing controllers: $e");
//       // Initialize with empty controllers as fallback
//       nameController = TextEditingController();
//       emailController = TextEditingController();
//       dobController = TextEditingController();
//     }
//   }
//
//   void validateForm() {
//     isFormValid.value = nameController.text.isNotEmpty &&
//         emailController.text.isNotEmpty &&
//         dobController.text.isNotEmpty &&
//         selectedGender.value.isNotEmpty;
//   }
//
//   String? validateName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your name';
//     }
//     if (value.length < 2) {
//       return 'Name must be at least 2 characters';
//     }
//     if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
//       return 'Name can only contain letters and spaces';
//     }
//     return null;
//   }
//
//   String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your email';
//     }
//     final emailRegex = RegExp(
//       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
//     );
//     if (!emailRegex.hasMatch(value)) {
//       return 'Please enter a valid email';
//     }
//     return null;
//   }
//
//   String? validateDOB(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please select your date of birth';
//     }
//     return null;
//   }
//
//   String? validateGender(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please select your gender';
//     }
//     return null;
//   }
//
//   Future<void> selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: dobController.text.isNotEmpty
//           ? DateFormat('dd-MM-yyyy').parse(dobController.text)
//           : DateTime(2000),
//       firstDate: DateTime(1950),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       dobController.text = DateFormat('dd-MM-yyyy').format(picked);
//       validateForm();
//     }
//   }
//
//   void setGender(String gender) {
//     selectedGender.value = gender;
//     validateForm();
//   }
//
//   Future<bool> updateProfile() async {
//     errorMessage.value = '';
//
//     if (formKey.currentState!.validate()) {
//       isLoading.value = true;
//       try {
//         String userId = await AuthStorage.getUserFromPrefs()
//             .then((user) => user?.id ?? "");
//
//         bool isUpdate = await Get.find<ProfileService>().updateUserProfile(
//           userId,
//           nameController.text,
//           emailController.text,
//           dobController.text,
//           selectedGender.value,
//           profileImage,
//         );
//
//         if (isUpdate) {
//           final user = await getUser(savedData.value?.id ?? "");
//           if (user != null) {
//             await AuthStorage.clearUserData();
//             await AuthStorage.saveUserInPrefs(user);
//             final con = Get.find<ProfileController>();
//             con.savedData.value = await AuthStorage.getUserFromPrefs();
//           }
//         }
//
//         return isUpdate;
//       } catch (e) {
//         errorMessage.value = 'Error: $e';
//         Get.snackbar(
//           'Error',
//           errorMessage.value,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         return false;
//       } finally {
//         isLoading.value = false;
//       }
//     }
//     return false;
//   }
//
//   void resetForm() {
//     nameController.text = '';
//     emailController.text = '';
//     dobController.text = '';
//     selectedGender.value = 'male';
//     errorMessage.value = '';
//     formKey.currentState?.reset();
//   }
//
//   @override
//   void onClose() {
//     nameController.dispose();
//     emailController.dispose();
//     dobController.dispose();
//     super.onClose();
//   }
//
//   Future<void> getProfileData() async {
//     savedData.value = await AuthStorage.getUserFromPrefs();
//     print("Fetched profile data: ${savedData.value?.isProfileComplete}");
//   }
//
//   Future<void> logout() async {
//     await AuthStorage.clearUserData();
//     if (savedData.value != null) {
//       Get.off(LoginScreen());
//     }
//   }
//
//   Future<bool> updatePrifilePicture(File image) async {
//     String userId = await AuthStorage.getUserFromPrefs()
//         .then((user) => user?.id ?? "");
//
//     final isUpdate = await Get.find<ProfileService>()
//         .updateUserProfile(userId, null, null, null, null, image);
//
//     if (isUpdate) {
//       final user = await getUser(savedData.value?.id ?? "");
//       if (user != null) {
//         await AuthStorage.clearUserData();
//         await AuthStorage.saveUserInPrefs(user);
//         final con = Get.find<ProfileController>();
//         con.savedData.value = await AuthStorage.getUserFromPrefs();
//       }
//     }
//     return isUpdate;
//   }
// }
/*
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:newdow_customer/features/auth/model/models/userModel.dart';
import 'package:newdow_customer/features/profile/model/services/profileService.dart';
import 'package:newdow_customer/widgets/snackBar.dart';
import '../../../utils/prefs.dart';
import '../../auth/view/login_screen.dart';
import '../model/userModel.dart';

class ProfileController extends GetxController {
  var savedData = Rx<UserModel?>(null);
  final formKey = GlobalKey<FormState>();

  // Text controllers
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController dobController;
  File? profileImage;

  final genderOptions = ['male', 'female'];

  // Reactive variables
  final RxString selectedGender = 'male'.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isFormValid = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await initializeControllers(); // AWAIT the async function
  }

  Future<UserModel?> getUser(String userId) async {
    return await Get.find<ProfileService>().getUserDetails(userId);
  }

  // Changed to async and removed the extra 'async' before the parameter
  Future<void> initializeControllers() async {
    try {
      final user = await AuthStorage.getUserFromPrefs();

      // Initialize controllers with user data
      nameController = TextEditingController(text: user?.name ?? "");
      emailController = TextEditingController(text: user?.email ?? "");

      if (user?.dob != null && user!.dob!.isNotEmpty) {
        DateTime dob = DateTime.parse(user.dob!);
        dobController = TextEditingController(
          text: DateFormat("dd-MM-yyyy").format(dob),
        );
      } else {
        dobController = TextEditingController(text: "");
      }

      // Set gender from user data if available
      if (user?.gender != null && user!.gender!.isNotEmpty) {
        selectedGender.value = user.gender!.toLowerCase();
      }

      // Listen to text changes for form validation
      nameController.addListener(validateForm);
      emailController.addListener(validateForm);
      dobController.addListener(validateForm);

      validateForm(); // Initial validation
    } catch (e) {
      print("Error initializing controllers: $e");
      // Initialize with empty controllers as fallback
      nameController = TextEditingController();
      emailController = TextEditingController();
      dobController = TextEditingController();
    }
  }

  void validateForm() {
    isFormValid.value = nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        selectedGender.value.isNotEmpty;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateDOB(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your date of birth';
    }
    return null;
  }

  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender';
    }
    return null;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dobController.text.isNotEmpty
          ? DateFormat('dd-MM-yyyy').parse(dobController.text)
          : DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = DateFormat('dd-MM-yyyy').format(picked);
      validateForm();
    }
  }

  void setGender(String gender) {
    selectedGender.value = gender;
    validateForm();
  }

  Future<bool> updateProfile() async {
    errorMessage.value = '';

    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        String userId = await AuthStorage.getUserFromPrefs()
            .then((user) => user?.id ?? "");

        bool isUpdate = await Get.find<ProfileService>().updateUserProfile(
          userId,
          nameController.text,
          emailController.text,
          dobController.text,
          selectedGender.value,
          profileImage,
        );

        if (isUpdate) {
          final user = await getUser(savedData.value?.id ?? "");
          if (user != null) {
            await AuthStorage.clearUserData();
            await AuthStorage.saveUserInPrefs(user);
            final con = Get.find<ProfileController>();
            con.savedData.value = await AuthStorage.getUserFromPrefs();
          }
        }

        return isUpdate;
      } catch (e) {
        errorMessage.value = 'Error: $e';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      } finally {
        isLoading.value = false;
      }
    }
    return false;
  }

  void resetForm() {
    nameController.text = '';
    emailController.text = '';
    dobController.text = '';
    selectedGender.value = 'male';
    errorMessage.value = '';
    formKey.currentState?.reset();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.onClose();
  }

  Future<void> getProfileData() async {
    savedData.value = await AuthStorage.getUserFromPrefs();
    print("Fetched profile data: ${savedData.value?.isProfileComplete}");
  }

  void resetControllers() {
    nameController.clear();
    emailController.clear();
    dobController.clear();
    selectedGender.value = 'male';
    errorMessage.value = '';
    profileImage = null;
    formKey.currentState?.reset();
  }

  Future<void> logout() async {
    print("Logging out - clearing controller data");

    // Dispose all text controllers
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();

    print(nameController);
    print(emailController);
    print(dobController);

    // Reset reactive variables
    selectedGender.value = 'male';
    errorMessage.value = '';
    savedData.value = null;
    profileImage = null;
    isLoading.value = false;
    isFormValid.value = false;

    // Clear from SharedPreferences
    await AuthStorage.clearUserData();

    // Delete the ProfileController instance completely
    Get.delete<ProfileController>(force: true);

    print("Controller deleted successfully");

    // Navigate to login
    Get.offAll(() => LoginScreen());
  }

  Future<bool> updatePrifilePicture(File image) async {
    String userId = await AuthStorage.getUserFromPrefs()
        .then((user) => user?.id ?? "");

    final isUpdate = await Get.find<ProfileService>()
        .updateUserProfile(userId, null, null, null, null, image);

    if (isUpdate) {
      final user = await getUser(savedData.value?.id ?? "");
      if (user != null) {
        await AuthStorage.clearUserData();
        await AuthStorage.saveUserInPrefs(user);
        final con = Get.find<ProfileController>();
        con.savedData.value = await AuthStorage.getUserFromPrefs();
      }
    }
    return isUpdate;
  }
}*/
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:newdow_customer/features/auth/model/models/userModel.dart';
import 'package:newdow_customer/features/profile/model/services/profileService.dart';
import 'package:newdow_customer/widgets/snackBar.dart';
import '../../../binding/service_locater.dart';
import '../../../utils/prefs.dart';
import '../../auth/view/login_screen.dart';
import '../../cart/controller/cart_controller.dart';
import '../model/userModel.dart';

class ProfileController extends GetxController {
  var savedData = Rx<UserModel?>(null);
  final formKey = GlobalKey<FormState>();

  // Text controllers
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController dobController;
  File? profileImage;

  final genderOptions = ['male', 'female'];

  // Reactive variables
  final RxString selectedGender = 'male'.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isFormValid = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await initializeControllers(); // AWAIT the async function
  }

  Future<UserModel?> getUser(String userId) async {
    return await Get.find<ProfileService>().getUserDetails(userId);
  }

  // Changed to async and removed the extra 'async' before the parameter
  Future<void> initializeControllers() async {
    try {
      final user = await AuthStorage.getUserFromPrefs();

      // Initialize controllers with user data
      nameController = TextEditingController(text: user?.name ?? "");
      emailController = TextEditingController(text: user?.email ?? "");

      if (user?.dob != null && user!.dob!.isNotEmpty) {
        DateTime dob = DateTime.parse(user.dob!);
        dobController = TextEditingController(
          text: DateFormat("dd-MM-yyyy").format(dob),
        );
      } else {
        dobController = TextEditingController(text: "");
      }

      // Set gender from user data if available
      if (user?.gender != null && user!.gender!.isNotEmpty) {
        selectedGender.value = user.gender!.toLowerCase();
      }

      // Listen to text changes for form validation
      nameController.addListener(validateForm);
      emailController.addListener(validateForm);
      dobController.addListener(validateForm);

      validateForm(); // Initial validation
    } catch (e) {
      print("Error initializing controllers: $e");
      // Initialize with empty controllers as fallback
      nameController = TextEditingController();
      emailController = TextEditingController();
      dobController = TextEditingController();
    }
  }

  void validateForm() {
    isFormValid.value = nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        selectedGender.value.isNotEmpty;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateDOB(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your date of birth';
    }
    return null;
  }

  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender';
    }
    return null;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dobController.text.isNotEmpty
          ? DateFormat('dd-MM-yyyy').parse(dobController.text)
          : DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = DateFormat('dd-MM-yyyy').format(picked);
      validateForm();
    }
  }

  void setGender(String gender) {
    selectedGender.value = gender;
    validateForm();
  }

  Future<bool> updateProfile() async {
    errorMessage.value = '';

    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        String userId = await AuthStorage.getUserFromPrefs()
            .then((user) => user?.id ?? "");
        print("updateing date :- ");
        bool isUpdate = await Get.find<ProfileService>().updateUserProfile(
          userId,
          nameController.text,
          emailController.text,
          dobController.text,
          selectedGender.value,
          profileImage,
        );

        if (isUpdate) {
          final user = await getUser(savedData.value?.id ?? "");
          if (user != null) {
            await AuthStorage.clearUserData();
            await AuthStorage.saveUserInPrefs(user);
            final con = Get.find<ProfileController>();
            con.savedData.value = await AuthStorage.getUserFromPrefs();
          }
        }

        return isUpdate;
      } catch (e) {
        errorMessage.value = 'Error: $e';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      } finally {
        isLoading.value = false;
      }
    }
    return false;
  }

  void resetForm() {
    nameController.text = '';
    emailController.text = '';
    dobController.text = '';
    selectedGender.value = 'male';
    errorMessage.value = '';
    formKey.currentState?.reset();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.onClose();
  }

  Future<void> getProfileData() async {
    savedData.value = await AuthStorage.getUserFromPrefs();
    print("Fetched profile data: ${savedData.value?.isProfileComplete}");
  }

  void resetControllers() {
    nameController.clear();
    emailController.clear();
    dobController.clear();
    selectedGender.value = 'male';
    errorMessage.value = '';
    profileImage = null;
    formKey.currentState?.reset();
  }

  Future<void> logout() async {
    final cartCon = Get.find<CartController>();
    print("Logging out - clearing controller data");
    resetControllers();
    //cartCon.localCartItems.value.assignAll([]);
    //cartCon.cartList.value.assignAll([]);
    // Dispose all text controllers
    // nameController.text = "";
    // emailController.text = "";
    //
    //
    // // Reset reactive variables
    // selectedGender.value = 'male';
    // errorMessage.value = '';
    // savedData.value = null;
    // profileImage = null;
    // isLoading.value = false;
    // isFormValid.value = false;

    // Clear from SharedPreferences
    //await AuthStorage.clearUserData();
    await AuthStorage.clearUserData();
    ServiceLocater.reset();

    // Delete the ProfileController instance completely
    //Get.delete<ProfileController>(force: true);

    print("Controller deleted successfully");

    // Navigate to login
    Get.offAll(() => LoginScreen(isFromLogout: true));
  }

  Future<bool> updatePrifilePicture(File image) async {
    String userId = await AuthStorage.getUserFromPrefs()
        .then((user) => user?.id ?? "");

    final isUpdate = await Get.find<ProfileService>()
        .updateUserProfile(userId, null, null, null, null, image);

    if (isUpdate) {
      final user = await getUser(savedData.value?.id ?? "");
      if (user != null) {
        await AuthStorage.clearUserData();
        await AuthStorage.saveUserInPrefs(user);
        final con = Get.find<ProfileController>();
        con.savedData.value = await AuthStorage.getUserFromPrefs();
      }
    }
    return isUpdate;
  }
}