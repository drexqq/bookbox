import 'package:bookbox/domain/user/repository/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = ChangeNotifierProvider((ref) => UserNotifier(ref));

class UserNotifier extends ChangeNotifier {
  UserNotifier(this._ref) : super();
  final Ref _ref;
  late final UserRepository _repository = _ref.read(userRepositoryProvider);

  Future getUserInfo() async {
    return await _repository.getUserInfo();
  }

  Future rechargePoint(String point) async {
    if (point == "" || !isNumeric(point)) {
      return false;
    }
    return await _repository.rechargePoint(int.parse(point));
  }

  Future getPoint() async {
    return await _repository.getPoint();
  }

  Future getScanLibrary() async {
    return await _repository.getScanLibrary();
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }
}
