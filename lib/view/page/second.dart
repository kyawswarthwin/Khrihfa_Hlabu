import 'package:app/controller/controller.dart';
import 'package:app/view/tab/secondtab1.dart';
import 'package:app/view/tab/secondtab2.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../util/draweselection.dart';

class Second extends StatefulWidget {
  final DrawerSelection drawerSelection;
  const Second({Key key, this.drawerSelection}) : super(key: key);
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
@override
  void dispose() {
    super.dispose();
    // second.dispose();
  }
  @override
  Widget build(BuildContext context) {
//  FirebaseAdMob.instance.initialize(appId: "ca-app-pub-8032453967263891~1572959323").then((response){
// second..load()..show(
//     anchorType: AnchorType.bottom,
//     anchorOffset: 0.0,
//     horizontalCenterOffset: 0.0,);
//     });
    return Scaffold(
      body: new TabBarView(
        controller: Control().controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[SecondTab1(), SecondTab2()],
      ),
    );
  }
}
// MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//   keywords: <String>['flutterio', 'beautiful apps'],
//   contentUrl: 'https://flutter.io',
//   // birthday: DateTime.now(),
//   childDirected: false,
//   // designedForFamilies: false,
//   // gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
//   testDevices: <String>[], // Android emulators are considered test devices
// );

// InterstitialAd second = InterstitialAd(
//   adUnitId: "ca-app-pub-8032453967263891/5145017606",
//   targetingInfo: targetingInfo,
//   listener: (MobileAdEvent event) {
//     print("InterstitialAd event is $event");
//   },
// );