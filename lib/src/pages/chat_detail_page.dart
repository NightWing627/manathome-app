import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:keyboard_actions/external/keyboard_avoider/keyboard_avoider.dart';
import 'package:multisuperstore/src/components/chat_detail_page_appbar.dart';
import 'package:multisuperstore/src/controllers/vendor_controller.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import '../components/chat_bubble.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

enum MessageType {
  Sender,
  Receiver,
}
// ignore: must_be_immutable
class ChatDetailPage extends StatefulWidget {
  ChatDetailPage({Key key, this.shopId, this.shopName, this.shopMobile});
  String shopId;
  String shopName;
  String shopMobile;
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends StateMVC<ChatDetailPage> {
  VendorController _con;
  _ChatDetailPageState() : super(VendorController()) {
    _con = controller;
  }

  final _txtController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // AudioPlayer advancedPlayer;
  // AudioCache audioCache;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
    Timer(Duration(milliseconds: 300), () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
  }

  void initPlayer() {
    // advancedPlayer = new AudioPlayer();
    // audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    /**advancedPlayer.durationHandler = (d) => setState(() {
        _duration = d;
        });

        advancedPlayer.positionHandler = (p) => setState(() {
        _position = p;
        }); */
  }

  final player = AudioPlayer();
  Future loadMusic() async {

    await player.setAsset('assets/audio/chatsend.mp3');
    await player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatDetailPageAppBar(shopId: widget.shopId, shopName: widget.shopName, shopMobile: widget.shopMobile),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatList")
                    .where("userId", isEqualTo: currentUser.value.id)
                    .where("shopId", isEqualTo: widget.shopId)
                    .snapshots(),
                builder: (context, snapshot) {
                  // print('chat count${snapshot.data.docs.length}');
                  Timer(Duration(milliseconds: 300), () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
                  if (snapshot.hasError || snapshot.data == null) {
                    return Container();
                  } else {
                    return KeyboardAvoider(
                      autoScroll: true,
                      child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        controller: _scrollController,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {

                          return ChatBubble(
                            chatMessage: snapshot.data.docs[index],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 8, bottom: 10),
              height: 80,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextField(
                        controller: _txtController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          hintText: 'Type a message',
                          contentPadding: EdgeInsets.all(16.0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.only(right: 5, bottom: 9, top: 9),
                      child: FloatingActionButton(
                        onPressed: () async {
                          await _con.sendChat(
                              _txtController, currentUser.value.id, widget.shopId, widget.shopMobile, widget.shopName);

                          setState(() {
                            _txtController.text = '';
                          });
                          loadMusic();
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.pink,
                        elevation: 0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
