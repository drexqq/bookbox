import 'dart:convert';
import 'dart:io';

import 'package:bookbox/domain/auth/repository/token_repository.dart';
import 'package:bookbox/http/api_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final chatRepositoryProvider = Provider(ChatRepository.new);

class ChatRepository{
  ChatRepository(this._ref);
  final Ref _ref;

  late final ApiProvider _api = _ref.read(apiProvider);
  late final TokenRepository _tokenRepository =
      _ref.read(tokenRepositoryProvider);

  Future<dynamic> getRentals() async {
    final session = await _tokenRepository.getSession();
    final body = {"rsq": ""};
    final response = await _api.post("my_rentals", body, options: Options(headers: {"session": session}));

    final ret = response.when(success: (data){
      final resp = jsonDecode(data.data);
      debugPrint("====================");
      debugPrint("RESP:::::: $resp");
      return resp;
     }, error: (e) {
      throw HttpException("[ERROR]:: getRentals Error", uri: Uri(path: "my_rentals"));
     });

     return ret;
  }

  Future<dynamic> getSupplies() async {
    final session = await _tokenRepository.getSession();
    final body = {"rsq": ""};
    final response = await _api.post("my_supplies", body, options: Options(headers: {"session": session}));

    final ret = response.when(success: (data){
      final resp = jsonDecode(data.data);
      debugPrint("====================");
      debugPrint("RESP:::::: $resp");
      return resp;
     }, error: (e) {
      throw HttpException("[ERROR]:: getSupplies Error", uri: Uri(path: "my_supplies"));
     });

     return ret;
  }

}