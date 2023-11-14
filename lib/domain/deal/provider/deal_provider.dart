import 'package:bookbox/domain/deal/model/book_deal.dart';
import 'package:bookbox/domain/deal/repository/deal_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dealNotifierProvider =
    ChangeNotifierProvider<DealNotifier>((ref) => DealNotifier(ref));

class DealNotifier extends ChangeNotifier {
  DealNotifier(this._ref) : super();
  final Ref _ref;

  late final DealRepository _repository = _ref.read(dealRepositoryProvider);
  late final DealRegistNotifier _registProvider = _ref.read(dealRegistProvider);

  Future<List<BookDeal>> getDeals() async {
    return await _repository.getDeals();
  }

  Future<dynamic> registDeal() async {
    final data = {
      // "book": _registProvider.id,
      "book": "148",
      "B_QULITY": _registProvider.quality,
      "B_RENTAL_DAY": _registProvider.day,
      "B_RENTAL_FEE": _registProvider.fee,
      "B_READ_LEVEL": _registProvider.level,
      "B_RATING[]": _registProvider.rating,
      "B_DESCRIPTION": _registProvider.desc,
      "B_STORE_SEQ": "1",
      "B_STORE_POSITION": "123.12345;;123.12345",
      "B_STORE_ADDRESS": "매장주소",
    };
    if (_registProvider.img.isNotEmpty) {
      int index = 0;
      for (final img in _registProvider.img) {
        data["B_MEM_IMGS_${index + 1}"] = img;
      }
    }
    FormData formData = FormData.fromMap(data);

    return await _repository.registDeal(formData);
  }
}

final dealRegistProvider = ChangeNotifierProvider((_) => DealRegistNotifier());

class DealRegistNotifier extends ChangeNotifier {
  DealRegistNotifier() : super();

  String? id;
  void setId(String? value) {
    id = value;
    notifyListeners();
  }

  List img = [];
  void setImg(List imgs) {
    img = imgs;
    notifyListeners();
  }

  String quality = "S";
  void setQuality(String value) {
    quality = value;
    notifyListeners();
  }

  String? day;
  void setDay(String? value) {
    day = value;
    notifyListeners();
  }

  String? fee;
  void setFee(String? value) {
    fee = value;
    notifyListeners();
  }

  String level = "A";
  void setLevel(String value) {
    level = value;
    notifyListeners();
  }

  List<int> rating = [0, 0, 0, 0, 0, 0];
  void setRating(int index, int value) {
    rating[index] = value;
    notifyListeners();
  }

  void clearRating() {
    rating = [0, 0, 0, 0, 0, 0];
    notifyListeners();
  }

  String? desc;
  void setDesc(String? value) {
    desc = value;
    notifyListeners();
  }

  String? pos;
  void setPos(String value) {
    pos = value;
    notifyListeners();
  }

  String? address;
  void setAddress(String value) {
    address = value;
    notifyListeners();
  }
}
