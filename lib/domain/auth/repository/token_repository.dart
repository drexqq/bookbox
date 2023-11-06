import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum StoreKey {
  seq,
  session,
  fcm,
}

abstract class TokenRepositoryProtocol {
  Future<void> saveSeq(String seq);
  Future<String?> getSeq();
  Future<void> saveSession(String session);
  Future<String?> getSession();
  Future<void> removeSeq();
}

final tokenRepositoryProvider = Provider((_) => TokenRepository());

class TokenRepository implements TokenRepositoryProtocol {
  TokenRepository();

  final storage = const FlutterSecureStorage();

  @override
  Future<void> saveSeq(String seq) async {
    try {
      await storage.write(key: StoreKey.seq.name, value: seq);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String?> getSeq() async {
    try {
      return await storage.read(key: StoreKey.seq.name);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> saveSession(String session) async {
    try {
      await storage.write(key: StoreKey.session.name, value: session);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String?> getSession() async {
    try {
      final session = await storage.read(key: StoreKey.session.name);
      print(session);
      return session;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> removeSeq() async {
    try {
      await storage.delete(key: StoreKey.seq.name);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
