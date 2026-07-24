import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_app/core/constant_colors.dart';
import 'package:salon_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:salon_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:salon_app/features/profile/presentation/ui/profile_setupscreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile",style: TextStyle(color: AppColor.secondary),),centerTitle: true,backgroundColor: AppColor.primary,iconTheme: IconThemeData(color: AppColor.secondary)),

      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          
          // 🔄 LOADING
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ ERROR
          if (state is ProfileFailure) {
            return Center(child: Text(state.error));
          }

          // ✅ SUCCESS
          if (state is ProfileLoaded) {
            final name = state.name;
            final phone = state.phone;
            final place = state.place;
            final imageUrl = state.image;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 🔴 PROFILE IMAGE
                    GestureDetector(
                      onTap: () {
                        if (imageUrl.isNotEmpty) {
                          
                          showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              backgroundColor: Colors.transparent,
                              child: InteractiveViewer(
                                child: Image.network(imageUrl),
                              ),
                            ),
                          );
                        }
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl)
                            : null,
                        child: imageUrl.isEmpty
                            ? const Icon(Icons.person, size: 80)
                            : null,
                        onBackgroundImageError: (_, __) {},
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      initialValue: name,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      initialValue: phone,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      initialValue: place,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Place',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text("Edit Profile"),
                      onTap: () {
                        final uid = FirebaseAuth.instance.currentUser!.uid;
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileSetupScreen(uid: uid)));
                      },
                    ),

                    const Divider(),
                     ListTile(
                      leading: const Icon(
                        Icons.privacy_tip_outlined,
                        
                      ),
                      title: const Text('Privacy Policy'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => PrivacyPolicyScreen(),
                        //   ),
                        // );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.article_outlined,
                        
                      ),
                      title: const Text('Terms & Conditions'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => TermsAndConditionsScreen(),
                        //   ),
                        // );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.help_outline,
                        
                      ),
                      title: const Text('Help & Support'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => HelpSupportScreen(),
                        //   ),
                        // );
                      },
                    ),
                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text("Logout"),
                      onTap: () {
                        context.read<AuthBloc>().add(AuthLogout());
                        // Navigator.pushReplacementNamed(context, "/login");
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text("No data"));
        },
      ),
    );
  }
}
