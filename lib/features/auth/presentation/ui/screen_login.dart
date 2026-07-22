
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_app/core/constant_colors.dart';
import 'package:salon_app/core/custom_navigationbar.dart';
import 'package:salon_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:salon_app/features/auth/presentation/ui/screen_signup.dart';
import 'package:salon_app/features/auth/presentation/widgets/email_field.dart';
import 'package:salon_app/features/auth/presentation/widgets/google_authentication.dart';
import 'package:salon_app/features/auth/presentation/widgets/password_login.dart';
import 'package:salon_app/features/auth/presentation/widgets/reset_field.dart';
import 'package:salon_app/features/profile/presentation/ui/profile_setupscreen.dart';
// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool obscureText = true;
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login ',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Text(
                      'Plan. Book. Relax. ',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Text(
                      'Sign in to get started!!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                  EmailLoginField(emailcontroller: emailcontroller,),
                  SizedBox(height: 30),
                  
                PasswordLoginField(passwordcontroller: passwordcontroller,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     ResetPasswordField()
                    ],
                  ),

                  if (state is AuthLoading)
                    const CircularProgressIndicator()
                  else
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final email = emailcontroller.text.trim();
                              final password = passwordcontroller.text.trim();
                              context.read<AuthBloc>().add(
                                AuthLogin(email, password),
                              );
                            },

                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(250, 40),
                              backgroundColor: AppColor.primary,
                              foregroundColor: AppColor.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.only(left: 66),
                            child: Row(
                              children: [
                                Text("Don't have an account?"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(color: Colors.grey, thickness: 1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('OR'),
                        ),
                        Expanded(
                          child: Divider(color: Colors.grey, thickness: 1),
                        ),
                      ],
                    ),
                  ),

                  GoogleAuthentication()
                ],
              ),
            ),
          );
        },
        listener: (context, state) async {
  if (state is AuthSuccess) {
 if (state.hasProfile) {
      // Already setup → go to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => CustomNavigationbar()), 
      );
    }
     else {
      // First time → go to ProfileSetup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProfileSetupScreen(uid: state.user.uid)),
      );
    }
  } else if (state is AuthFailure) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.error)),
      
    );
  } else if (state is AuthProfileSaved) {
     Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => CustomNavigationbar(),
      ),
      (route) => false,
    );
  }
}

      ),
    );
  }


}
