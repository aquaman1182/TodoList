import 'package:gonput_2/domain/userdata/userclassdata.dart';
import 'package:gonput_2/models/db/database_manager.dart';

class EditProfileRepository {
  final DatabaseManager databaseManager;

  EditProfileRepository({required DatabaseManager databaseManager})
      : databaseManager = databaseManager;

  Future<void> update(UserClassData user) async {
    await databaseManager.updateProfile(user);
  }
}
