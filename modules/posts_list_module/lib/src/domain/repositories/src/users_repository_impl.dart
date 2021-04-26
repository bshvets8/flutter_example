import 'package:posts_list_module/src/domain/models/models.dart';
import 'package:posts_list_module/src/domain/repositories/src/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {

  Stream<List<UserModel>> getUsers() {

  }

  Stream<UserModel> getUser(int userId) {
    return getUsers().map((users) => users.firstWhere((element) => element.id == userId));
  }

  void loadUsers() {

  }

  void dispose() {

  }
}
