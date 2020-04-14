import 'package:app/model/song.dart';
import 'package:app/util/playstate.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FancyFab extends StatefulWidget {
  final Song song;

  const FancyFab({Key key, this.song}) : super(key: key);
  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  // Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  AudioPlayer audioPlayer;
  PlayerState _playerState1 = PlayerState.stopped;
  PlayerState _playerState2 = PlayerState.stopped;
  get _isPlaying1 => _playerState1 == PlayerState.playing;
  get _isPlaying2 => _playerState2 == PlayerState.playing;

  Future<int> _play(String url) async {
    final result = await audioPlayer.play(url);
    if (result == 1) setState(() => _playerState1 = PlayerState.playing);
    return result;
  }

  Future<int> _pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) setState(() => _playerState1 = PlayerState.paused);
    return result;
  }

  Future<int> _play2(String url) async {
    final result = await audioPlayer.play(url);
    if (result == 1) setState(() => _playerState2 = PlayerState.playing);
    return result;
  }

  Future<int> _pause2() async {
    final result = await audioPlayer.pause();
    if (result == 1) setState(() => _playerState2 = PlayerState.paused);
    return result;
  }

  @override
  initState() {
    audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  animate() {
   
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget song1() {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {},
        child: IconButton(
          icon: _isPlaying1 ? Icon(Icons.pause) : Icon(Icons.play_arrow),
          onPressed: _isPlaying2
              ? () {}
              : _isPlaying1 ? () => _pause() : () => _play(widget.song.song1),
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

  Widget song2() {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {},
        child: IconButton(
          icon: _isPlaying2 ? Icon(Icons.pause) : Icon(Icons.play_arrow),
          onPressed: _isPlaying1
              ? () {}
              : _isPlaying2 ? () => _pause2() : () => _play2(widget.song.song2),
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

  Widget toggle() {
    return Container(
      child: FloatingActionButton(

        heroTag: null,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white,
        onPressed: animate,
        // tooltip: 'Toggle',
        child: AnimatedIcon(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: song1(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: song2(),
        ),
        toggle(),
      ],
    );
  }
}
