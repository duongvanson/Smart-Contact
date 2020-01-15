import 'package:fa_smart_contact/commons/Strings.dart';
import 'package:fa_smart_contact/pages/ContactPage.dart';
import 'package:fa_smart_contact/pages/FavouritePage.dart';
import 'package:fa_smart_contact/pages/PersonalPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabSelect = 0;
  String _title = StringApp.app_title;
  final List<Widget> _listTab = <Widget>[
    ContactPage(),
    FavouritePage(),
    PersonalPage()
  ];
  final List<String> _listTitle = <String>[
    StringApp.tab_contact,
    StringApp.tab_favourite,
    StringApp.tab_personal
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
      ),
      body: _listTab.elementAt(_tabSelect),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), title: Text(StringApp.tab_contact)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text(StringApp.tab_favourite)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text(StringApp.tab_personal)),
        ],
        currentIndex: _tabSelect,
        selectedItemColor: Colors.green,
        onTap: _onSelectTap,
        selectedIconTheme: IconThemeData(
          size: 28,
          color: Colors.green[600]
        ),
      ),
    );
  }

  void _onSelectTap(int index) {
    setState(() {
      _tabSelect = index;
      _title = _listTitle.elementAt(index);
    });
  }
}
