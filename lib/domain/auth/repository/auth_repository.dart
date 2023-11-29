import 'dart:convert';
import 'dart:io';

import 'package:bookbox/domain/auth/repository/token_repository.dart';
import 'package:bookbox/http/api_provider.dart';
import 'package:bookbox/util/string_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthRepositoryProtocol {
  Future<bool> login(String phone);
  Future<String?> sendSms(String phone);
  Future<void> verifyAuthCode(String authCode);
}

final authRepositoryProvider = Provider(AuthRepository.new);

class AuthRepository implements AuthRepositoryProtocol {
  AuthRepository(this._ref);

  final Ref _ref;

  late final ApiProvider _api = _ref.read(apiProvider);
  late final TokenRepository _tokenRepository =
      _ref.read(tokenRepositoryProvider);

  @override
  Future<bool> login(String phone) async {
    String formattedPhone = StringUtil.formattedPhone(phone);
    FormData data = FormData.fromMap({"b_mobile": formattedPhone});
    final response = await _api.post("login_prss", data);

    return response.when(success: (data) async {
      final user = jsonDecode(data.data);
      if (!user["status"]) {
        throw HttpException("Post Login Error: ${user["error_msg"]}",
            uri: Uri(path: "login_prss"));
      }
      String inputString = jsonEncode(user);
      StringBuffer encodedStringBuffer = StringBuffer();

      for (int i = 0; i < inputString.length; i++) {
        String char = inputString[i];
        if (char.runes.every((int rune) => rune >= 0xAC00 && rune <= 0xD7A3)) {
          String encodedChar = char.runes
              .map((int codePoint) =>
                  '\\u${codePoint.toRadixString(16).padLeft(4, '0')}')
              .join();
          encodedStringBuffer.write(encodedChar);
        } else {
          encodedStringBuffer.write(char);
        }
      }

      String encodedString = encodedStringBuffer.toString();

      await _tokenRepository.saveSession(encodedString);
      return true;
    }, error: (e) {
      throw HttpException("Post Login Error", uri: Uri(path: "login_prss"));
    });
  }

  @override
  Future<String?> sendSms(String phone) async {
    if (phone == "") {
      return null;
    }
    String formattedPhone = StringUtil.formattedPhone(phone);
    FormData data = FormData.fromMap({"b_mobile": formattedPhone});
    final response = await _api.post("auth_sms", data);
    return response.when(success: (data) {
      final resp = jsonDecode(data.data);
      if (resp["status"] != "ok") {
        return null;
      }
      return resp["b_auth_no"];
    }, error: (e) {
      throw HttpException("Post Send SMS Error", uri: Uri(path: "auth_sms"));
    });
  }

  @override
  Future<void> verifyAuthCode(String phone) async {
    FormData data = FormData.fromMap({"b_mobile": phone});
    await _api.post("del_auth_no", data);
  }
}
