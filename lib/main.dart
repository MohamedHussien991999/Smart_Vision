import 'package:flutter/material.dart';
import 'package:smart_farm/shared/network/remote/dio_helper.dart';
import 'modules/intro/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Vision',
      home: const SplashScreen(),
      // initialRoute: '/',
      // routes: {
      //   "/": (context) => const SplashScreen(),
      //   "/intro": ((context) => IntroPage()),
      //   "/login": ((context) => const LoginScreen()),
      //   "/register": ((context) => const PlantRegisterScreen()),
      //   "/main": (context) => const HomeScreen(),
      //   "/listViewItem": (context) => const ListViewItem(),
      //   "/EditProfile": (context) => const EditProfile()
      //PlantLayoutScreen
      /**
       * SettingsScreen
       * ConfirmPasswordScreen
       * 
       */
      // },
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'SFdisplay',
      ),
    );
  }
}
