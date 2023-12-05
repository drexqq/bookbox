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

  Future<List<BookDeal>> searchDeals(String kwd) async {
    return await _repository.searchDeals(kwd);
  }

  Future<BookDeal?> getDealDetail(int seq) async {
    return await _repository.getDealDetail(seq);
  }

  Future<bool> registDeal() async {
    if (_registProvider.img.isEmpty ||
        _registProvider.fee == null ||
        _registProvider.fee == "" ||
        _registProvider.day == null ||
        _registProvider.day == "") {
      return false;
    }
    final data = {
      "book": _registProvider.id,
      "B_QULITY": _registProvider.quality,
      "B_RENTAL_DAY": _registProvider.day,
      "B_RENTAL_FEE": _registProvider.fee,
      "B_READ_LEVEL": _registProvider.level,
      "B_RATING[]": _registProvider.rating,
      "B_DESCRIPTION": _registProvider.desc ?? "",
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

  Future<bool> requestDeal() async {
    final provider = _ref.read(dealRequestProvider);

    return await _repository.requestDeal({
      "b_deal_seq": provider.dealSeq,
      "B_RENTAL_FEE": provider.rentalFee,
      "B_STORE_NAME": provider.storeName,
      "B_STORE_SEQ": provider.storeId,
      "B_STORE_POSITION": provider.storePosition,
      "B_STORE_ADDRESS": provider.storeAddress,
      "B_PERIOD_START": provider.startDate,
      "B_PERIOD_END": provider.endDate,
      "B_RETURN_TIME": "20:30",
    });
  }

  Future getStores() async {
    return await _repository.getStores();
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

final dealRequestProvider =
    ChangeNotifierProvider((_) => DealRequestNotifier());

class DealRequestNotifier extends ChangeNotifier {
  DealRequestNotifier() : super();

  String? dealSeq;
  void setDealSeq(String? value) {
    dealSeq = value;
    print("setDealSeq: $dealSeq");
    notifyListeners();
  }

  String? fee;
  void setFee(String? value) {
    fee = value;
    print("setFee: $fee");
    notifyListeners();
  }

  String? rentalFee;
  void setRentalFee(String? value) {
    rentalFee = value;
    print("setRentalFee: $rentalFee");

    notifyListeners();
  }

  String? day;
  void setDay(String? value) {
    day = value;
    print("setDay: $day");

    notifyListeners();
  }

  String? rentalDay;
  void setRentalDay(String? value) {
    rentalDay = value;
    print("setRentalDay: $rentalDay");

    notifyListeners();
  }

  String? startDate;
  void setStartDate(String? value) {
    String? str;
    if (value != null) {
      final arr = value.split(" ");
      str = arr.first;
    } else {
      str = value;
    }
    startDate = str;
    print("setStartDate: $startDate");

    notifyListeners();
  }

  String? endDate;
  void setEndDate(String? value) {
    String? str;
    if (value != null) {
      final arr = value.split(" ");
      str = arr.first;
    } else {
      str = value;
    }
    endDate = str;
    print("setEndDate: $endDate");

    notifyListeners();
  }

  String? storeId;
  void setStoreId(String? value) {
    storeId = value;
    print("setStoreId: $storeId");
    notifyListeners();
  }

  String? storeName;
  void setStoreName(String? value) {
    storeName = value;
    print("setStoreName: $storeName");

    notifyListeners();
  }

  String? storePosition;
  void setStorePosition(String? value) {
    storePosition = value;
    print("setStorePosition: $storePosition");

    notifyListeners();
  }

  String? storeAddress;
  void setStoreAddress(String? value) {
    storeAddress = value;
    print("setStoreAddress: $storeAddress");

    notifyListeners();
  }

  void clear() {
    dealSeq = null;
    fee = null;
    rentalFee = null;
    day = null;
    startDate = null;
    rentalDay = null;
    startDate = null;
    endDate = null;
    storeId = null;
    storeName = null;
    storePosition = null;
    storeAddress = null;
    notifyListeners();
  }
}
