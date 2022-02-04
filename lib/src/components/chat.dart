
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multisuperstore/src/pages/chat_detail_page.dart';
// ignore: must_be_immutable
class ChatUsersList extends StatefulWidget {
  String shopName;
  String lastChat;
  String image;
  String shopId;
  int time;
  bool isMessageRead;
  String mobile;
  String read;
  ChatUsersList(
      {@required this.shopName,
        @required this.lastChat,
        this.mobile,
        @required this.image,
        @required this.time,
        this.shopId,
        this.read,
        @required this.isMessageRead});
  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatDetailPage(shopId: widget.shopId, shopName: widget.shopName, shopMobile: widget.mobile)));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.image),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.shopName),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.lastChat,
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              calculateTime(widget.time),
              style: TextStyle(fontSize: 12, color: widget.isMessageRead ? Colors.pink : Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  calculateTime(dateString, {bool numericDates = true}) {
    final f = new DateFormat('dd-MM-yyyy h:mma');
    final chatTime = f.format(new DateTime.fromMicrosecondsSinceEpoch(dateString * 1000));
    DateTime notificationDate = DateFormat("dd-MM-yyyy h:mma").parse(chatTime);

    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
