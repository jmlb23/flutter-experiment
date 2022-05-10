import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineDetailState();
}

class LineDetailState extends State<LineDetail> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.access_time_filled_sharp)),
                Tab(icon: Icon(Icons.list_alt)),
                Tab(icon: Icon(Icons.notifications)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      );
}
