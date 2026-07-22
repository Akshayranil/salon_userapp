import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_app/features/auth/presentation/bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), centerTitle: true),

      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
  final user = state.user;

  return Center(
    child: Text("Logged in as ${user.email}"),
  );
}
          // 🔄 LOADING
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ ERROR
          if (state is AuthFailure) {
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

                    const SizedBox(height: 25),

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

                    const SizedBox(height: 30),
                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text("Edit Profile"),
                      onTap: () {
                        // Navigator.pushNamed(context, "/profileSetup");
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
