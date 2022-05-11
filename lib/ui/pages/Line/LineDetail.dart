import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:maisbugs/data/remote/LineDetailItem.dart';
import 'package:maisbugs/ui/pages/Line/LineDetailViewModel.dart';
import 'package:markdown/markdown.dart' as Md;

class LineDetail extends StatefulWidget {
  final int? _id;

  LineDetail(this._id);

  @override
  State<StatefulWidget> createState() => LineDetailState(_id);
}

class LineDetailState extends State<LineDetail> {
  int? _idLinea = null;
  LineDetailViewModel _viewModel = LineDetailViewModel();

  LineDetailState(this._idLinea);

  @override
  void initState() {
    super.initState();
    _viewModel.load(_idLinea ?? 0);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
            stream: _viewModel.stream,
            builder: (context, snapshot) {
              var data = snapshot.data as LineDetailItem?;
              return DefaultTabController(
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
                  body: TabBarView(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: SingleChildScrollView(
                              child: HtmlWidget(
                                  Md.markdownToHtml(data?.informacion ?? "")))),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: LineDirections(data?.trayectos ?? [])),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: SingleChildScrollView(
                              child: HtmlWidget(Md.markdownToHtml(data
                                      ?.incidencias
                                      .map((e) => e.descripcion)
                                      .join("\n") ??
                                  "")))),
                    ],
                  ),
                ),
              );
            }),
      );
}

class LineDirections extends StatelessWidget {
  final List<TrayectoDetailItem> _elements;

  LineDirections(this._elements);

  @override
  Widget build(BuildContext context) => Container(
          child: ListView.builder(
        itemCount: _elements.length,
        itemBuilder: ((context, index) => ExpansionTile(
              controlAffinity: ListTileControlAffinity.leading,
              trailing: SizedBox.shrink(),
              leading: SizedBox.shrink(),
              tilePadding: EdgeInsets.zero,
              title: Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        child: Text(_elements[index].nombre ?? "",
                            style: Theme.of(context).textTheme.headline5),
                        padding: EdgeInsets.all(10),
                      ),
                      Padding(
                        child: Text(_elements[index].sentido ?? "",
                            style: Theme.of(context).textTheme.subtitle1),
                        padding: EdgeInsets.all(10),
                      )
                    ],
                  ),
                ),
              ),
              children: _elements[index]
                  .paradas
                  .map((e) => Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        e.nombre ?? "",
                        style: Theme.of(context).textTheme.bodySmall,
                      )))
                  .toList(),
            )),
      ));
}
