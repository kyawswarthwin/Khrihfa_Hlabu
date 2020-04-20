import 'dart:convert';

import 'package:app/controller/controller.dart';
import 'package:app/model/song.dart';
import 'package:app/util/playstate.dart';
import '../../controller/adControl.dart';
import '../../controller/normalSong.dart';
import '../../controller/multiSong.dart';
import 'package:app/util/customicon.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:provider/provider.dart';
import '../fancyfab.dart';

class FirstDetail extends StatefulWidget {
  final int id;
  final String title;
  final int bookmark;
  const FirstDetail({Key key, this.id, this.title, this.bookmark})
      : super(key: key);
  @override
  _FirstDetailState createState() => _FirstDetailState();
}

class _FirstDetailState extends State<FirstDetail> {
  final adControl = AdControl();
  final normalSong = NormalSong();
  final multiSong = MultiSong();
  double fontSize = 11.0;
  String _text;
  BannerAd _bannerAd;
   List songList = List<Song>();
   var jsonSong =
      '[{"song1":"https://luan.xyz/files/audio/nasa_on_a_mission.mp3"},{"song1":"https://luan.xyz/files/audio/nasa_on_a_mission.mp3","song2":"https://luan.xyz/files/audio/nasa_on_a_mission.mp3"}]';

  void getText() async {
    String text =
        await rootBundle.loadString('assets/database/hymns/${widget.id}.html');
    setState(() {
      _text = text;
    });
  }
    getSong() {
    var datas = json.decode(jsonSong);
    songList = datas.map((data) => Song.fromJson(data)).toList();
  }
    



  @override
  void initState() {
    super.initState();
    Control().getShare();
    getText();
    normalSong.audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    multiSong.audioPlayer1 = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    multiSong.audioPlayer2 = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    getSong();
     _bannerAd = adControl.createBannerAdUnitId()..load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  normalSong.playerState = PlayerState.stopped;
      normalSong.audioPlayer.stop();
       multiSong.playerState1 = PlayerState.stopped;
       multiSong.playerState2 = PlayerState.stopped;
      multiSong.audioPlayer1.stop();
      multiSong.audioPlayer2.stop();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: adControl.getAppId()).then((response){
_bannerAd..load()..show(anchorOffset: 80.0,anchorType: AnchorType.top);
    });
    final bm = Provider.of<Control>(context);
    final normal = Provider.of<NormalSong>(context);
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
                    Control().firstBookMark(
                        widget.id, widget.title, widget.bookmark);
                  },
                  color: bm.firstBookmark.contains(widget.id.toString())
                      ? Colors.greenAccent
                      : Theme.of(context).appBarTheme.color,
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
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.red
                            : Colors.purple,
                      ));

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
      floatingActionButton: songList[1].song2 != null
          ? FancyFab(song:songList[1])
          : FloatingActionButton(
              onPressed: () {
              },
              child: IconButton(
                icon: normal.isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                onPressed: normal.isPlaying ? () => normal.pause() : () =>normal.play(songList[0].song1),
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.black,
              ),
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
    );
  }
}


