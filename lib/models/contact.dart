class Contact {
  int _id;
  String _name="";
  DateTime _birthday;
  int _gender; //male: 0, famale: 1
  String _address="", _phone="", _email="";
  String _facebook = "",
      _zalo="",
      _youtube="",
      _twitter="",
      _telegram="",
      _instagram="",
      _linkedin="",
      _tumblr=""; //social by username
  String _gusto="";
  int _favourite;
  int _person;

  String get instagram => _instagram;

  set instagram(String value) {
    _instagram = value;
  }

  int get person => _person;

  set person(int value) {
    _person = value;
  }

  Contact(
      this._id,
      this._name,
      this._birthday,
      this._gender,
      this._address,
      this._phone,
      this._email,
      this._facebook,
      this._zalo,
      this._youtube,
      this._twitter,
      this._telegram,
      this._instagram,
      this._linkedin,
      this._tumblr,
      this._gusto,
      this._favourite,
      this._person);

  Map<String, dynamic> toMap() {
    return {
      //'id': _id.toString(),
      '\"name\"': '\"$_name\"',
      '\"birthday\"': '\"${_birthday.toLocal().toString().split(' ')[0]}\"',
      '\"gender\"': _gender,
      '\"address\"': '\"$_address\"',
      '\"phone\"': '\"$_phone\"',
      '\"email\"': '\"$_email\"',
      '\"facebook\"': '\"$_facebook\"',
      '\"zalo\"': '\"$_zalo\"',
      '\"youtube\"': '\"$_youtube\"',
      '\"twitter\"': '\"$_twitter\"',
      '\"telegram\"': '\"$_telegram\"',
      '\"instagram\"': '\"$_instagram\"',
      '\"linkedin\"': '\"$_linkedin\"',
      '\"tumblr\"': '\"$_tumblr\"',
      '\"gusto\"': '\"$_gusto\"',
      '\"favourite\"': _favourite,
      '\"person\"': _person
    };
  }

  Contact.fromJSon(Map<String, dynamic> json)
      : _id = 0,
        _name = json['name'],
        _birthday = DateTime.parse(json['birthday']),
        _gender = json['gender'],
        _address = json['address'],
        _phone = json['phone'],
        _email = json['email'],
        _facebook = json['facebook'],
        _zalo = json['zalo'],
        _youtube = json['youtube'],
        _twitter = json['twitter'],
        _telegram = json['telegram'],
        _gusto = json['gusto'],
        _favourite = 0,
        _person = 0,
        _instagram = json['instagram'],
        _linkedin = json['linkedin'],
        _tumblr = json['tumblr'];

  @override
  String toString() {
    return '{id: 0, '
        'name: $_name,'
        ' birthday: ${_birthday.toUtc().toString().split(' ')[0]}, '
        'gender: $_gender,'
        ' address: $_address, '
        'phone: $_phone,'
        ' email: $_email,'
        'facebook: $_facebook, '
        'zalo: $_zalo,'
        ' youtube: $_youtube, '
        'twitter: $_twitter,'
        ' telegram: $_telegram,'
        'instagram: $_instagram,'
        'linkedin: $_linkedin,'
        ' tumblr: $_tumblr '
        'gusto: $_gusto,'
        ' favourite: $_favourite, '
        'person: $_person}';
  }
  String get gusto => _gusto;

  set gusto(String value) {
    _gusto = value;
  }

  int get favourite => _favourite;

  set favourite(int value) {
    _favourite = value;
  }

  String get telegram => _telegram;

  set telegram(String value) {
    _telegram = value;
  }

  String get twitter => _twitter;

  set twitter(String value) {
    _twitter = value;
  }

  String get youtube => _youtube;

  set youtube(String value) {
    _youtube = value;
  }

  String get zalo => _zalo;

  set zalo(String value) {
    _zalo = value;
  }

  String get facebook => _facebook;

  set facebook(String value) {
    _facebook = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  int get gender => _gender;

  set gender(int value) {
    _gender = value;
  }

  DateTime get birthday => _birthday;

  set birthday(DateTime value) {
    _birthday = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get linkedin => _linkedin;

  set linkedin(String value) {
    _linkedin = value;
  }

  String get tumblr => _tumblr;

  set tumblr(String value) {
    _tumblr = value;
  }
}
