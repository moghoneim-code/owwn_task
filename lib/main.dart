import 'package:flutter/material.dart';
import 'package:owwn_coding_challenge/Authentication/Providers/login_provider.dart';
import 'package:owwn_coding_challenge/Authentication/Screens/login_screen.dart';
import 'package:owwn_coding_challenge/MainPage/Providers/main_page_provider.dart';
import 'package:owwn_coding_challenge/MainPage/Screens/main_page_screen.dart';
import 'package:owwn_coding_challenge/UserData/Providers/user_provider.dart';
import 'package:owwn_coding_challenge/UserData/Screens/user_data_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      /// This is the list of providers that will be used in the app
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => MainPageProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'OWWN Coding Challenge',
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        initialRoute: LoginScreen.routeName,
        debugShowCheckedModeBanner: false,
        routes: {
          /// This is the list of routes that will be used in the app
          LoginScreen.routeName: (context) => const LoginScreen(),
          MainPageScreen.routeName: (context) => const MainPageScreen(),
          UserDataScreen.routeName: (context) => const UserDataScreen(),
        },
      ),
    );
  }
}
