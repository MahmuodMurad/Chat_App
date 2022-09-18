import '/screens/spalsh_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import '/screens/chat_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.black87, elevation: 0),
        primaryColor:const Color(0xffAF1616),
        primarySwatch: Colors.red,
        backgroundColor: Colors.black87,
        colorScheme:
            ThemeData().colorScheme.copyWith(secondary:const Color(0xffAF1616)),
        inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.white54),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xffFC0101)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xff550106)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xffFC0101)),
            ),
            errorStyle: TextStyle(color: Color(0xffFC0101),),),
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const SpalshScreen();
          }
          if (snapShot.hasData) {
            return const ChatScreen();
          } else {
            return AuthScreen();
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatApp'),
      ),
      body: const Center(
        child: Text('ChatApp'),
      ),
    );
  }
}
