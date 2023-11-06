import 'package:bookbox/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final appRouter = AppRouter();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (_, __) {
          return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: "bookbox",
              routerConfig: appRouter.config(),
              theme: ThemeData(
                  useMaterial3: true,
                  primaryTextTheme: Typography.blackCupertino,
                  textTheme: Typography.blackCupertino,
                  elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          shape: const RoundedRectangleBorder(),
                          textStyle: TextStyle(
                              fontSize: 16.spMin, color: Colors.black87))),
                  textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          shape: const RoundedRectangleBorder(),
                          textStyle: TextStyle(
                              fontSize: 16.spMin, color: Colors.black87)))));
        });
  }
}
