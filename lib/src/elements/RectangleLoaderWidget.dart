import 'package:flutter/material.dart';

class RectangleLoaderWidget extends StatelessWidget {
  const RectangleLoaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: 4,
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical:10,horizontal: 20),
          height: 110,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image.asset('assets/img/rectangle_loader.gif', fit: BoxFit.cover),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      },
    );

  }
}
