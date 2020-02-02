import 'package:fa_smart_contact/commons/colors.dart';
import 'package:fa_smart_contact/commons/database.dart';
import 'package:fa_smart_contact/commons/strings.dart';
import 'package:fa_smart_contact/models/contact.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DatabaseApp.getListContact(),
        builder: (context, snapshot) {
          List<Contact> contacts;
          if (snapshot.hasData) {
            contacts = snapshot.data as List<Contact>;
            if (contacts.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.sentiment_dissatisfied, color: ColorApp.main_color, size: 38,),
                    Text(StringApp.content_null_favourite),
                  ],
                ),
              );
            } else {
              return Text("");
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
