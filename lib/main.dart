import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

Future<void> main() async {
  // Khởi tạo widget binding để đảm bảo Firebase chạy đúng
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase
  await Firebase.initializeApp();

  // Đăng nhập ẩn danh (mỗi người dùng có UID riêng)
  await FirebaseAuth.instance.signInAnonymously();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Chat',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const ChatScreen(), // Mở màn hình chat chính
    );
  }
}
