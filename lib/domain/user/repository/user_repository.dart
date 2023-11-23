import 'dart:convert';
import 'dart:io';

import 'package:bookbox/domain/auth/repository/token_repository.dart';
import 'package:bookbox/http/api_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class UserRepositoryProtocol {
  Future getUserInfo();
  Future rechargePoint(int point);
  Future getPoint();
}

final userRepositoryProvider = Provider(UserRepository.new);

class UserRepository implements UserRepositoryProtocol {
  UserRepository(this._ref);
  final Ref _ref;

  late final _api = _ref.read(apiProvider);
  late final _tokenRepository = _ref.read(tokenRepositoryProvider);

  @override
  Future getUserInfo() async {
    final session = await _tokenRepository.getSession();
    final response = await _api.post("my_page", null,
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      final resp = jsonDecode(data.data);
      return resp["row"];
    }, error: (e) {
      throw HttpException("Get User Info Error", uri: Uri(path: "my_page"));
    });
  }

  @override
  Future rechargePoint(int point) async {
    final session = await _tokenRepository.getSession();
    final response = await _api.post(
        "regs_points", FormData.fromMap({"point": point}),
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      final resp = jsonDecode(data.data);
      print(resp["B_POINT"]);
      return true;
    }, error: (e) {
      throw HttpException("Get User Info Error", uri: Uri(path: "my_page"));
    });
  }

  @override
  Future getPoint() async {
    final session = await _tokenRepository.getSession();
    final response = await _api.post("get_mem_points", {},
        options: Options(headers: {"session": session}));
    return response.when(success: (data) {
      final resp = jsonDecode(data.data)["row"];
      return resp["B_POINT"];
    }, error: (e) {
      throw HttpException("Get User Info Error", uri: Uri(path: "my_page"));
    });
  }
}
