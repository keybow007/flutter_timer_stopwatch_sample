import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:soundeffectivedlsample/main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String _displayTimeText = "";
  bool _isMeasuring = false;

  int _timeElasped = 0;
  final format = DateFormat.ms();
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    _isMeasuring = false;
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: _isMeasuring ? Icon(Icons.stop) : Icon(Icons.play_arrow),
          onPressed: _isMeasuring ? () => stop() : () => start(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_displayTimeText),
              SizedBox(
                height: 16.0,
              ),
              //点滅ボタン
              //https://stackoverflow.com/questions/51733044/flutter-blinking-button
              //https://dartpad.dev/54abca9c0ab8388be5ae42cc5d1ed9c5
              _isMeasuring
                  ? FadeTransition(
                      opacity: _animationController,
                      child: FaIcon(FontAwesomeIcons.thumbsUp),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  stop() {
    setState(() {
      _animationController.stop();
      _isMeasuring = false;
    });
  }

  start() {
    _timeElasped = 0;
    //setStateはこの配置でないと思った通りの動きにならない
    setState(() {
      Timer.periodic(Duration(seconds: 1), (timer){
        if (!_isMeasuring){
          timer.cancel();
        } else {
          _timeElasped += 1;
          setState(() {
            _displayTimeText = _convert(_timeElasped);
          });
          print("_displayTime: $_displayTimeText");
        }
      });
      _animationController.repeat();
      _isMeasuring = true;
    });
  }

  String _convert(int timeElasped) {
    //「~/」は商を求める演算子
    final int minutes = timeElasped ~/ 60;
    final int seconds = timeElasped - (minutes * 60);

    var secondString = "";
    if (seconds < 10) {
      secondString = "0" + seconds.toString();
    } else {
      secondString = seconds.toString();
    }

    return "$minutes : $secondString";

  }


}
