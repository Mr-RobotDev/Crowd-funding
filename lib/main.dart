import 'package:afofa/ui/screens/auth/login_screen.dart';
import 'package:afofa/ui/screens/auth/verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'routes/routes.dart';
import 'theme/app_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(414, 896),
      builder: (context, child) => MaterialApp(
        title: 'AFOFA',
        theme: AppTheme(context).initTheme(),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteGenerator.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            return const VerifyEmailScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
