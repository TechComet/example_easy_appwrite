import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:example_easy_appwrite/client.dart';

class DatabaseClass {
  final topic = TopicTable();
  final reply = ReplyTable();

  DatabaseClass using(final String dbName) {
    return DatabaseClass()
      ..topic.dbName = dbName
      ..reply.dbName = dbName;
  }

}

class TopicTable with BaseManager {}

class ReplyTable with BaseManager {}

mixin BaseManager {

  AppwriteMetaBase? get meta => null;

  Future<Document> create(
      {required Map payload,
      String? documentId,
      required List<String> permissions}) async {
    final response = await ApiClient.databases.createDocument(
        databaseId: dbName,
        collectionId: tableName,
        documentId: documentId ?? ID.unique(),
        data: payload);
    return response;
  }

  Future<Document> update(
      {required String documentId, required Map payload}) async {
    final response = await ApiClient.databases.updateDocument(
        databaseId: dbName,
        collectionId: tableName,
        documentId: documentId,
        data: payload);
    return response;
  }

  Future<Document> get(
      {required String documentId, List<String>? queries}) async {
    final response = await ApiClient.databases.getDocument(
        databaseId: dbName,
        collectionId: tableName,
        documentId: documentId,
        queries: queries);
    return response;
  }

  Future<DocumentList> list({List<String>? queries}) async {
    final response = await ApiClient.databases.listDocuments(
        databaseId: dbName, collectionId: tableName, queries: queries);
    return response;
  }

  Future<void> delete({required String documentId}) async {
    final response = await ApiClient.databases.deleteDocument(
        databaseId: dbName, collectionId: tableName, documentId: documentId);
    return response;
  }

  String _getDefaultTableName() {
    final typeName = runtimeType.toString().toLowerCase();

    return typeName.substring(0, typeName.length - 5);
  }

  String? _dbName;

  String get dbName => _dbName ?? 'default';

  set dbName(String dbName) {
    assert(dbName.isNotEmpty);
    _dbName = dbName;
  }

  String get tableName => meta?.dbTable ?? _getDefaultTableName();
}

class AppwriteMetaBase {
  final String? dbTable;

  AppwriteMetaBase({this.dbTable});

  AppwriteMetaBase.empty() : dbTable = null;
}

final database = DatabaseClass();
