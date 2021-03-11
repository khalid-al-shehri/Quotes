import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DBHelper {

  static DBHelper _databaseHelper;
  static Database _database;

  DBHelper._createInstance();

  static final _dbName = 'Quotes.db';
  static final _dbVersion = 1;
  static final _tableNameFavorite = 'Favorite';
  static final _tableNameQuotes = 'Quote';

// Columns
  static final columnId = 'id';
  static final columnIdFetched = 'IdFetched';
  static final columnAuthor = 'Author';
  static final columnQuote = 'Quote';

  factory DBHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DBHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    // Directory directory = await getApplicationDocumentsDirectory();
    String directory = await getDatabasesPath();
    String path = p.join(directory, '$_dbName');

    // Open/create the database at a given path
    var quotesDatabase = await openDatabase(
        path,
        version: _dbVersion,
        onCreate: _createTableDb);

    return quotesDatabase;
  }

  void _createTableDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $_tableNameQuotes($columnId INTEGER PRIMARY KEY autoincrement, $columnIdFetched TEXT, $columnAuthor TEXT, $columnQuote TEXT)',
    );

    await db.execute(
      'CREATE TABLE $_tableNameFavorite($columnId INTEGER PRIMARY KEY autoincrement, $columnIdFetched TEXT, $columnAuthor TEXT, $columnQuote TEXT)',
    );
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  // Quote

  Future<int> insertQuotes({String idFetched, String author, String quote}) async {
    Database db = await this.database;
    // Will return the new id
    return await db.insert(
      // add to this table
        '$_tableNameQuotes',
        // values to add
        {
          "$columnIdFetched": idFetched,
          "$columnAuthor": author,
          "$columnQuote": quote
        }
    );
  }

  Future<List> getAllListQuotes() async {
    Database db = await this.database;
    final List getAll = await db.query('$_tableNameQuotes');
    return getAll;
  }

  Future<int> updateQuotes({int id, String idFetched, String author, String quote}) async {
    Database db = await this.database;
    return await db.update(
      // update to this table
        '$_tableNameQuotes',
        // values to update
        {
          "$columnIdFetched": idFetched,
          "$columnAuthor": author,
          "$columnQuote": quote
        },
        where: "id = ?",
        whereArgs: [id]);
  }

  Future<void> deleteQuotes({String idFetched}) async {
    Database db = await this.database;
    await db.delete(
        '$_tableNameQuotes',
        where: "$columnIdFetched = ?",
        whereArgs: [idFetched]
    );
  }

  Future<bool> searchForFetchedIDQuotes(String text)async{
    Database db = await this.database;
    List res = await db.query(
        '$_tableNameQuotes',
        where: "$columnIdFetched = ?",
        whereArgs: [text]
    );
    return res.length > 0 ? true : false;
  }

  // Favorite

  Future<int> insertFavorite({String idFetched, String author, String quote}) async {
    Database db = await this.database;
    // Will return the new id
    return await db.insert(
      // add to this table
        '$_tableNameFavorite',
        // values to add
        {
          "$columnIdFetched": idFetched,
          "$columnAuthor": author,
          "$columnQuote": quote
        }
    );
  }

  Future<List> getAllListFavorite() async {
    Database db = await this.database;
    final List getAll = await db.query('$_tableNameFavorite');
    return getAll;
  }

  Future<int> updateFavorite({int id, String idFetched, String author, String quote}) async {
    Database db = await this.database;
    return await db.update(
      // update to this table
        '$_tableNameFavorite',
        // values to update
        {
          "$columnIdFetched": idFetched,
          "$columnAuthor": author,
          "$columnQuote": quote
        },
        where: "id = ?",
        whereArgs: [id]);
  }

  Future<void> deleteFavorite({String idFetched}) async {
    Database db = await this.database;
    await db.delete(
        '$_tableNameFavorite',
        where: "$columnIdFetched = ?",
        whereArgs: [idFetched]
    );


  }

  Future<bool> searchForFetchedIDFavorite(String text)async{
    Database db = await this.database;
    List res = await db.query(
        '$_tableNameFavorite',
        where: "$columnIdFetched = ?",
        whereArgs: [text]
    );
    return res.length > 0 ? true : false;
  }

}