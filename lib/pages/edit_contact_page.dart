import 'package:fa_smart_contact/commons/colors.dart';
import 'package:fa_smart_contact/commons/database.dart';
import 'package:fa_smart_contact/commons/sizes.dart';
import 'package:fa_smart_contact/commons/strings.dart';
import 'package:fa_smart_contact/commons/styles.dart';
import 'package:fa_smart_contact/models/contact.dart';
import 'package:flutter/material.dart';

class EditContactPage extends StatefulWidget {
  Contact contact;
  String _subName = "admin";

  EditContactPage({this.contact});

  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  final _keySoaffold = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1964, 1),
        lastDate: DateTime(2220));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  TextEditingController _ctrlName = TextEditingController(text: "");
  TextEditingController _ctrlGender = TextEditingController();
  TextEditingController _ctrlAddress = TextEditingController();
  TextEditingController _ctrlBir = TextEditingController();
  TextEditingController _ctrlPhone = TextEditingController();
  TextEditingController _ctrlGusto = TextEditingController();
  TextEditingController _ctrlEmail = TextEditingController();
  TextEditingController _ctrlFacebook = TextEditingController();
  TextEditingController _ctrlZalo = TextEditingController();
  TextEditingController _ctrlYoutube = TextEditingController();
  TextEditingController _ctrlTwitter = TextEditingController();
  TextEditingController _ctrlTelegram = TextEditingController();
  TextEditingController _ctrlInstagram = TextEditingController();
  TextEditingController _ctrlLinkedin = TextEditingController();
  TextEditingController _ctrlTumblr = TextEditingController();

  @override
  void initState() {
    if (widget.contact != null) {
      _ctrlName.text = widget._subName = widget.contact.name;
      _ctrlGender.text = widget.contact.gender == 0
          ? "Nam"
          : widget.contact.gender == 1 ? "Nữ" : "";
      _ctrlAddress.text = widget.contact.address;
      selectedDate = widget.contact.birthday;
      _ctrlPhone.text = widget.contact.phone;
      _ctrlGusto.text = widget.contact.gusto;
      _ctrlEmail.text = widget.contact.email;
      _ctrlFacebook.text = widget.contact.facebook;
      _ctrlZalo.text = widget.contact.zalo;
      _ctrlYoutube.text = widget.contact.youtube;
      _ctrlTwitter.text = widget.contact.twitter;
      _ctrlTelegram.text = widget.contact.telegram;
      _ctrlInstagram.text = widget.contact.instagram;
      _ctrlLinkedin.text = widget.contact.linkedin;
      _ctrlTumblr.text = widget.contact.tumblr;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _ctrlBir.text = selectedDate.toLocal().toString().split(' ')[0];
    return Scaffold(
      key: _keySoaffold,
      appBar: AppBar(
        backgroundColor: ColorApp.main_color,
        title: Text(StringApp.title_edit_contact),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _avatar(),
            _infoIndex(),
            _infoDetail(),
            _infoSocial(),
            _buttom()
          ],
        ),
      ),
    );
  }

  Widget _avatar() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: CircleAvatar(
          radius: 32,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Text(
              widget._subName.substring(0, 1).toUpperCase(),
              style: StyleApp.style_avatar,
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoIndex() {
    return Container(
      padding: EdgeInsets.all(StyleApp.container_layout_padding),
      margin: EdgeInsets.all(StyleApp.container_layout_margin),
      width: SizeApp.getSizeByWidth(context: context, percent: 98),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title(StringApp.title_info),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextField(
              controller: _ctrlName,
              decoration: InputDecoration(
                  //hintText: title,
                  labelText: StringApp.name,
                  labelStyle: TextStyle(fontSize: 18, color: Colors.teal)),
              onChanged: (name) {
                setState(() {
                  widget._subName = name.substring(0, 1);
                });
              },
            ),
          ),
          _lineInputString(StringApp.phone, _ctrlPhone),
          _lineInputString(StringApp.gusto, _ctrlGusto),
        ],
      ),
    );
  }

  Widget _infoDetail() {
    return Container(
        padding: EdgeInsets.all(StyleApp.container_layout_padding),
        margin: EdgeInsets.all(StyleApp.container_layout_margin),
        width: SizeApp.getSizeByWidth(context: context, percent: 98),
        color: Colors.white,
        child: ExpansionTile(
          title: _title(StringApp.title_detail),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: TextField(
                controller: _ctrlBir,
                decoration: InputDecoration(
                    //hintText: StringApp.birthday,
                    labelText: StringApp.birthday,
                    labelStyle: TextStyle(fontSize: 20, color: Colors.teal),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.date_range),
                        onPressed: () => _selectDate(context))),
              ),
            ),
            _lineInputString(StringApp.gender, _ctrlGender),
            _lineInputString(StringApp.address, _ctrlAddress),
            _lineInputString(StringApp.email, _ctrlEmail),
          ],
        ));
  }

  Widget _infoSocial() {
    return Container(
      padding: EdgeInsets.all(StyleApp.container_layout_padding),
      margin: EdgeInsets.all(StyleApp.container_layout_margin),
      width: SizeApp.getSizeByWidth(context: context, percent: 98),
      color: Colors.white,
      child: ExpansionTile(
        title: _title(StringApp.title_info_social),
        children: <Widget>[
          _lineInputString(StringApp.facebook, _ctrlFacebook),
          _lineInputString(StringApp.zalo, _ctrlZalo),
          _lineInputString(StringApp.youtube, _ctrlYoutube),
          _lineInputString(StringApp.twitter, _ctrlTwitter),
          _lineInputString(StringApp.telegram, _ctrlTelegram),
          _lineInputString(StringApp.instagram, _ctrlInstagram),
          _lineInputString(StringApp.linkedin, _ctrlLinkedin),
          _lineInputString(StringApp.tumblr, _ctrlTumblr),
        ],
      ),
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: StyleApp.style_title,
    );
  }

  Widget _buttom() {
    return Container(
      padding: EdgeInsets.all(StyleApp.container_layout_padding),
      margin: EdgeInsets.all(StyleApp.container_layout_margin),
      width: SizeApp.getSizeByWidth(context: context, percent: 98),
      color: Colors.white,
      child: MaterialButton(
        padding: EdgeInsets.all(10.0),
        child: Text(
          StringApp.btn_confirm,
          style: TextStyle(color: ColorApp.main_color),
        ),
        onPressed: () async {
          try {
            if (await _updatePersonal(context)) {
              _keySoaffold.currentState.showSnackBar(SnackBar(
                  backgroundColor: ColorApp.main_color,
                  content: Text(StringApp.update_ok)));
              await Future.delayed(Duration(milliseconds: 500));
              Navigator.pop(context);
            }
          } catch (ex) {
            final show = SnackBar(
                backgroundColor: ColorApp.main_color,
                content: Text(ex.toString()));
            _keySoaffold.currentState.showSnackBar(show);
            print("HERE $ex");
          }
        },
      ),
    );
  }

  Widget _lineInputString(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            //hintText: title,
            labelText: title,
            labelStyle: TextStyle(fontSize: 18, color: Colors.teal)),
      ),
    );
  }

  Future<bool> _updatePersonal(BuildContext context) async {
    if (_ctrlName.text.trim().isEmpty) throw ("Vui lòng điền tên của bạn!");
    if (_ctrlPhone.text.trim().isEmpty) throw ("Vui lòng nhập số điện thoại!");
    if (_ctrlGender.text.trim().isNotEmpty &&
        _ctrlGender.text.trim().toLowerCase() != "nam" &&
        _ctrlGender.text.trim().toLowerCase() != "nữ") {
      throw ("Giới tính là 'Nam' hoặc 'Nữ' hoặc bỏ trống!");
    }
//    DateTime dt = DateTime.parse(_ctrlBir.text);
    Contact contact = Contact(
        widget.contact.id,
        _ctrlName.text.trim(),
        DateTime.parse(_ctrlBir.text.trim()),
        _ctrlGender.text.trim().toLowerCase() == "nam"
            ? 0
            : _ctrlGender.text.trim().toLowerCase() == "nữ" ? 1 : 2,
        _ctrlAddress.text.trim(),
        _ctrlPhone.text.trim(),
        _ctrlEmail.text.trim(),
        _ctrlFacebook.text.trim(),
        _ctrlZalo.text.trim(),
        _ctrlYoutube.text.trim(),
        _ctrlTwitter.text.trim(),
        _ctrlTelegram.text.trim(),
        _ctrlInstagram.text.trim(),
        _ctrlLinkedin.text.trim(),
        _ctrlTumblr.text.trim(),
        _ctrlGusto.text.trim(),
        widget.contact.favourite,
        widget.contact.person);
    bool update = await DatabaseApp.updateContact(contact);
    print("KQ UPDATE= $update");
    return update;
  }
}
