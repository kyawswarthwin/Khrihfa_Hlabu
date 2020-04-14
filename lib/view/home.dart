import 'dart:io';

import 'package:app/util/draweselection.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'defaultappbar.dart';
import 'page/about.dart';
import 'page/first.dart';
import 'page/second.dart';
import 'page/third.dart';
import '../controller/controller.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>with SingleTickerProviderStateMixin {
  DrawerSelection _drawerSelection = DrawerSelection.first;
  String appBarTitle = "Khrihfa Hlabu";
  Widget currentPage;
  InterstitialAd _interstitialAd;
  @override
  void initState() {
    super.initState();
    Control().controller = TabController(length: 2, vsync: this);
    Control().controller.addListener((){
      setState(() {      
      });
    });
    currentPage = First();
    setState(() {
      Control().createListfirst();
      Control().createListsecond();
      Control().getShare();
    });
    Control().firstShowdata = Control().firstItemList;
    Control().secondShowData = Control().secondItemList;
      FirebaseAdMob.instance.initialize(appId: getAppId());
    _interstitialAd = createInterstitialAd()..load();
  }
  @override
  void dispose() {
    super.dispose();
    Control().controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        appBar: DefaultAppBar(
          title: appBarTitle,
          drawerSelection: _drawerSelection,
        ),
        body: currentPage,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: null,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/menu-background.png"),
                        fit: BoxFit.cover)),
              ),
              Container(
                height: 45,
                child: FlatButton(
                  color: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.first
                          ? Colors.black12
                          : Colors.transparent
                      : _drawerSelection == DrawerSelection.first
                          ? Colors.white
                          : Colors.transparent,
                  colorBrightness: Brightness.light,
                  onPressed: () {
                    _interstitialAd?.dispose();
                    _interstitialAd ??= createInterstitialAd();
                    _interstitialAd..load()..show();
                    currentPage = First();
                    Navigator.pop(context);
                    Control().getDrawerSelection(DrawerSelection.first);
                    _drawerSelection = DrawerSelection.first;
                    Control().controller.animateTo(0);
                    setState(() {
                      appBarTitle = "Khrihfa Hlabu";
                     
                    });
                  },
                  child: Center(
                    child: ListTile(
                      leading: Text(
                        "Khrihfa Hlabu",
                          style: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.first
                          ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.black)
                      : _drawerSelection == DrawerSelection.first
                            ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.white),
                      ),
                      selected: _drawerSelection == DrawerSelection.first,
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                child: FlatButton(
                  color: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.second
                          ? Colors.black12
                          : Colors.transparent
                      : _drawerSelection == DrawerSelection.second
                          ? Colors.white
                          : Colors.transparent,
                  onPressed: () {
                    _interstitialAd?.dispose();
                    _interstitialAd ??= createInterstitialAd();
                    _interstitialAd..load()..show();
                    currentPage = Second();
                    Navigator.pop(context);
                    _drawerSelection = DrawerSelection.second;
                    Control().getDrawerSelection(DrawerSelection.second);
                     Control().controller.animateTo(0);
                    setState(() {
                  
                      appBarTitle = "Chawnghlang Relnak";
                      
                    });
                  },
                  child: Center(
                    child: ListTile(
                      leading: Text(
                        "Chawnghlang Relnak",
                          style: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.second
                          ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.black)
                      : _drawerSelection == DrawerSelection.second
                            ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.white),
                      ),
                      selected: _drawerSelection == DrawerSelection.second,
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                child: FlatButton(
                  color: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.third
                          ? Colors.black12
                          : Colors.transparent
                      : _drawerSelection == DrawerSelection.third
                          ? Colors.white
                          : Colors.transparent,
                  onPressed: () {
                    _interstitialAd?.dispose();
                    _interstitialAd ??= createInterstitialAd();
                    _interstitialAd..load()..show();
                    currentPage = Third();
                    Navigator.pop(context);
                    _drawerSelection = DrawerSelection.third;
                    setState(() {
                      appBarTitle = "Daily Bible Chin";
                    });
                  },
                  child: Center(
                    child: ListTile(
                      leading: Text(
                        "Daily Bible Chin",
                         style: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.third
                          ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.black)
                      : _drawerSelection == DrawerSelection.third
                            ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.white),
                      ),
                      selected: _drawerSelection == DrawerSelection.third,
                    ),
                  ),
                ),
              ),
              Container(
                height: 45,
                child: FlatButton(
                  color: Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.about
                          ? Colors.black12
                          : Colors.transparent
                      : _drawerSelection == DrawerSelection.about
                          ? Colors.white
                          : Colors.transparent,
                  onPressed: () {
                    _interstitialAd?.dispose();
                    _interstitialAd ??= createInterstitialAd();
                    _interstitialAd..load()..show();
                    currentPage = About();
                    Navigator.pop(context);
                    _drawerSelection = DrawerSelection.about;
                    setState(() {
                      appBarTitle = "About";
                    });
                  },
                  child: Center(
                    child: ListTile(
                      leading: Text(
                        "About",
                        style:  Theme.of(context).brightness == Brightness.light
                      ? _drawerSelection == DrawerSelection.about
                          ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.black)
                      : _drawerSelection == DrawerSelection.about
                            ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.white),
                      ),
                      selected: _drawerSelection == DrawerSelection.about,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
String getAppId() {
  if (Platform.isIOS) {
    return "ca-app-pub-8032453967263891~9118748177";
  } else if (Platform.isAndroid) {
    return "ca-app-pub-8032453967263891~1572959323";
  }
  return null;
}

String getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return "ca-app-pub-8032453967263891/5179503167";
  } else if (Platform.isAndroid) {
    return "ca-app-pub-8032453967263891/5145017606";
  }
  return null;
}

InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: getInterstitialAdUnitId(),
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }
MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  // birthday: DateTime.now(),
  childDirected: false,
  // designedForFamilies: false,
  // gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);
