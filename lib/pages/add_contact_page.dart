import 'package:fa_smart_contact/commons/colors.dart';
import 'package:fa_smart_contact/commons/database.dart';
import 'package:fa_smart_contact/commons/sizes.dart';
import 'package:fa_smart_contact/commons/strings.dart';
import 'package:fa_smart_contact/commons/styles.dart';
import 'package:fa_smart_contact/models/contact.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  bool person = false;

  AddContactPage({this.person});

  String _subName = "admin";

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
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

  List _genderList = ["Nam", "Nữ", "Không xác định"];
  String _gender;

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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(selectedDate.toLocal().toString().split(' ')[0]);
    _ctrlBir.text = selectedDate.toLocal().toString().split(' ')[0];
    return Scaffold(
      key: _keySoaffold,
      appBar: AppBar(
        backgroundColor: ColorApp.main_color,
        title: widget.person
            ? Text(StringApp.title_add_person)
            : Text(StringApp.title_add_contact),
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

  Future<bool> _insertPersonal(BuildContext context) async {
    if (_ctrlName.text.trim().isEmpty) throw ("Vui lòng điền tên của bạn!");
    if (_ctrlPhone.text.trim().isEmpty) throw ("Vui lòng nhập số điện thoại!");
    if (_ctrlGender.text.trim().isNotEmpty &&
        _ctrlGender.text.trim().toLowerCase() != "nam" &&
        _ctrlGender.text.trim().toLowerCase() != "nữ") {
      throw ("Giới tính là 'Nam' hoặc 'Nữ' hoặc bỏ trống!");
    }
    DateTime dt = DateTime.parse(_ctrlBir.text);
    //print(dt.toLocal());
    Contact contact = Contact(
        0,
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
        0,
        widget.person ? 1 : 0);
    //print(contact);
    bool insert = await DatabaseApp.insertContact(contact);
    print("KQ= $insert");
    return insert;
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
//        color: ColorApp.main_color,
        child: Text(
          StringApp.btn_confirm,
          style: TextStyle(color: ColorApp.main_color),
        ),
        onPressed: () async {
          try {
            if (await _insertPersonal(context)) {
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
}
