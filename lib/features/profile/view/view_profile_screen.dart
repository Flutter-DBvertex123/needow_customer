import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newdow_customer/features/profile/view/update_profile_screen.dart';
import 'package:newdow_customer/utils/apptheme.dart';
import 'package:newdow_customer/utils/constants.dart';
import 'package:newdow_customer/utils/getSize.dart';
import 'package:newdow_customer/widgets/appbutton.dart';
import 'package:newdow_customer/widgets/profile_picture.dart';

import '../../../widgets/appbar.dart';
import '../controller/profile_controller.dart';
class ViewProfileScreen extends StatefulWidget {
  ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  ProfileController profileCon = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileCon.getProfileData();
  }

  @override
  Widget build(BuildContext context) {
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
            
          child: Appbutton(buttonText: "Edit Profile", onTap: () => Get.to(UpdateProfileScreen()),),
        ),
      ),
    
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            DefaultAppBar(titleText: "Your Profile",isFormBottamNav: false,),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Stack(
                        children:[
                          /*Obx(() => CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(profileCon.savedData.value?.photo ?? ""),
                            ),
                          ),*/
                          Obx(() => ProfileAvatar(imageUrl: profileCon.savedData.value?.photo ?? "")),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () => showImagePickerBottomSheet(context),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.primary,
                                child: SvgPicture.asset(edit_pic),
                              ),
                            ),
                          )
                        ]
                    ),
                    SizedBox(height: 20),
                    Obx(() => buildField("Name", profileCon.savedData.value?.name ?? "", context)),
                    Obx(() => buildField("Phone Number", profileCon.savedData.value?.phone ?? "", context)),
                    Obx(() => buildField("Email", profileCon.savedData.value?.email ?? "", context)),
                    Obx(() => buildField("Gender", profileCon.savedData.value?.gender ?? "", context)),
                    //buildLogOutField("Logout", "Logout", context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildField(String label, String value,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Container(
            margin: EdgeInsets.symmetric(vertical: 6),
            padding:  EdgeInsets.all(16),
            height: 56,
            alignment: Alignment.centerLeft,
            width: 1.toWidthPercent(),
            decoration: BoxDecoration(
              color: Color(0xFFEBEBEB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(value,style: TextStyle(fontSize: 15,color: AppColors.textSecondary),),
          )
        ],
      ),
    );
  }
  Widget buildLogOutField (String label, String value,BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () => {
              profileCon.logout(),
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              padding:  EdgeInsets.all(16),
              height: 56,
              alignment: Alignment.centerLeft,
              width: 1.toWidthPercent(),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(value,style: TextStyle(fontSize: 15,color: AppColors.textSecondary),),
            ),
          )
        ],
      ),
    );
  }
  Future<void> showImagePickerBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Choose Profile Picture',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await _pickImage(fromCamera: false);
                  if (image != null) {
                    await Get.find<ProfileController>().updatePrifilePicture(image);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.green),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await _pickImage(fromCamera: true);
                  if (image != null) {
                    await Get.find<ProfileController>().updatePrifilePicture(image);
                  }
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
  Future<File?> _pickImage({required bool fromCamera}) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1080,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        debugPrint("❌ No image selected");
        return null;
      }
    } catch (e) {
      debugPrint("⚠️ Error picking image: $e");
      return null;
    }
  }
}
