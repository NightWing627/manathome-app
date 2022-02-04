import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:video_player/video_player.dart';

class AnimatedScreen extends StatefulWidget {
  bool isFirst;
  AnimatedScreen({this.isFirst = true, Key key}) : super(key: key);

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  VideoPlayerController _controller;
  bool _isPlaying = false;
  bool isFirstLoad = false;
  Duration _duration;
  Duration _position;
  bool _isEnd = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/video/Bubble.mp4")
      ..addListener(() async {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying && _isEnd) {
          if (mounted)
            setState(() {
              _isPlaying = isPlaying;
              _controller.dispose();
            });
        }

        _position = _controller.value.position;

        _duration = _controller.value.duration;

        _duration?.compareTo(_position) == 0 ||
                _duration?.compareTo(_position) == -1
            ? this.setState(() {
                _isEnd = true;
              })
            : this.setState(() {
                _isEnd = false;
              });
      })
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(false);
        // Ensure the first frame is shown after the video is initialized.
        if (mounted) setState(() {});
      });
    try {
      print('loader');

      if (currentUser.value.auth != false && currentUser.value.auth != null) {
        if (currentUser.value.latitude != 0.0 &&
            currentUser.value.longitude != 0.0) {
          if (mounted)
            setState(() {
              isFirstLoad = true;
            });
          //Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);

          // Navigator.of(context).pushReplacementNamed('/tutorialscreen');
        } else {
          if (mounted)
            setState(() {
              isFirstLoad = false;
            });
        }
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.height ?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimatedOpacity(
                opacity: !_controller.value.isPlaying ? 1 : 0,
                duration: Duration(milliseconds: 200),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange[800])),
                  onPressed: () {
                    if (!isFirstLoad) {
                      Navigator.pushNamed(context, '/tutorialscreen');
                      _controller.dispose();
                    } else {
                      Navigator.pushNamed(context, '/location');
                      _controller.dispose();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      'AVANTI',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
