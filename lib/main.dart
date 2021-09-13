import 'package:flutter/material.dart';

import 'package:flutter_auth_ui/flutter_auth_ui.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_auth_ui_test'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final providers = [
              AuthUiProvider.email,
            ];

            final result = await FlutterAuthUi.startUi(
              items: providers,
              tosAndPrivacyPolicy: TosAndPrivacyPolicy(
                  tosUrl: 'https://www.google.com',
                  privacyPolicyUrl: 'https://www.google.com'),
            );

            print(result);
          },
          child: const Text('open'),
        ),
      ),
    );
  }
}
