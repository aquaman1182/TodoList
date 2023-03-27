import 'package:gonput_2/domain/userdata/userclassdata.dart';
import 'package:gonput_2/models/db/database_manager.dart';

class AuthRepository {
  final DatabaseManager databaseManager;

  AuthRepository({required DatabaseManager databaseManager})
      : databaseManager = databaseManager;

  Future<String?> login(UserClassData user, String password) async {
    return await databaseManager.login(user, password);
  }
}
