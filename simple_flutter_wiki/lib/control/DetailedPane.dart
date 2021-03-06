import 'package:flutter/material.dart';
import 'package:simple_flutter_wiki/model/FlutterPage.dart';

class DetailedPane extends StatelessWidget {
  List<int> top = [];
  List<int> bottom = [0];

  final FlutterPage page;
  DetailedPane({this.page});
  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
          child: LinearProgressIndicator(
              backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
              value: 50,
              valueColor: AlwaysStoppedAnimation(Colors.green))),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        Icon(Icons.directions_car, color: Colors.white, size: 40.0),
        Container(width: 90.0, child: new Divider(color: Colors.green)),
        SizedBox(height: 10.0),
        Text(page.title, style: TextStyle(color: Colors.white, fontSize: 45.0)),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      page.title,
                      style: TextStyle(color: Colors.white),
                    )))
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            decoration: new BoxDecoration()),
        Container(
            padding: EdgeInsets.all(40.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
            child: Center(child: topContentText)),
        Positioned(
            left: 8.0,
            top: 60.0,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.white)))
      ],
    );

    final bottomContent = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    topContent,
                    Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.all(20),
                        child: Text(page.content,
                            style: TextStyle(fontSize: 18.0)))
                  ])));
    });

    return Scaffold(
      body: bottomContent,
    );
  }
}
