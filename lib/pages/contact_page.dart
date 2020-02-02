import 'package:fa_smart_contact/commons/Strings.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  ContactPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        //separatorBuilder:(context,id) => Divider(),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text("S$index"),
                maxRadius: 25,
                backgroundColor: Colors.white,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "My name S$index",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.ac_unit,
                        size: 12,
                        color: Colors.blue,
                      ),
                      Icon(Icons.favorite, size: 12, color: Colors.red),
                      Icon(Icons.access_alarm, size: 12, color: Colors.orange),
                      Icon(
                        Icons.featured_play_list,
                        size: 12,
                        color: Colors.blue,
                      ),
                    ],
                  )
                ],
              ),
              onTap: () {},
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.call,
                        color: Colors.green[300],
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        Icons.message,
                        color: Colors.orange[300],
                      ),
                      onPressed: () {}),
                ],
              ),
            //  contentPadding: EdgeInsets.only(left:12,right: 0),
            ),
          );
        },
      ),
    );
  }
}
