import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/models.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<void> signIn(String phoneNumber, String password);

  Future<void> logOut();

  Future<MyUserModel> signUp(MyUserModel myUser, String password);

  Future<void> setUserData(MyUserModel user);

  Future<MyUserModel> getMyUser(String myUserId);
}
