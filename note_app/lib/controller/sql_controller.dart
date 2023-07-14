import 'package:note_app/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLController {
  //----------create and initialize the db function---------------------------------
  static Future<Database> initDB() async {
    //----this db stires in device file storage system
    //----on Android, it is typically data/data
    //----on IOS, it is in the documents directory

    final dbPath = await getDatabasesPath();

    //------create the new path object by providing the db name
    final path = join(dbPath, 'notes.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        //create tables here
        await createTables(db);
      },
    );
  }

  //------------create mysql lite tables-----------------------------------
  static Future<void> createTables(Database database) async {
    await database.execute(""" 
    CREATE TABLE Notes(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      description TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }

  //-add a new note to table-------------------------------------------
  static Future<void> createNote(String title, String description) async {
    final db = await initDB();

    //-inserting data object
    final data = {
      "title": title,
      "description": description,
    };
    //---inserting notes
    await db.insert('Notes', data);
  }

  //-get noted from db------------------------------------------------
  static Future<List<NoteModel>> getNotes() async {
    final db = await initDB();

    //-fetching notes from the table
    final result = await db.query('Notes', orderBy: "id");

    return result.map((e) => NoteModel.fromJson(e)).toList();
  }

  //------update an exsiting note--------------------------------------
  static Future<void> updateNote(
      int id, String title, String description) async {
    final db = await initDB();

    //-inserting data object
    final data = {
      "title": title,
      "description": description,
      "createdAt": DateTime.now().toString(),
    };
    //---inserting notes
    //-using where args prevents sql injection
    await db.update('Notes', data, where: "id = ?", whereArgs: [id]);
  }

  //------delete an exsiting note--------------------------------------
  static Future<void> deleteNote(int id) async {
    final db = await initDB();

    //---deleting notes
    //-using where args prevents sql injection
    await db.delete('Notes', where: "id = ?", whereArgs: [id]);
  }
}
