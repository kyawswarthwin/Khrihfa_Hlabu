import 'package:app/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import '../util/themewhite.dart';
import 'package:splashscreen/splashscreen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Control>(
        create: (_) => Control(),
        child: DynamicTheme(
          defaultBrightness: Brightness.light,
          data: (brightness) => ThemeData(
              primarySwatch: white,
              fontFamily:"Pyidaungsu" ,
              textTheme: TextTheme(
                  display1: TextStyle(color: Colors.black, fontSize: 17),
                  button: TextStyle(
                    color: Colors.black,
                  )),
              brightness: brightness),
          themedWidgetBuilder: (context, theme) {
            return MaterialApp(
              title: "Khrihfa Hlabu",
              theme: theme,
              home: SplashScreen(
                seconds: 1,
                navigateAfterSeconds: new Home(),
                backgroundColor: Colors.blue,
                title: new Text(
                  'Khrihfa Hlabu',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 40.0,color: Colors.white),
                ),
                loaderColor: Colors.transparent,
              ),
            );
          },
        ));
  }
}
