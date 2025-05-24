import "package:cradock_map/notifiers/multi_notifier.dart";
import "package:cradock_map/routes/routes.dart";
import "package:cradock_map/style/style.dart";
import "package:cradock_map/style/themes.dart";
import "package:flutter/material.dart";


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiNotifier(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Le voyage de Mme Cradock en Touraine",
        theme: AppTheme.lightTheme,
        routerConfig: router,
      ),
    );
  }
}
