import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tryve/routes/routes.dart';
import 'package:tryve/screens/loading/loading_screen.dart';
import 'package:tryve/services/auth/auth_service.dart';
import 'package:tryve/services/db/init_db.dart';
import 'package:tryve/theme/palette.dart';
import 'package:tryve/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initHive(() {
    SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
        .then((_) {
      runApp(MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (context) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
              create: (context) =>
                  context.read<AuthenticationService>().authStateChanges)
        ],
        child: MyApp(),
      ));
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tryve',
      theme: globalTheme,
      routes: routes,
      initialRoute: LoadingScreen.routeName,
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET, scaleFactor: 1.2),
            ResponsiveBreakpoint.autoScale(1000,
                name: TABLET, scaleFactor: 1.4),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP, scaleFactor: 1.6),
          ],
          background: Container(color: Palette.background)),
    );
  }
}
