import 'dart:convert';

import 'package:fa_smart_contact/commons/colors.dart';
import 'package:fa_smart_contact/commons/database.dart';
import 'package:fa_smart_contact/commons/strings.dart';
import 'package:fa_smart_contact/models/contact.dart';
import 'package:fa_smart_contact/pages/add_contact.dart';
import 'package:fa_smart_contact/pages/contact.dart';
import 'package:fa_smart_contact/pages/favourite.dart';
import 'package:fa_smart_contact/pages/personal.dart';
import 'package:fa_smart_contact/pages/share_contact.dart';
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
                : Container(),
            widget.tabSlect == 0
                ? IconButton(
                    icon: Icon(Icons.scanner),
                    onPressed: () {
                      _scanQR();
                    })
                : Container(),
            widget.tabSlect == 2
                ? IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () async {
                      Contact person = await DatabaseApp.getPersonContact();
                      if (person == null) {
                        _showNoti("Vui lòng cập nhật hồ sơ của bạn!", 3,
                            ColorApp.main_color);
                        return;
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ShareContactPage(contact: person)));
                    })
                : Container(),
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
      var contact;
      try {
        // print(data);
        contact = Contact.fromJSon(json.decode(data));
      } catch (ex) {
        _showNoti("Mã chia sẻ không hợp lệ!", 3, Colors.red);
        return;
      }
      dynamic result = await DatabaseApp.checkNumberPhone(contact.phone);
      if (result.runtimeType == String) {
        _keySoaffold.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 6),
          backgroundColor: ColorApp.main_color,
          content: Text("${StringApp.number_exits} [$result]"),
          action: SnackBarAction(
            label: StringApp.update,
            onPressed: () async {
              if (await DatabaseApp.updateContactExits(contact)) {
                _showNoti(StringApp.update_ok, 3, ColorApp.main_color);
              } else {
                _showNoti(StringApp.update_fail, 3, Colors.red);
              }
            },
            textColor: Colors.orange,
          ),
        ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddContactPage.fromContact(
                      person: false,
                      contact: contact,
                    )));
      }
    } catch (ex) {
      print("loi $ex");
    }
  }

  void _showNoti(String content, int sec, MaterialColor color) {
    _keySoaffold.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: sec),
        backgroundColor: color,
        content: Text(content)));
  }
}
