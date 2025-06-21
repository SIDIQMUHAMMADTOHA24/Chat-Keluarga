import 'package:chat_keluarga/bloc/auth/auth_bloc.dart';
import 'package:chat_keluarga/views/home_view.dart';
import 'package:chat_keluarga/views/login_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isVisiblePassword = false;
  bool isVisibleConfirmPassword = false;

  void onVisiblePassword() {
    setState(() {
      isVisiblePassword = !isVisiblePassword;
    });
  }

  void onVisibleConfirmPassword() {
    setState(() {
      isVisibleConfirmPassword = !isVisibleConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(height: 8),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextFormField(
              controller: passwordController,
              obscureText: isVisiblePassword,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                suffixIcon: GestureDetector(
                  onTap: onVisiblePassword,
                  child: Icon(
                    isVisiblePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
              controller: confirmPasswordController,
              obscureText: isVisibleConfirmPassword,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Confirm Password",
                suffixIcon: GestureDetector(
                  onTap: onVisibleConfirmPassword,
                  child: Icon(
                    isVisibleConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty &&
                  confirmPasswordController.text.isNotEmpty &&
                  passwordController.text == confirmPasswordController.text) {
                context.read<AuthBloc>().add(
                  RegisterEvent(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ),
                );
              }
            },
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                    (route) => false,
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return CircularProgressIndicator();
                }
                return Text("Register");
              },
            ),
          ),
          SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: "You have account? "),
                      TextSpan(
                        text: "Login",
                        style: TextStyle(color: Colors.blue.shade800),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginView(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
