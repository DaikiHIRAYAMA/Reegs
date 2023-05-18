import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

class Store extends ChangeNotifier {
  factory Store() => _instance;
  Store._interral();
  static final Store _instance = Store._interral();

  //サインイン済みかどうか
  Future<bool> get signedIn async {
    final storedAccessToken = await LineSDK.instance.currentAccessToken;
    if (storedAccessToken == null) {
      return false;
    }
    return storedAccessToken.value.isNotEmpty;
  }

  //LINE SDK でログインする
  Future<LoginResult?> signIn() async {
    LoginResult result;
    try {
      result = await LineSDK.instance.login(
        option: LoginOption(false, 'aggressive'),
      );
    } on PlatformException catch (e) {
      var message = "エラーが発生しました";
      throw PlatformException(code: e.code, message: message);
    }
    print(result);
    return result;
  }
}
