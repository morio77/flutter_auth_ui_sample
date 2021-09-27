import 'package:flutter/material.dart';

import 'package:flutter_auth_ui/flutter_auth_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_auth_ui_test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isLogined = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    auth.userChanges().listen((user) {
      if (user != null) {
        print('uesr signed in');
        isLogined = true;
      } else {
        print('user signed out');
        isLogined = false;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_auth_ui_test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'ログイン状態：$isLogined',
              style: const TextStyle(fontSize: 20),
            ),

            // 認証UIを開くボタン
            ElevatedButton(
              onPressed: () async {
                final providers = [
                  AuthUiProvider.email,
                  AuthUiProvider.phone,
                ];

                final result = await FlutterAuthUi.startUi(
                  items: providers,
                  tosAndPrivacyPolicy: TosAndPrivacyPolicy(
                    tosUrl: 'https://www.google.com',
                    privacyPolicyUrl: 'https://www.google.com',
                  ),
                  emailAuthOption: const EmailAuthOption(
                    enableMailLink: true,
                    handleURL: 'https://flutterauthuisample.page.link/test',
                    androidPackageName: 'com.example.flutter_auth_ui_sample',
                  ),
                );
                print(result);
              },
              child: const Text('認証フローをスタート'),
            ),

            // ログアウトボタン
            ElevatedButton(
              onPressed: isLogined
                  ? () async {
                      final auth = FirebaseAuth.instance;
                      await auth.signOut();
                      setState(() {
                        isLogined = false;
                      });
                    }
                  : null,
              child: const Text('ログアウトする'),
            ),
          ],
        ),
      ),
    );
  }
}
