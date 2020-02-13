import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:fa_smart_contact/models/contact.dart';

class DatabaseApp {
  static Future<Database> getDatabaseApp() async {
    return openDatabase(join(await getDatabasesPath(), "contact.db"),
        onCreate: (db, version) {
      return db.execute("CREATE TABLE Contacts("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT, "
          "birthday TEXT,"
          "gender INTEGER,"
          "address TEXT,"
          "phone TEXT,"
          "email TEXT,"
          "facebook TEXT,"
          "zalo TEXT,"
          "youtube TEXT,"
          "twitter TEXT,"
          "telegram TEXT,"
          "instagram TEXT,"
          "linkedin TEXT,"
          "tumblr TEXT,"
          "gusto TEXT,"
          "favourite INTEGER,"
          "person INTEGER)");
    }, version: 1);
  }

  static Future<bool> insertContact(Contact contact) async {
    // print(contact.toMap());
    // Get a reference to the database.
    try {
      final Database db = await getDatabaseApp();
      await db.insert(
        'contacts',
        contact.toMapData(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  static Future<Contact> getPersonContact() async {
    final Database db = await getDatabaseApp();
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM Contacts WHERE person == 1");
    if (maps.length <= 0) {
      print("cha co gi");
      return null;
    }
    Contact contact = Contact(
      maps[0]['id'],
      maps[0]['name'],
      DateTime.parse(maps[0]['birthday']),
      maps[0]['gender'],
      maps[0]['address'],
      maps[0]['phone'],
      maps[0]['email'],
      maps[0]['facebook'],
      maps[0]['zalo'],
      maps[0]['youtube'],
      maps[0]['twitter'],
      maps[0]['telegram'],
      maps[0]['instagram'],
      maps[0]['linkedin'],
      maps[0]['tumblr'],
      maps[0]['gusto'],
      maps[0]['favourite'],
      maps[0]['person'],
    );
    // print(contact);
    return contact;
  }

  static Future<Contact> getContactById(int id) async {
    final Database db = await getDatabaseApp();
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM Contacts WHERE id == $id");
    return Contact(
      maps[0]['id'],
      maps[0]['name'],
      DateTime.parse(maps[0]['birthday']),
      maps[0]['gender'],
      maps[0]['address'],
      maps[0]['phone'],
      maps[0]['email'],
      maps[0]['facebook'],
      maps[0]['zalo'],
      maps[0]['youtube'],
      maps[0]['twitter'],
      maps[0]['telegram'],
      maps[0]['instagram'],
      maps[0]['linkedin'],
      maps[0]['tumblr'],
      maps[0]['gusto'],
      maps[0]['favourite'],
      maps[0]['person'],
    );
  }

  static Future<bool> deleteContactById(int id) async {
    final Database db = await getDatabaseApp();
    if (await db.rawDelete("DELETE FROM contacts WHERE id == $id") >= 1) {
      return true;
    }
    return false;
  }

  static Future<List<Contact>> getListContact() async {
    final Database db = await getDatabaseApp();
    final List<Map<String, dynamic>> maps = await db
        .rawQuery("SELECT * FROM Contacts WHERE person == 0 ORDER BY name ASC");
    print(maps.length);
    // print(maps);
    return List.generate(maps.length, (i) {
      return Contact(
        maps[i]['id'],
        maps[i]['name'],
        DateTime.parse(maps[i]['birthday']),
        maps[i]['gender'],
        maps[i]['address'],
        maps[i]['phone'],
        maps[i]['email'],
        maps[i]['facebook'],
        maps[i]['zalo'],
        maps[i]['youtube'],
        maps[i]['twitter'],
        maps[i]['telegram'],
        maps[i]['instagram'],
        maps[i]['linkedin'],
        maps[i]['tumblr'],
        maps[i]['gusto'],
        maps[i]['favourite'],
        maps[i]['person'],
      );
    });
  }

  static Future<List<Contact>> getListFavouriteContact() async {
    final Database db = await getDatabaseApp();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM Contacts WHERE person == 0 AND favourite == 1");
    print(maps.length);
    //print(maps);
    return List.generate(maps.length, (i) {
      return Contact(
        maps[i]['id'],
        maps[i]['name'],
        DateTime.parse(maps[0]['birthday']),
        maps[i]['gender'],
        maps[i]['address'],
        maps[i]['phone'],
        maps[i]['email'],
        maps[i]['facebook'],
        maps[i]['zalo'],
        maps[i]['youtube'],
        maps[i]['twitter'],
        maps[i]['telegram'],
        maps[i]['instagram'],
        maps[i]['linkedin'],
        maps[i]['tumblr'],
        maps[i]['gusto'],
        maps[i]['favourite'],
        maps[i]['person'],
      );
    });
  }

  static Future<bool> setFavourite(int id, bool favourite) async {
    final Database db = await getDatabaseApp();
    final String sql =
        "UPDATE contacts SET favourite = ${favourite ? 1 : 0} WHERE id = $id";
    final update = await db.rawUpdate(sql);
    if (update >= 1) {
      return true;
    }
    return false;
  }

  static Future<dynamic> checkNumberPhone(String phone) async {
    final Database db = await getDatabaseApp();
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM Contacts WHERE phone == '$phone'");
    if (maps.length >= 1) {
      return maps[0]['name'];
    }
    return false;
  }

  static Future<bool> updateContactExits(Contact contact) async {
    //print(contact.phone);
    final Database db = await getDatabaseApp();
    final del =
        await db.delete("contacts", where: "phone = '${contact.phone}'");
    print(del);
    if (del >= 1) {
      if (await insertContact(contact))
        return true;
      else
        return false;
    }
    return false;
  }

  static Future<bool> updateContact(Contact contact) async {
    final Database db = await getDatabaseApp();
    //print(contact);
    final String sql = "UPDATE Contacts SET "
        "name = '${contact.name}',"
        " phone = '${contact.phone}',"
        " gusto = '${contact.gusto}',"
        " birthday = '${contact.birthday}',"
        " address = '${contact.address}',"
        " gender = ${contact.gender},"
        " email = '${contact.email}',"
        " facebook = '${contact.facebook}',"
        " zalo = '${contact.zalo}',"
        " youtube = '${contact.youtube}',"
        " twitter = '${contact.twitter}',"
        " telegram = '${contact.telegram}',"
        " instagram = '${contact.instagram}',"
        " linkedin = '${contact.linkedin}',"
        " tumblr = '${contact.tumblr}'"
        " WHERE id = ${contact.id}";
    // print(sql);
    final update = await db.rawUpdate(sql);
    if (update >= 1) {
      return true;
    }
    return false;
  }
}
