import 'package:fa_smart_contact/commons/Strings.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  ContactPage();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        separatorBuilder:(context,id) => Divider(),
        itemCount: 10,
        itemBuilder: (context, index){
          return ListTile(
            leading: CircleAvatar(
              child: Text("S$index"),
              backgroundColor: Colors.white,
            ),
            title: Text("My name S$index"),
            onTap: (){},
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(icon: Icon(Icons.call,color: Colors.green,), onPressed: (){}),
                IconButton(icon: Icon(Icons.message, color: Colors.blue,), onPressed: (){}),
              ],
            ),
          );
        },
      ),
    );
  }
}
