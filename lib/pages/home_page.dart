import 'package:fa_smart_contact/commons/colors.dart';
import 'package:fa_smart_contact/commons/strings.dart';
import 'package:fa_smart_contact/pages/add_contact_page.dart';
import 'package:fa_smart_contact/pages/contact_page.dart';
import 'package:fa_smart_contact/pages/favourite_page.dart';
import 'package:fa_smart_contact/pages/personal_page.dart';
import 'package:fa_smart_contact/pages/scan_qr_code_page.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as Scanner;

class HomePage extends StatefulWidget {
  int tabSlect = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      setState(() {
        widget.tabSlect = tabController.index;
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  final _keySoaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _keySoaffold,
        appBar: AppBar(
          actions: <Widget>[
            widget.tabSlect == 0
                ? IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddContactPage(
                                    person: false,
                                  )));
                    })
                : Text(""),
            widget.tabSlect == 0
                ? IconButton(
                    icon: Icon(Icons.scanner),
                    onPressed: () {
                      _scanQR();
                    })
                : Text(""),
          ],
          title: Text(StringApp.app_title),
          bottom: TabBar(
            controller: tabController,
            tabs: <Widget>[
              Tab(
                child: Text(StringApp.tab_contact),
                //child: Icon(Icons.people),
              ),
              Tab(
                child: Text(StringApp.tab_favourite),
                //child: Icon(Icons.favorite),
              ),
              Tab(
                child: Text(StringApp.tab_personal),
                // child: Icon(Icons.person),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[ContactPage(), FavouritePage(), PersonalPage()],
        ),
      ),
    );
  }

  Future _scanQR() async {
    try {
      String data = await Scanner.scan();
      _keySoaffold.currentState.showSnackBar(SnackBar(content: Text(data)));
      print(data);
    } catch (ex) {
      print(ex);
    }
  }
}
