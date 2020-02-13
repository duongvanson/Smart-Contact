import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as EN;
import 'package:fa_smart_contact/models/contact.dart';

class KeyApp {
  static const _key = "NopAsswOrdnOSecuritY1998;;;;;;;;";
  static final _keyCrypt = EN.Key.fromUtf8(_key);
  static final base64key = EN.Key.fromUtf8(base64Url.encode(_keyCrypt.bytes));
  static final _fernet = EN.Fernet(base64key);
  static final _encrypter = EN.Encrypter(_fernet);
  static String enCode(Contact contact) {
    final encode = _encrypter.encrypt(contact.toMap().toString());
    //print(encode.base64);
    return encode.base64.toString();
  }
  static Contact deCode(String b64){
    final ened = EN.Encrypted.fromBase64(b64);
    final decode = _encrypter.decrypt(ened);
    return Contact.fromJSon(json.decode(decode));
  }
}
