import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: must_be_immutable
class ChatBubble extends StatefulWidget {
  dynamic chatMessage;
  ChatBubble({@required this.chatMessage});
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
  final f = new DateFormat('dd-mm-yyyy hh:mm');
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Align(
          alignment: (widget.chatMessage['transferType'] == 'Shop' ? Alignment.topLeft : Alignment.topRight),
          child: Column( crossAxisAlignment: widget.chatMessage['transferType'] == 'Shop'? CrossAxisAlignment.start:CrossAxisAlignment.end, children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: (widget.chatMessage['transferType'] == 'Shop' ? Theme.of(context).primaryColor : Theme.of(context).primaryColor),
              ),
              padding: EdgeInsets.all(16),
              child: Text(widget.chatMessage['message']),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: RichText(
                text: new TextSpan(
                  text: widget.f.format(new DateTime.fromMillisecondsSinceEpoch(widget.chatMessage['timestamp'])),
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
          ]),
        ));
  }
}
