import 'package:flutter/material.dart';
import 'package:flutter_todolist/page/TodoPage.dart';
import 'package:flutter_todolist/page/PestoDemo.dart';
import 'package:flutter_todolist/LoginPage.dart';
import 'package:flutter_todolist/view/NavigationIconView.dart';

void main() {
//  runApp(new MyApp());
  runApp(new LoginPage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '待办清单',
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;
  List<Widget> pages;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;

  @override
  void initState() {
    super.initState();
    pages = [new TodoPage(), new PestoDemo(), new TodoPage(), new PestoDemo()];
    _navigationViews = <NavigationIconView>[
      NavigationIconView(
        icon: const Icon(Icons.access_alarm),
        title: 'Alarm',
        color: Colors.deepPurple,
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: const Icon(Icons.cloud),
        icon: const Icon(Icons.cloud_queue),
        title: 'Cloud',
        color: Colors.teal,
        vsync: this,
      ),
      NavigationIconView(
        activeIcon: const Icon(Icons.favorite),
        icon: const Icon(Icons.favorite_border),
        title: 'Favorites',
        color: Colors.indigo,
        vsync: this,
      ),
      NavigationIconView(
        icon: const Icon(Icons.event_available),
        title: 'Event',
        color: Colors.pink,
        vsync: this,
      )
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  @override
  Widget build(BuildContext context) {
    // 底部导航栏
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: _navigationViews
          .map<BottomNavigationBarItem>(
              (NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
//          _navigationViews[_currentIndex].controller.reverse();
//          _currentIndex = index;
//          _navigationViews[_currentIndex].controller.forward();
          _currentIndex = index;
        });
      },
    );
    return new Scaffold(
      appBar: _homeAppBar(),
      body: new Center(
        child: _buildTransitionsStack(),
      ),
      bottomNavigationBar: botNavBar,
      floatingActionButton: _floatingActionButton(),
    );
  }

  // 内容显示按钮
  Widget _buildTransitionsStack() {
//    final List<FadeTransition> transitions = <FadeTransition>[];
//
//    for (NavigationIconView view in _navigationViews)
//      transitions.add(view.transition(_type, context));
//
//    // We want to have the newly animating (fading in) views on top.
//    transitions.sort((FadeTransition a, FadeTransition b) {
//      final Animation<double> aAnimation = a.opacity;
//      final Animation<double> bAnimation = b.opacity;
//      final double aValue = aAnimation.value;
//      final double bValue = bAnimation.value;
//      return aValue.compareTo(bValue);
//    });

    return IndexedStack(
      children: <Widget>[
        new TodoPage(),
        new PestoDemo(),
        new TodoPage(),
        new PestoDemo()
      ],
      index: _currentIndex,
    );
  }

  // 添加按钮
  Widget _floatingActionButton() {
    return new Builder(builder: (BuildContext context) {
      return FloatingActionButton(
        onPressed: () {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('添加一个Todo'),
            action: SnackBarAction(
                label: 'ACTION',
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('You pressed snackbar action.')));
                }),
          ));
        },
        tooltip: '添加',
        child: new Icon(Icons.add),
      );
    });
  }

  Widget _homeAppBar() {
    return new AppBar(
      title: const Text('TODO'),
      actions: <Widget>[
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return <PopupMenuItem>[
              new PopupMenuItem(
                child: new Text('Setting'),
              ),
              new PopupMenuItem(
                child: new Text('Share'),
              ),
            ];
          },
          onSelected: (index) {},
        )

        /// 修改底部导航栏的样式
//        PopupMenuButton<BottomNavigationBarType>(
//          onSelected: (BottomNavigationBarType value) {
//            setState(() {
//              _type = value;
//            });
//          },
//          itemBuilder: (BuildContext context) => <PopupMenuItem<BottomNavigationBarType>>[
//            const PopupMenuItem<BottomNavigationBarType>(
//              value: BottomNavigationBarType.fixed,
//              child: Text('Fixed'),
//            ),
//            const PopupMenuItem<BottomNavigationBarType>(
//              value: BottomNavigationBarType.shifting,
//              child: Text('Shifting'),
//            )
//          ],
//        )
      ],
    );
  }
}
