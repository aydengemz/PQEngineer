import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StaticListTemplate extends StatelessWidget {
  final List<String> titles;
  final List<IconData> icons;
  final List<Widget> pages;

  StaticListTemplate(
      {@required this.titles, @required this.icons, @required this.pages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Card(
          //                           <-- Card widget
          child: ListTile(
              leading: Icon(icons[index]),
              title: Text(titles[index]),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                print('touched');
                //LayoutPage.show(context);
                Navigator.of(context).push(CupertinoPageRoute(
                  fullscreenDialog: false,
                  builder: (context) => pages[index],
                ));
              }),
        );
      },
    );
  }
}

//* static ListView
/*     return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.wb_sunny),
          title: Text('Sun'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.brightness_3),
          title: Text('Mon'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text('Tues'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ],
    ); */
