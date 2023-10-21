/* import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SavedDataBase {
  var SAVED_NEW_TABALE = 'savednews';
  var NEWS_ID = 'news_id';
  var NEWS_DESC = 'news_desc';
  var NEWS_TITLE = 'news_title';
  var PUBLISH_DATE = 'publish_date';
  var CONTENT = 'content';
  var IMAGE_URL = 'image_url';
  var NEWS_URL = 'news_url';
  var PUBLISHED_AT = 'published_at';

  Future<Database> opneDB() async {
    var myDirectory = await getApplicationDocumentsDirectory();

    myDirectory.create(recursive: true);
    var dbpath = "$myDirectory/savednewsdb.db";

    return openDatabase(
      dbpath,
      version: 1,
      onCreate: (db, version) {
        var QueryTable =
            "CREATE TABLE $SAVED_NEW_TABALE ($NEWS_ID integer primart key autoincrement, $NEWS_DESC text, $NEWS_TITLE text, $PUBLISH_DATE text, $CONTENT text, $IMAGE_URL text, $NEWS_DESC text, $PUBLISHED_AT text)";
        db.execute(QueryTable);
      },
    );
  }

  void AddNews(
      {required String id,
      required String details,
      required String title,
      required String description,
      required String content,
      required String img,
      required String newsUrl,
      required String publish}) async {
    var db = await opneDB();
    var check =
        await db.insert(SAVED_NEW_TABALE, {
          NEWS_ID: id, 
          NEWS_DESC: description,
          PUBLISHED_AT: publish,


          
          });
  }
}
 */


import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SavedNewsDB {
  var TABLE_NAME = "SAVED_NEWS";
  var NEWS_ID = "news_id";
  var PUB_DET = "pub_det";
  var TITLE = "news_title";
  var DESC = "news_desc";
  var CONTENT = "news_content";
  var IMG_URL = "news_imgurl";
  var NEWS_URL = "news_url";
  var PUB_AT = "news_pubat";

  Future<Database> openDB() async {
    var myDirectory = await getApplicationDocumentsDirectory();
    await myDirectory.create(recursive: true);
    var dbPath = "$myDirectory/savednewsdb.db";
    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      var createQuery =
          "CREATE TABLE $TABLE_NAME ($NEWS_ID integer primary key autoincrement, $PUB_DET text, $TITLE text, $DESC text, $CONTENT text, $IMG_URL text, $NEWS_URL text, $PUB_AT text)";
      db.execute(createQuery);
    });
  }

  Future<bool> addNews(
      {required String id,
      required String details,
      required String title,
      required String description,
      required String content,
      required String imgUrl,
      required String newsUrl,
      required String pub}) async {
    var db = await openDB();
    var check = await db.insert(TABLE_NAME, {
      NEWS_ID : id,
      PUB_DET : details,
      TITLE : title,
      DESC : description,
      CONTENT : content,
      IMG_URL : imgUrl,
      NEWS_URL : newsUrl,
      PUB_AT : pub,
    });
    return check > 0;
  }

  Future<List<Map<String, dynamic>>> fetchSavedNews() async{
    var db = await openDB();
    List<Map<String, dynamic>> notes = await db.query(TABLE_NAME);
    return notes;
  }

  Future<bool> deleteNews(String id) async{
    var db = await openDB();
    int check = await db.delete(TABLE_NAME, where: "$NEWS_ID = ?", whereArgs: [id]);
    return check>0;
  }

}
