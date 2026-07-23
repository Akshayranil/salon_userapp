import 'dart:io'; // 🆕 NEW

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_app/core/constant_colors.dart';
import 'package:salon_app/core/custom_navigationbar.dart';

import 'package:salon_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:salon_app/features/home/presentation/ui/home_screen.dart';
import 'package:salon_app/features/profile/presentation/bloc/profile_bloc.dart';

class ProfileSetupScreen extends StatefulWidget {
  // 🔥 MODIFIED (Stateless → Stateful)
  final String uid;

  const ProfileSetupScreen({super.key, required this.uid});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final placeController = TextEditingController();

  File? selectedImage; // 🆕 NEW
  String imageUrl = ""; // 🆕 NEW

  // 🆕 PICK IMAGE FROM GALLERY
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });

      // 🔥 CALL BLOC → UPLOAD IMAGE
      context.read<ProfileBloc>().add(UploadProfileImageEvent(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setup Profile"), centerTitle: true),

      body: BlocConsumer<ProfileBloc, ProfileState>(
        // 🔥 MODIFIED
        listener: (context, state) {
          // ✅ IMAGE UPLOADED → STORE URL
          if (state is ImageUploadedState) {
            imageUrl = state.imageUrl;

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Image Uploaded")));
          }

          // ✅ PROFILE SAVED → GO HOME
          if (state is ProfileSaved) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CustomNavigationbar()),
            );
          }
        },

        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // 🔴 PROFILE IMAGE PICKER
                    GestureDetector(
                      onTap: pickImage,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage!)
                            : null,
                        child: selectedImage == null
                            ? Icon(Icons.camera_alt, size: 30)
                            : null,
                      ),
                    ),

                    SizedBox(height: 60),

                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: placeController,
                      decoration: InputDecoration(
                        labelText: "Place",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 50),

                    if (state is ProfileLoading)
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () {
                          context.read<ProfileBloc>().add(
                            SaveProfileEvent(
                              uid: widget.uid,
                              name: nameController.text.trim(),
                              phone: phoneController.text.trim(),
                              place: placeController.text.trim(),
                              image: imageUrl, // 🔥 IMPORTANT (real URL)
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColor.secondary,
                          backgroundColor: AppColor.primary,
                          minimumSize: Size(320, 50),
                        ),
                        child: Text("Save", style: TextStyle(fontSize: 16)),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
