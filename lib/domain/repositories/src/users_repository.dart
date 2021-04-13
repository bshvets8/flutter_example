import 'package:flutter_cubit/domain/models/models.dart';

abstract class UsersRepository {
  Stream<List<UserModel>> users();

  Stream<UserModel> getUser(int userId);

  void loadUsers();

  void dispose();
}
