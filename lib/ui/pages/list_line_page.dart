import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maisbugs/data/remote/Li%C3%B1as.dart';
import 'package:maisbugs/ui/components/components.dart';

class ListLinesPage extends StatelessWidget {
  final title;

  ListLinesPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MaisBugs'),
        ),
        body: StreamBuilder(
            stream: getLinesClient(),
            builder: (ctx, snap) {
              var current = snap.data as List<Line>;
              return ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: current?.length,
                  itemBuilder: (bctx, i) => GestureDetector(
                        onTap: () {

                        },
                        child: RowWidget(current?.elementAt(i)),
                      ));
            }));
  }
}
