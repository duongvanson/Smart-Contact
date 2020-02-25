import 'package:fa_smart_contact/commons/colors.dart';
import 'package:fa_smart_contact/commons/database.dart';
import 'package:fa_smart_contact/commons/strings.dart';
import 'package:fa_smart_contact/models/contact.dart';
import 'package:fa_smart_contact/pages/detail_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  ContactPage();

  List<Widget> listSocial = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DatabaseApp.getListContact(),
        builder: (context, snapshot) {
          List<Contact> contacts;
          if (snapshot.hasData) {
            contacts = snapshot.data as List<Contact>;
            //print(contacts);
            if (contacts.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.sentiment_dissatisfied,
                      color: ColorApp.main_color,
                      size: 38,
                    ),
                    Text(StringApp.content_null_contact),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                //separatorBuilder:(context,id) => Divider(),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  listSocial.clear();
                  _checkSocial(contact.facebook, "facebook");
                  _checkSocial(contact.email, "mail");
                  _checkSocial(contact.zalo, "zalo");
                  _checkSocial(contact.instagram, "instagram");
                  _checkSocial(contact.linkedin, "linkedin");
                  _checkSocial(contact.telegram, "telegram");
                  _checkSocial(contact.tumblr, "tumblr");
                  _checkSocial(contact.twitter, "twitter");
                  _checkSocial(contact.youtube, "youtube");
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(contact.name.substring(0, 1)),
                        maxRadius: 25,
                        backgroundColor: Colors.white,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              contact.name,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Row(
                            children: listSocial,
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailContactPage(
                                      id: contact.id,
                                    )));
                      },
                      trailing: GestureDetector(
                        onTap: () {
                          launch("tel:${contact.phone}");
                        },
                        child: CircleAvatar(
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                          radius: 20,
                          backgroundColor: ColorApp.main_color,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _lineSocial(String social) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Image.asset(social, width: 13),
    );
  }

  void _checkSocial(String social, String shot) {
    if (social.isNotEmpty) {
      switch (shot) {
        case "facebook":
          listSocial.add(_lineSocial('images/facebook.png'));
          break;
        case "mail":
          listSocial.add(_lineSocial('images/mail.png'));
          break;
        case "zalo":
          listSocial.add(_lineSocial('images/zalo.png'));
          break;
        case "youtube":
          listSocial.add(_lineSocial('images/youtube.png'));
          break;
        case "twitter":
          listSocial.add(_lineSocial('images/twitter.png'));
          break;
        case "telegram":
          listSocial.add(_lineSocial('images/telegram.png'));
          break;
        case "instagram":
          listSocial.add(_lineSocial('images/instagram.png'));
          break;
        case "linkedin":
          listSocial.add(_lineSocial('images/linkedin.png'));
          break;
        case "tumblr":
          listSocial.add(_lineSocial('images/tumblr.png'));
          break;
      }
    }
  }
}
