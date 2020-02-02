import 'package:fa_smart_contact/commons/colors.dart';
import 'package:fa_smart_contact/commons/database.dart';
import 'package:fa_smart_contact/commons/sizes.dart';
import 'package:fa_smart_contact/commons/strings.dart';
import 'package:fa_smart_contact/models/contact.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  bool person = false;

  AddContactPage({this.person});

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

  TextEditingController _ctrlName = TextEditingController();
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
            _lineInputString(StringApp.name, _ctrlName),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: TextField(
                controller: _ctrlBir,
                decoration: InputDecoration(
                    hintText: StringApp.birthday,
                    labelText: StringApp.birthday,
                    labelStyle: TextStyle(fontSize: 20, color: Colors.teal),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.date_range),
                        onPressed: () => _selectDate(context))),
              ),
            ),
            _lineInputString(StringApp.gender, _ctrlGender),
            _lineInputString(StringApp.address, _ctrlAddress),
            _lineInputString(StringApp.phone, _ctrlPhone),
            _lineInputString(StringApp.gusto, _ctrlGusto),
            _lineInputString(StringApp.email, _ctrlEmail),
            _lineInputString(StringApp.facebook, _ctrlFacebook),
            _lineInputString(StringApp.zalo, _ctrlZalo),
            _lineInputString(StringApp.youtube, _ctrlYoutube),
            _lineInputString(StringApp.twitter, _ctrlTwitter),
            _lineInputString(StringApp.telegram, _ctrlTelegram),
            _lineInputString(StringApp.instagram, _ctrlInstagram),
            _lineInputString(StringApp.linkedin, _ctrlLinkedin),
            _lineInputString(StringApp.tumblr, _ctrlTumblr),
            MaterialButton(
              padding: EdgeInsets.all(10.0),
              color: ColorApp.main_color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                StringApp.btn_confirm,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                try {
                  if (await _insertPersonal(context)) {
//                    print(_ctrlInstagram.text);
                    Navigator.pop(context);
                  }
                } catch (ex) {
                  final show = SnackBar(content: Text(ex.toString()));
                  _keySoaffold.currentState.showSnackBar(show);
                  print("HERE $ex");
                }
              },
            )
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
            hintText: title,
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
}
