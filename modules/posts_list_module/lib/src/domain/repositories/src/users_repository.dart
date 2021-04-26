import 'package:posts_list_module/src/domain/models/models.dart';

import 'repository.dart';

abstract class UsersRepository extends Repository {
  Stream<List<UserModel>> getUsers();

  Stream<UserModel> getUser(int userId);

  void dispose();
}
