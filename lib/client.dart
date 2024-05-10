import 'package:appwrite/appwrite.dart';

import './config.dart';

class ApiClient {
  Client get _client {
    Client client = Client();
    client
        .setEndpoint(appwriteEndpoint)
        .setProject(appwriteProjectId)
        .setSelfSigned(status: appwriteSelfSigned);

    return client;
  }

  static Account get account => Account(_instance._client);

  static Databases get databases => Databases(_instance._client);

  static Storage get storage => Storage(_instance._client);

  static Avatars get avatars => Avatars(_instance._client);

  static Locale get locale => Locale(_instance._client);

  static final ApiClient _instance = ApiClient._internal();

  ApiClient._internal();

  factory ApiClient() => _instance;
}
