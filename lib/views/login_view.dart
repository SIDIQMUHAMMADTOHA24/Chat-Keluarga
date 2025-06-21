import 'package:chat_keluarga/bloc/auth/auth_bloc.dart';
import 'package:chat_keluarga/views/home_view.dart';
import 'package:chat_keluarga/views/register_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = false;

  void onVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
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
              obscureText: isVisible,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                suffixIcon: GestureDetector(
                  onTap: onVisible,
                  child: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                context.read<AuthBloc>().add(
                  LoginEvent(
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
                return Text("Login");
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
                      TextSpan(text: "Don't have account? "),
                      TextSpan(
                        text: "Register",
                        style: TextStyle(color: Colors.blue.shade800),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterView(),
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
