import 'package:chat_keluarga/bloc/auth/auth_bloc.dart';
import 'package:chat_keluarga/utils/storage_util.dart';
import 'package:chat_keluarga/views/home_view.dart';
import 'package:chat_keluarga/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isExpired = false; // Default ke false (akan ke LoginView)

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    String? token = await StorageUtils.getToken();
    if (token == null) {
      setState(() => isExpired = false); // Tidak ada token, ke LoginView
    } else {
      try {
        Map<String, dynamic> payload = Jwt.parseJwt(token);
        int expiry = payload['exp'];
        DateTime expiryDate = DateTime.fromMillisecondsSinceEpoch(
          expiry * 1000,
        );
        DateTime now = DateTime.now();
        setState(
          () => isExpired = now.isBefore(expiryDate),
        ); // True jika belum expired
      } catch (e) {
        await StorageUtils.deleteToken(); // Token rusak, hapus
        setState(() => isExpired = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isExpired
            ? HomeView()
            : LoginView(), // Pilih halaman berdasarkan isExpired
      ),
    );
  }
}
