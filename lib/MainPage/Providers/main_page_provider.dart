import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:owwn_coding_challenge/Constants/k_network.dart';
import 'package:owwn_coding_challenge/MainPage/Models/user_model.dart';
import 'package:owwn_coding_challenge/Network/dio_config.dart';
import 'package:owwn_coding_challenge/Network/view_state.dart';
import 'package:owwn_coding_challenge/error_handling/error_handling.dart';

class MainPageProvider extends ChangeNotifier {
  ViewState mainPageViewState = ViewState.initial;
  ViewState loadMoreState = ViewState.initial;

  /// total number of users in the database
  int _total = 0;
  int _page = 1;

  int get total => _total;

  int get page => _page;

  /// The Set of users
  Set<UserModel> _users = {};

  Set<UserModel> get users => _users;

  /// get the users from the database for the first time
  Future<void> getUsers(BuildContext context) async {
    try {
      if (page == 1) {
        mainPageViewState = ViewState.loading;
      }

      if (_users.length == total && total != 0) {
        mainPageViewState = ViewState.loaded;
        notifyListeners();
        return;
      }
      notifyListeners();

      /// Make a `GET` request to the users endpoint for the first time
      final response =
          await dioClientWithRefreshToken(KNetwork.baseURL, context).get(
        "/users",
        queryParameters: {
          "page": page,
          "limit": 10,
        },
      );
      if (response.statusCode == 200) {
        final users = response.data['users'];

        /// looks weird but it is the way new Flutter version works
        _total = int.parse(response.data['total'].toString());
        for (var user in users) {
          _users.add(UserModel.fromMap(user as Map<String, dynamic>));
        }
        mainPageViewState = ViewState.loaded;
        page = page + 1;
        notifyListeners();
      } else {
        mainPageViewState = ViewState.error;
        notifyListeners();
      }
    } catch (e) {
      mainPageViewState = ViewState.error;
      handleError(context, e, () {
        getUsers(context);
      });
      notifyListeners();
    }
  }

  /// get the users from the database for the next pages because of the custom pagination
  /// I used in the app
  Future<void> getMoreUsers(BuildContext context) async {
    _users = {};

    try {
      if (_users.length == total) {
        loadMoreState = ViewState.loaded;
        notifyListeners();
        return;
      }
      loadMoreState = ViewState.loading;
      notifyListeners();

      /// I used the same endpoint as the first time but with the page number
      final response =
          await dioClientWithRefreshToken(KNetwork.baseURL, context).get(
        "/users",
        queryParameters: {
          "page": page,
          "limit": 15,
        },
      );
      if (response.statusCode == 200) {
        final users = response.data['users'];

        /// looks weird but it is the way new Flutter version works
        _total = int.parse(response.data['total'].toString());
        for (final user in users) {
          _users.add(UserModel.fromMap(user as Map<String, dynamic>));
        }

        /// change the state to loaded
        loadMoreState = ViewState.loaded;

        ///for each time the user scrolls to the bottom of the list the page number is increased by 1
        page = page + 1;
        notifyListeners();
      } else {
        loadMoreState = ViewState.error;
        notifyListeners();
      }
    } catch (e) {
      loadMoreState = ViewState.error;
      handleError(context, e, () {
        getMoreUsers(context);
      });
      log(e.toString());
      notifyListeners();
    }
  }

  set users(Set<UserModel> users) {
    _users = users;
    notifyListeners();
  }

  set total(int total) {
    _total = total;
    notifyListeners();
  }

  set page(int page) {
    _page = page;
    notifyListeners();
  }
}
