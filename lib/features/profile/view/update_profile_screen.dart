/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newdow_customer/features/profile/controller/profile_controller.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/appbutton.dart';

import '../../../utils/apptheme.dart';
import '../../../widgets/snackBar.dart';


class UpdateProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<ProfileController>().initializeControllers();
    return Scaffold(
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF9F9F9),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.center,
          height: 0.1.toHeightPercent(),

          child: Obx(
                () => Appbutton(
              buttonText: "Update Profile",
              onTap: ()  async {
                bool isUpdated = await controller.updateProfile();
                isUpdated ? AppSnackBar.showSuccess(context, message: "Profile Updated Successfully"): AppSnackBar.showError(context, message: "Profile Upload failed");
              },
              isLoading: controller.isLoading.value,
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          DefaultAppBar(titleText: "Update Profile", isFormBottamNav: false),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name Field
                    const Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: AppColors.primary,),
                        hintText: "Your full name",
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xff0A9962),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xff0A9962),
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      validator: controller.validateName,
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      cursorColor: Colors.green,
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,color: AppColors.primary,),
                        hintText: "Enter email",
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xff0A9962),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xff0A9962),
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      validator: controller.validateEmail,
                    ),
                    const SizedBox(height: 20),

                    // Date of Birth Field
                    const Text(
                      'Date of Birth',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xff0A9962),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xff0A9962),
                            width: 1.5,
                          ),
                        ),
                        hintText: 'Date of birth',
                        prefixIcon: const Icon(Icons.calendar_today,color: AppColors.primary,),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onTap: () => controller.selectDate(context),
                      validator: controller.validateDOB,
                    ),
                    const SizedBox(height: 20),

                    // Gender Field
                    const Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                          () => DropdownButtonFormField<String>(
                        value: controller.selectedGender.value,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xff0A9962),
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xff0A9962),
                              width: 1.5,
                            ),
                          ),
                          prefixIcon: const Icon(Icons.wc,color: AppColors.primary,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'male', child: Text('Male')),
                          DropdownMenuItem(value: 'female', child: Text('Female')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            controller.setGender(value);
                          }
                        },
                        validator: controller.validateGender,
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Update Button

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:newdow_customer/features/profile/controller/profile_controller.dart';
// import 'package:newdow_customer/utils/getSize.dart';
// import 'package:newdow_customer/widgets/appbar.dart';
// import 'package:newdow_customer/widgets/appbutton.dart';
// import '../../../utils/apptheme.dart';
// import '../../../widgets/snackBar.dart';
//
// class UpdateProfileScreen extends StatelessWidget {
//   final ProfileController controller = Get.find<ProfileController>();
//
//   UpdateProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // REMOVED: Get.find<ProfileController>().initializeControllers();
//     // This is now called in onInit() of the controller
//
//     return Scaffold(
//       bottomNavigationBar: SafeArea(
//         top: false,
//         child: Container(
//           decoration: BoxDecoration(
//             color: Color(0xFFF9F9F9),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 10,
//                 offset: Offset(0, -2),
//               ),
//             ],
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           alignment: Alignment.center,
//           height: 0.1.toHeightPercent(),
//           child: Obx(
//                 () => Appbutton(
//               buttonText: "Update Profile",
//               onTap: () async {
//                 bool isUpdated = await controller.updateProfile();
//                 isUpdated
//                     ? AppSnackBar.showSuccess(context,
//                     message: "Profile Updated Successfully")
//                     : AppSnackBar.showError(context,
//                     message: "Profile Upload failed");
//               },
//               isLoading: controller.isLoading.value,
//             ),
//           ),
//         ),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           DefaultAppBar(titleText: "Update Profile", isFormBottamNav: false),
//           SliverToBoxAdapter(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24),
//               child: Form(
//                 key: controller.formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Name Field
//                     const Text(
//                       'Name',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     TextFormField(
//                       controller: controller.nameController,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(
//                           Icons.person,
//                           color: AppColors.primary,
//                         ),
//                         hintText: "Your full name",
//                         hintStyle: TextStyle(color: AppColors.textSecondary),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: const BorderSide(
//                             color: Color(0xff0A9962),
//                             width: 2,
//                           ),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: const BorderSide(
//                             color: Color(0xff0A9962),
//                             width: 1.5,
//                           ),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 14),
//                       ),
//                       validator: controller.validateName,
//                     ),
//                     const SizedBox(height: 20),
//
//                     // Email Field
//                     const Text(
//                       'Email',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     TextFormField(
//                       cursorColor: Colors.green,
//                       controller: controller.emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(
//                           Icons.email_outlined,
//                           color: AppColors.primary,
//                         ),
//                         hintText: "Enter email",
//                         hintStyle: TextStyle(color: AppColors.textSecondary),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: const BorderSide(
//                             color: Color(0xff0A9962),
//                             width: 2,
//                           ),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: const BorderSide(
//                             color: Color(0xff0A9962),
//                             width: 1.5,
//                           ),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 14),
//                       ),
//                       validator: controller.validateEmail,
//                     ),
//                     const SizedBox(height: 20),
//
//                     // Date of Birth Field
//                     const Text(
//                       'Date of Birth',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     TextFormField(
//                       controller: controller.dobController,
//                       readOnly: true,
//                       decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: const BorderSide(
//                             color: Color(0xff0A9962),
//                             width: 2,
//                           ),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: const BorderSide(
//                             color: Color(0xff0A9962),
//                             width: 1.5,
//                           ),
//                         ),
//                         hintText: 'Date of birth',
//                         prefixIcon: const Icon(
//                           Icons.calendar_today,
//                           color: AppColors.primary,
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: AppColors.primary),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onTap: () => controller.selectDate(context),
//                       validator: controller.validateDOB,
//                     ),
//                     const SizedBox(height: 20),
//
//                     // Gender Field
//                     const Text(
//                       'Gender',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Obx(
//                           () => DropdownButtonFormField<String>(
//                         value: controller.selectedGender.value,
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: const BorderSide(
//                               color: Color(0xff0A9962),
//                               width: 2,
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: const BorderSide(
//                               color: Color(0xff0A9962),
//                               width: 1.5,
//                             ),
//                           ),
//                           prefixIcon: const Icon(
//                             Icons.wc,
//                             color: AppColors.primary,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         items: const [
//                           DropdownMenuItem(value: 'male', child: Text('Male')),
//                           DropdownMenuItem(
//                               value: 'female', child: Text('Female')),
//                         ],
//                         onChanged: (value) {
//                           if (value != null) {
//                             controller.setGender(value);
//                           }
//                         },
//                         validator: controller.validateGender,
//                       ),
//                     ),
//                     const SizedBox(height: 50),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newdow_customer/features/profile/controller/profile_controller.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbar.dart';
import 'package:newdow_customer/widgets/appbutton.dart';
import '../../../utils/apptheme.dart';
import '../../../widgets/snackBar.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final ProfileController controller = Get.find<ProfileController>();
  @override
  void initState() {
    initController();
    super.initState();
  }
  Future<void> initController() async {
    await controller.initializeControllers();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    // Get fresh controller instance (will call onInit which initializes data)
    final ProfileController controller = Get.find<ProfileController>();

    return Scaffold(
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF9F9F9),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          alignment: Alignment.center,
          height: 0.1.toHeightPercent(),
          child: Appbutton(
              buttonText: "Update Profile",
              onTap: () async {
                Get.find<LoadingController>().isLoading.value = true;
                bool isUpdated = await controller.updateProfile().timeout(Duration(seconds: 30),onTimeout: () =>Get.find<LoadingController>().isLoading.value = false );
                if(isUpdated){
                  AppSnackBar.showSuccess(context,
                  message: "Profile Updated Successfully");
                  Get.find<LoadingController>().isLoading.value = false;
                  Get.back();
                }else{
                  AppSnackBar.showError(context,
                      message: "Profile Upload failed");
                  Get.find<LoadingController>().isLoading.value = false;
                }

              },
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          DefaultAppBar(titleText: "Update Profile", isFormBottamNav: false),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name Field
                    const Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: AppColors.primary,
                        ),
                        hintText: "Your full name",
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xff0A9962),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xff0A9962),
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                      validator: controller.validateName,
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      cursorColor: Colors.green,
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.primary,
                        ),
                        hintText: "Enter email",
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xff0A9962),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xff0A9962),
                            width: 1.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                      validator: controller.validateEmail,
                    ),
                    const SizedBox(height: 20),

                    // Date of Birth Field
                    const Text(
                      'Date of Birth',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xff0A9962),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xff0A9962),
                            width: 1.5,
                          ),
                        ),
                        hintText: 'Date of birth',
                        prefixIcon: const Icon(
                          Icons.calendar_today,
                          color: AppColors.primary,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onTap: () => controller.selectDate(context),
                      validator: controller.validateDOB,
                    ),
                    const SizedBox(height: 20),

                    // Gender Field
                    const Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                          () => DropdownButtonFormField<String>(
                        value: controller.selectedGender.value,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xff0A9962),
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xff0A9962),
                              width: 1.5,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.wc,
                            color: AppColors.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'male', child: Text('Male')),
                          DropdownMenuItem(
                              value: 'female', child: Text('Female')),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            controller.setGender(value);
                          }
                        },
                        validator: controller.validateGender,
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}