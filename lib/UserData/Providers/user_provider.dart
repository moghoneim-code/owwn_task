import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:owwn_coding_challenge/MainPage/Models/user_model.dart';
import 'package:owwn_coding_challenge/Network/view_state.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _selectedUser;
  UserModel? get selectedUser => _selectedUser;
  ViewState userViewState = ViewState.submit;
  ViewState updateUserState = ViewState.submit;

  Future<void> setSelectedUser(UserModel? user) async {
    try {
      _selectedUser = user;
      userViewState = ViewState.loaded;
      notifyListeners();
    } catch (e) {
      userViewState = ViewState.error;
      log(e.toString());
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      _selectedUser = user;
      updateUserState = ViewState.loaded;
      notifyListeners();
    } catch (e) {
      updateUserState = ViewState.error;
      log(e.toString());
      notifyListeners();
    }
  }

  set selectedUser(UserModel? user) {
    _selectedUser = user;
    notifyListeners();
  }
}
