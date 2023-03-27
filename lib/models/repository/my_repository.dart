import 'package:gonput_2/domain/userdata/userclassdata.dart';

import '../db/database_manager.dart';

class MyRepository {
  final DatabaseManager _databaseManager;

  MyRepository({required DatabaseManager databaseManager})
      : _databaseManager = databaseManager;

  Stream<UserClassData?> fetchUserStream() {
    return _databaseManager.fetchUserStream();
  }
}
