import 'package:flutter/cupertino.dart';
import 'package:owwn_coding_challenge/Constants/k_network.dart';
import 'package:owwn_coding_challenge/Network/dio_config.dart';
import 'package:owwn_coding_challenge/Network/view_state.dart';
import 'package:owwn_coding_challenge/error_handling/error_handling.dart';

class LoginProvider extends ChangeNotifier {
  /// String to store the access token
  String _accessToken = '';

  String get accessToken => _accessToken;

  /// The state of the login process
  ViewState loginState = ViewState.initial;

  Future<void> login(BuildContext context) async {
    ///`try` block to catch any errors
    try {
      /// Set the state to `loading`
      loginState = ViewState.loading;

      /// Notify the listeners
      notifyListeners();

      /// Make a `POST` request to the login endpoint
      final response = await baseDioClient(KNetwork.baseURL).post(
        '/auth',

        /// The body of the request
        data: {
          "email": "flutter-challenge@owwn.com",
        },
      );

      /// If the response is successful
      if (response.statusCode == 200) {
        /// Set the access token
        _accessToken = response.data['access_token'].toString();
        loginState = ViewState.loaded;

        /// Notify the listeners
        notifyListeners();
      }
    } catch (error) {
      /// If there is an error
      loginState = ViewState.error;

      handleError(context, error, () {});

      /// Notify the listeners
      notifyListeners();
    }
  }

  set accessToken(String accessToken) {
    /// Set the access token
    _accessToken = accessToken;
    notifyListeners();
  }
}
