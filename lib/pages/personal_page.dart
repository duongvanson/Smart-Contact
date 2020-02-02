import 'package:fa_smart_contact/commons/colors.dart';
import 'package:fa_smart_contact/commons/database.dart';
import 'package:fa_smart_contact/commons/sizes.dart';
import 'package:fa_smart_contact/commons/strings.dart';
import 'package:fa_smart_contact/commons/styles.dart';
import 'package:fa_smart_contact/models/contact.dart';
import 'package:fa_smart_contact/pages/add_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  bool share = false;

  final _paddingCar = 10.0;

  final _marginCar = 10.0;

//  final _styleTitle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  Contact person, temp;

  @override

  @override
  Widget build(BuildContext context) {
    if (share)
      return _layoutShare();
    else
      return Scaffold(
        backgroundColor: Colors.grey[100],
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          //title: Text(StringApp.tab_personal),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: FutureBuilder(
          future: DatabaseApp.getPersonContact(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              person = snapshot.data as Contact;
              temp = person;
              temp.person = 0;
              temp.favourite = 0;
              print(temp.name);
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    // _buildAvatar(context),
                    _layoutInfo(context),
                    _hr(),
                    _layoutInfoDetail(context),
                    _hr(),
                    _layoutSocial(context),
                    MaterialButton(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        StringApp.btn_edit,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: ColorApp.main_color,
                        size: 38,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(StringApp.content_null_person),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.all(10.0),
                      color: ColorApp.main_color,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        StringApp.btn_created_person,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddContactPage(
                                      person: true,
                                    )));
                      },
                    )
                  ],
                ),
              );
            }
          },
        ),
      );
  }

  Widget _layoutInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        onTap: () {
          setState(() {
            share = true;
          });
        },
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 30,
          child: Text(
            person.name.substring(0, 1),
            style: TextStyle(fontSize: 28, color: Colors.teal),
          ),
        ),
        title: Text(
          person.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          person.gusto.isEmpty ? "Nothing...!" : person.gusto,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            QrImage(
              data: temp.toString(),
              size: 40,
              gapless: true,
            ),
            Icon(
              Icons.navigate_next,
              color: Colors.teal,
            )
          ],
        ),
      ),
    );
  }

  Widget _layoutInfoDetail(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_paddingCar),
      width: SizeApp.getSizeByWidth(context: context, percent: 100.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //Title
        children: <Widget>[
          Text(
            StringApp.title_info,
            style: StyleApp.style_title,
          ),
          _lineInfo(context, Icons.date_range, "Ngày sinh",
              person.birthday.toString().split(' ')[0], Colors.blue),
          _lineInfo(
              context,
              Icons.person_outline,
              "Giới tính",
              person.gender == 0 ? "Nam" : person.gender == 1 ? "Nữ" : "Ẩn",
              Colors.indigo),
          _lineInfo(
              context, Icons.home, "Quê quán", person.address, Colors.orange),
          _lineInfo(context, Icons.phone_android, "Di động", person.phone,
              Colors.green),
//            if(person.email.toString().isNotEmpty) _lineInfo(context, Icons.email, "Email", person.email.toString(),
//                Colors.red)
        ],
      ),
    );
  }

  Widget _lineInfo(BuildContext context, IconData icon, String title,
      String content, MaterialColor color) {
    return ListTile(
      title: Text(
        content,
        // style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
//      subtitle: Text(
//        content,
//        style: TextStyle(color: Colors.black, fontSize: 16),
//      ),
      leading: Icon(
        icon,
        color: color,
      ),
    );
  }

  Widget _layoutSocial(BuildContext context) {
    List<Widget> listSocial = List<Widget>();
    if (person.facebook.isNotEmpty) {
      listSocial.add(
          _lineSocial(StringApp.facebook, "images/facebook.png", Colors.blue, person.facebook));
    }
    if (person.zalo.toString().isNotEmpty) {
      listSocial
          .add(_lineSocial(StringApp.zalo, "images/zalo.png", Colors.indigo, person.zalo));
    }
    if (person.youtube.toString().isNotEmpty) {
      listSocial
          .add(_lineSocial(StringApp.youtube, "images/youtube.png", Colors.red, person.youtube));
    }
    if (person.twitter.toString().isNotEmpty) {
      listSocial.add(
          _lineSocial(StringApp.twitter, "images/twitter.png", Colors.cyan, person.twitter));
    }
    if (person.telegram.toString().isNotEmpty) {
      listSocial.add(_lineSocial(
          StringApp.telegram, "images/telegram.png", Colors.blueGrey, person.telegram));
    }
    if (person.instagram.toString().isNotEmpty) {
      listSocial.add(_lineSocial(
          StringApp.instagram, "images/instagram.png", Colors.blueGrey, person.instagram));
    }
    if (person.linkedin.toString().isNotEmpty) {
      listSocial.add(_lineSocial(
          StringApp.linkedin, "images/linkedin.png", Colors.blueGrey, person.linkedin));
    }
    if (person.tumblr.toString().isNotEmpty) {
      listSocial.add(_lineSocial(
          StringApp.tumblr, "images/tumblr.png", Colors.blueGrey, person.tumblr));
    }
    return Container(
      padding: EdgeInsets.all(_paddingCar),
      width: SizeApp.getSizeByWidth(context: context, percent: 100.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            StringApp.title_info_social,
            style: StyleApp.style_title,
          ),
          Wrap(
            children: listSocial,
          )
        ],
      ),
    );
  }

  Widget _lineSocial(
      String social, String icon, MaterialColor color, String username) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Chip(
        label: Text(
          social,
          style: TextStyle(color: Colors.black),
        ),
        avatar: Image.asset(icon, width: 18,),
      ),
    );
  }

  Widget _layoutShare() {
    print(temp.toString());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              share = false;
            });
          },
          child: QrImage(
            data: temp.toString(),
            version: QrVersions.auto,
            size: 200.0,
          ),
        ),
        Text(StringApp.content_qr_code),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            padding: EdgeInsets.all(10.0),
            color: ColorApp.main_color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Text(
              StringApp.btn_back,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                share = false;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _hr() {
    return Divider();
  }
}
