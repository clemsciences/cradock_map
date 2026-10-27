import "package:cradock_map/notifiers/multi_notifier.dart";
import "package:cradock_map/routes/routes.dart";
import "package:cradock_map/style/themes.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_web_plugins/url_strategy.dart";

void main() {
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  runApp(const MyApp());
  if (kIsWeb) {
    // On the web, Flutter only builds the accessibility tree once a screen
    // reader user finds its hidden button: built from the start instead, so
    // that the site is readable with a screen reader and the keyboard.
    SemanticsBinding.instance.ensureSemantics();
  }
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
        locale: const Locale("fr"),
        supportedLocales: const [Locale("fr")],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        routerConfig: router,
      ),
    );
  }
}
