import 'package:fa_smart_contact/commons/colors.dart';
import 'package:fa_smart_contact/commons/sizes.dart';
import 'package:fa_smart_contact/commons/strings.dart';
import 'package:fa_smart_contact/commons/styles.dart';
import 'package:fa_smart_contact/models/contact.dart';
import 'package:flutter/material.dart';

class DetailContactPage extends StatefulWidget {
  Contact contact;
  Icon iconFavourite = Icon(Icons.star_border);
  Color iconColor = Colors.grey;

  DetailContactPage({this.contact});
  List<Widget> listSocial = List();
  List<Widget> listDetail = List();
  @override
  _DetailContactPageState createState() => _DetailContactPageState();
}

class _DetailContactPageState extends State<DetailContactPage> {
  @override
  void initState() {
    widget.iconFavourite = widget.contact.favourite == 0
        ? Icon(Icons.star_border)
        : Icon(Icons.star);
    widget.iconColor =
        widget.contact.favourite == 0 ? Colors.grey : Colors.orange;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          MaterialButton(
            onPressed: () {},
            child: Text(
              StringApp.menu_edit,
              style: StyleApp.style_menu_app_bar,
            ),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text(
              StringApp.menu_share,
              style: StyleApp.style_menu_app_bar,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[_layoutTop(), _layoutInfo(), _layoutSocial(), _layoutDetail(), _buttonDelete()],
        ),
      ),
    );
  }

  Widget _layoutTop() {
    return Container(
      padding: EdgeInsets.all(StyleApp.container_layout_padding),
      margin: EdgeInsets.all(StyleApp.container_layout_margin),
      width: SizeApp.getSizeByWidth(context: context, percent: 98),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _avatar(),
          Text(
            widget.contact.name,
            style: StyleApp.style_name,
          ),
          IconButton(
            icon: widget.iconFavourite,
            onPressed: () {},
            color: widget.iconColor,
          )
        ],
      ),
    );
  }

  Widget _avatar() {
    return CircleAvatar(
      radius: 32,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 31,
        child: Text(
          widget.contact.name.substring(0, 1).toUpperCase(),
          style: StyleApp.style_avatar,
        ),
      ),
    );
  }

  Widget _layoutInfo() {
    return Container(
        padding: EdgeInsets.all(StyleApp.container_layout_padding),
        margin: EdgeInsets.all(StyleApp.container_layout_margin),
        width: SizeApp.getSizeByWidth(context: context, percent: 98),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _title(StringApp.title_contact),
            _phone(),
            widget.contact.email.isNotEmpty?_line(StringApp.email, widget.contact.email):SizedBox(),
            _line(StringApp.gusto, widget.contact.gusto)
          ],
        ));
  }

  Widget _title(String title) {
    return Text(
      title,
      style: StyleApp.style_title,
    );
  }

  Widget _phone() {
    return ListTile(
      title: Text(
        StringApp.phone,
        style: StyleApp.style_title_line,
      ),
      subtitle: Text(
        widget.contact.phone,
        style: StyleApp.style_content_line,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              iconSize: StyleApp.icon_size,
              color: Colors.green,
              icon: Icon(
                Icons.call,
              ),
              onPressed: () {}),
          IconButton(
              iconSize: StyleApp.icon_size,
              color: Colors.orange,
              icon: Icon(
                Icons.message,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }

  Widget _line(String title, String content) {
    return ListTile(
      title: Text(
        title,
        style: StyleApp.style_title_line,
      ),
      subtitle: Text(
        content,
        style: StyleApp.style_content_line,
      ),
      onTap: (){
      },
    );
  }

  Widget _layoutSocial() {
    widget.listSocial.clear();
    widget.listSocial.add(_title(StringApp.title_info_social));
    _checkSocial(widget.contact.facebook,"Facebook");
    _checkSocial(widget.contact.zalo,"Zalo");
    _checkSocial(widget.contact.instagram,"Instagram");
    _checkSocial(widget.contact.linkedin,"Linkedin");
    _checkSocial(widget.contact.telegram,"Telegram");
    _checkSocial(widget.contact.tumblr,"Tumblr");
    _checkSocial(widget.contact.twitter,"Twitter");
    _checkSocial(widget.contact.youtube,"Youtube");
    return Container(
        padding: EdgeInsets.all(StyleApp.container_layout_padding),
        margin: EdgeInsets.all(StyleApp.container_layout_margin),
        width: SizeApp.getSizeByWidth(context: context, percent: 98),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.listSocial,
        ));
  }
  void _checkSocial(String username, String social) {
    if (username.isNotEmpty) {
      widget.listSocial.add(_line(social, username));
    }
  }
  void _checkDetail(String content, String detail) {
    if (content.isNotEmpty) {
      widget.listDetail.add(_line(detail, content));
    }
  }
  Widget _layoutDetail() {
    widget.listDetail.clear();
    widget.listDetail.add(_title(StringApp.title_info));
    _checkDetail(widget.contact.birthday.toUtc().toString().split(' ')[0], StringApp.birthday);
    _checkDetail(widget.contact.gender==0?"Nam":widget.contact.gender==1?"Nữ":"Ẩn", StringApp.gender);
    _checkDetail(widget.contact.address, StringApp.address);
    return Container(
        padding: EdgeInsets.all(StyleApp.container_layout_padding),
        margin: EdgeInsets.all(StyleApp.container_layout_margin),
        width: SizeApp.getSizeByWidth(context: context, percent: 98),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.listDetail,
        ));
  }

  Widget _buttonDelete() {
    return Container(
        padding: EdgeInsets.all(StyleApp.container_layout_padding),
        margin: EdgeInsets.all(StyleApp.container_layout_margin),
        width: SizeApp.getSizeByWidth(context: context, percent: 98),
        color: Colors.white,
        child: MaterialButton(
          child: Text(StringApp.btn_delete, style: TextStyle(color: Colors.red),),
          onPressed: (){},
        )
    );
  }
}
