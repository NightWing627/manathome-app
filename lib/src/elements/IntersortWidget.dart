import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/inter_sort.dart';

// ignore: must_be_immutable
class InterSortWidget extends StatefulWidget {
  List<InterSortView> interSort;
  InterSortWidget({Key key, this.interSort}) : super(key: key);
  @override
  _InterSortWidgetState createState() => _InterSortWidgetState();
}

class _InterSortWidgetState extends State<InterSortWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.interSort.length,
        itemBuilder: (context, index) => DeliverrestaurantListItem(choice: widget.interSort[index]),
      ),
    );
  }
}

class DeliverrestaurantListItem extends StatelessWidget {
  const DeliverrestaurantListItem({Key key, this.choice}) : super(key: key);
  final InterSortView choice;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width / 1.3,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0, right: 10),
                child: Container(
                  width: 45,
                  height: 45,
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(choice.image),
                    radius: 80.0,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child:
                    Container(child: Text(choice.title, overflow: TextOverflow.ellipsis, maxLines: 2, style: Theme.of(context).textTheme.subtitle2)),
              ),
              SizedBox(width: 5),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[300], size: 20),
              SizedBox(width: 5),
              Container(
                height: MediaQuery.of(context).size.height / 12,
                padding: EdgeInsets.only(top: 30, bottom: 30),
                decoration: BoxDecoration(border: Border(right: BorderSide(width: 1, color: Theme.of(context).dividerColor))),
              ),
            ],
          )),
    );
  }
}
