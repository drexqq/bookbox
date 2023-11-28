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

  Future<dynamic> getSession() async {
    final session = await _tokenRepository.getSession();
    final ret = jsonDecode(session!);

    return ret;
  }

  Future<dynamic> getRentals() async {
    final session = await _tokenRepository.getSession();
    final body = {};
    final response = await _api.post("my_rentals", body, options: Options(headers: {"session": session}));

    final ret = response.when(success: (data){
      final resp = jsonDecode(data.data);
      // debugPrint("====================");
      // debugPrint("RESP:::::: $resp");
      return resp;
     }, error: (e) {
      throw HttpException("[ERROR]:: getRentals api Error", uri: Uri(path: "my_rentals"));
     });

     return ret;
  }

  Future<dynamic> getSupplies() async {
    final session = await _tokenRepository.getSession();
    final body = {};
    final response = await _api.post("my_supplies", body, options: Options(headers: {"session": session}));

    final ret = response.when(success: (data){
      final resp = jsonDecode(data.data);
      // debugPrint("====================");
      // debugPrint("RESP:::::: $resp");
      return resp;
     }, error: (e) {
      throw HttpException("[ERROR]:: getSupplies api Error", uri: Uri(path: "my_supplies"));
     });

     return ret;
  }

  Future<dynamic> getRentalTalks(String rsq) async {
    final session = await _tokenRepository.getSession();
    FormData body = FormData.fromMap({"rsq": rsq});
    final response = await _api.post("rental_talks", body, options: Options(headers: {"session": session}));

    final ret = response.when(success: (data) {
      final resp = jsonDecode(data.data);
      return resp;
    }, error: (e) {
      throw HttpException("[ERROR]:: getRentalTalks api Error", uri: Uri(path: "rental_talks"));
    });

    return ret;
  }

  Future<dynamic> getBookboxInfo(String ssq) async {
    final session = await _tokenRepository.getSession();
    FormData body = FormData.fromMap({"ssq": ssq});
    final response = await _api.post("get_bbox_info", body, options: Options(headers: {"session": session}));

    final ret = response.when(success: (data){

      final resp = jsonDecode(data.data);
      // debugPrint("====================");
      // debugPrint("RRESP:::::: $resp");
      return resp;
    }, error: (e) {
      throw HttpException("[ERROR]:: getBookboxInfo api Error", uri: Uri(path: "get_bbox_info"));
    });

    return ret;
  }

  Future<void> progressStatus(String rsq, String msq, String currentStatus) async {
    final session = await _tokenRepository.getSession();
    late final todr;
    switch(currentStatus){
      case "A":
        todr = 0;
        break;
      case "B":
        todr = 1;
        break;
      case "C":
        todr = 2;
        break;
      case "D": //E(반납대기)는 버튼이 아니라 반납 시간이 됬을때 자동으로 바뀌어야 해서 일단 보류
        todr = 4;
        break;
      case "E":
        todr = 4;
        break;
      case "F":
        todr = 5;
        break;
      default:
        todr = 7;
        break;
    }

    FormData body = FormData.fromMap({
      "rst": currentStatus,
      "rsq": rsq,
      "msq": msq,
      "todr": todr,
      "chk": "Y",
      });
    final response = await _api.post("rental_confirm", body, options: Options(headers: {"session": session}));
    final ret = response.when(success: (data){

      final resp = jsonDecode(data.data);
      debugPrint("====================");
      debugPrint("RRESP:::::: $resp");
      return resp;
    }, error: (e) {
      throw HttpException("[ERROR]:: progressStatus api Error", uri: Uri(path: "rental_confirm"));
    });
    
    return ret;
  }

  Future<void> resetStatus(String rsq, String msq, String currentStatus) async {
    final session = await _tokenRepository.getSession();
    const todr = "-1";

    FormData body = FormData.fromMap({
      "rst": currentStatus,
      "rsq": rsq,
      "msq": msq,
      "todr": todr,
      "chk": "Y",
      });
    final response = await _api.post("rental_confirm", body, options: Options(headers: {"session": session}));
    final ret = response.when(success: (data){

      final resp = jsonDecode(data.data);
      return resp;
    }, error: (e) {
      throw HttpException("[ERROR]:: resetStatus api Error", uri: Uri(path: "rental_confirm"));
    });
    
    return ret;
  }
}