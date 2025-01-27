import 'package:flutter_mobile/model/user_model.dart';

abstract class HomeRepository{
  
  Future<List<UserModel>> getData();

  Future<List<UserModel>> searchData(String key, String query);

  Future<bool> deleteData(String id);

  Future<UserModel> updateData({required UserModel newUser,required String id});

  Future<UserModel> createData(UserModel newUser);
  
}
