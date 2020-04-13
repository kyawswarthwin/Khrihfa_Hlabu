import 'dart:convert';

import 'package:app/model/song.dart';
import 'package:app/util/customicon.dart';
import 'package:app/util/playstate.dart';
import 'package:app/view/fancyfab.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import '../../controller/controller.dart';
import 'package:provider/provider.dart';

class SecondDetail extends StatefulWidget {
  final int id;
  final String title;
  final int bookmark;
  const SecondDetail({Key key, this.id, this.title, this.bookmark})
      : super(key: key);

  @override
  _SecondDetailState createState() => _SecondDetailState();
}

class _SecondDetailState extends State<SecondDetail> {
  var jsonSong = '[{"song1":"https://luan.xyz/files/audio/nasa_on_a_mission.mp3"},{"song1":"https://luan.xyz/files/audio/nasa_on_a_mission.mp3","song2":"https://luan.xyz/files/audio/nasa_on_a_mission.mp3"}]';
  List songs  = List<Song>();
  double fontSize = 10.0;
  String _text;
  AudioPlayer audioPlayer;
  PlayerState _playerState = PlayerState.stopped;
  get _isPlaying => _playerState == PlayerState.playing;
  @override
  void initState() {
    super.initState();
    Control().getShare();
    getText();
    audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    getSong();
  }
getSong(){
  var datas = json.decode(jsonSong);
        songs = datas.map((data) => Song.fromJson(data)).toList();
}
  Future<int> _play() async {
    final result = await audioPlayer.play(songs[0].song1);
    if (result == 1) setState(() => _playerState = PlayerState.playing);
    return result;
  }

  Future<int> _pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
    return result;
  }
  getText() async {
    String text = await rootBundle
        .loadString('assets/database/responsive/${widget.id}.html');
    setState(() {
      _text = text;
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
//         FirebaseAdMob.instance.initialize(appId: "ca-app-pub-8032453967263891~1572959323").then((response){
// myBanner..load()..show();
//     });
    final bm = Provider.of<Control>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.id}"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Container(
                width: 35.0,
                child: IconButton(
                  icon: Theme.of(context).brightness == Brightness.light
                      ? Icon(Icons.brightness_2)
                      : Icon(Icons.wb_sunny),
                  onPressed: () {
                    DynamicTheme.of(context).setBrightness(
                        Theme.of(context).brightness == Brightness.light
                            ? Brightness.dark
                            : Brightness.light);
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Container(
                width: 35.0,
                child: IconButton(
                  icon: Icon(MyFlutterApp.format_font_size_increase),
                  onPressed: () {
                    setState(() {
                      fontSize++;
                    });
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Container(
                width: 35.0,
                child: IconButton(
                  icon: Icon(MyFlutterApp.format_font_size_decrease),
                  onPressed: () {
                    setState(() {
                      fontSize--;
                    });
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
                width: 35.0,
                child: IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: () {
                    Control().secondBookMark(
                        widget.id, widget.title, widget.bookmark);
                  },
                  color: bm.secondBookmark.contains(widget.id.toString()) ?  Colors.greenAccent : Theme.of(context).appBarTheme.color ,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Html(
              data: _text,
              customTextAlign: (dom.Node node) {
                if (node is dom.Element) {
                  switch (node.localName) {
                    case "h4":
                      return TextAlign.center;
                  }
                }
                return null;
              },
              customTextStyle: (dom.Node node, TextStyle baseStyle) {
                if (node is dom.Element) {
                  switch (node.localName) {
                    case "h4":
                      return baseStyle.merge(
                        TextStyle(
                            fontSize: fontSize + 3,
                            fontWeight: FontWeight.bold,
                            height: 1.0),
                      );

                    case "b":
                      return baseStyle.merge(TextStyle(
                          fontSize: fontSize, fontWeight: FontWeight.bold));

                    case "p":
                      return baseStyle.merge(TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w400,
                          height: 1.2));
                  }
                }

                return baseStyle;
              },
            ),
          ),
        ),
      ),
      floatingActionButton:songs[0].song2 != null ? FancyFab(song :songs[1] ) : FloatingActionButton(
        onPressed: () {
          // audioPlayer.stop();
        },
        child: IconButton(
          icon: _isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
          onPressed: _isPlaying ? () => _pause() : () => _play(),
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

// BannerAd myBanner = BannerAd(
//   adUnitId: BannerAd.testAdUnitId,
//   size: AdSize.smartBanner,
//   targetingInfo: targetingInfo,
//   listener: (MobileAdEvent event) {
//     print("BannerAd event is $event");
//   },
// );