// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:bookbox/domain/app/app_root.dart' as _i1;
import 'package:bookbox/domain/app/views/home_view.dart' as _i10;
import 'package:bookbox/domain/auth/login_view.dart' as _i11;
import 'package:bookbox/domain/auth/phone_auth_view.dart' as _i12;
import 'package:bookbox/domain/book/book_scan_view.dart' as _i2;
import 'package:bookbox/domain/book/model/book.dart' as _i19;
import 'package:bookbox/domain/chat/chat_view.dart' as _i3;
import 'package:bookbox/domain/chat/review_view.dart' as _i13;
import 'package:bookbox/domain/deal/deal_detail_view.dart' as _i4;
import 'package:bookbox/domain/deal/deal_list_view.dart' as _i5;
import 'package:bookbox/domain/deal/deal_order_page.dart' as _i6;
import 'package:bookbox/domain/deal/deal_regist_view.dart' as _i8;
import 'package:bookbox/domain/deal/deal_store_select_view.dart' as _i9;
import 'package:bookbox/domain/deal/widget/deal_regist_select_book_view.dart'
    as _i7;
import 'package:bookbox/domain/user/user_book_regist_select_view.dart' as _i14;
import 'package:bookbox/domain/user/user_book_regist_view.dart' as _i15;
import 'package:bookbox/domain/user/user_setting_view.dart' as _i16;
import 'package:flutter/material.dart' as _i18;

abstract class $AppRouter extends _i17.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    AppRootRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AppRoot(),
      );
    },
    BookScanViewRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BookScanView(),
      );
    },
    ChatViewRoute.name: (routeData) {
      final args = routeData.argsAs<ChatViewRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.ChatView(
          key: args.key,
          dealId: args.dealId,
          row: args.row,
        ),
      );
    },
    DealDetailViewRoute.name: (routeData) {
      final args = routeData.argsAs<DealDetailViewRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.DealDetailView(
          key: args.key,
          id: args.id,
        ),
      );
    },
    DealListViewRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DealListView(),
      );
    },
    DealOrderPageRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.DealOrderPage(),
      );
    },
    DealRegistSelectBookViewRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.DealRegistSelectBookView(),
      );
    },
    DealRegistViewRoute.name: (routeData) {
      final args = routeData.argsAs<DealRegistViewRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.DealRegistView(
          key: args.key,
          book: args.book,
        ),
      );
    },
    DealStoreSelectViewRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.DealStoreSelectView(),
      );
    },
    HomeViewRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.HomeView(),
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.LoginView(),
      );
    },
    PhoneAuthViewRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.PhoneAuthView(),
      );
    },
    ReviewViewRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.ReviewView(),
      );
    },
    UserBookRegistSelectViewRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.UserBookRegistSelectView(),
      );
    },
    UserBookRegistViewRoute.name: (routeData) {
      final args = routeData.argsAs<UserBookRegistViewRouteArgs>(
          orElse: () => const UserBookRegistViewRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.UserBookRegistView(
          key: args.key,
          code: args.code,
        ),
      );
    },
    UserSettingViewRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.UserSettingView(),
      );
    },
  };
}

/// generated route for
/// [_i1.AppRoot]
class AppRootRoute extends _i17.PageRouteInfo<void> {
  const AppRootRoute({List<_i17.PageRouteInfo>? children})
      : super(
          AppRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRootRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BookScanView]
class BookScanViewRoute extends _i17.PageRouteInfo<void> {
  const BookScanViewRoute({List<_i17.PageRouteInfo>? children})
      : super(
          BookScanViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookScanViewRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ChatView]
class ChatViewRoute extends _i17.PageRouteInfo<ChatViewRouteArgs> {
  ChatViewRoute({
    _i18.Key? key,
    required dynamic dealId,
    required Map<String, dynamic> row,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          ChatViewRoute.name,
          args: ChatViewRouteArgs(
            key: key,
            dealId: dealId,
            row: row,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatViewRoute';

  static const _i17.PageInfo<ChatViewRouteArgs> page =
      _i17.PageInfo<ChatViewRouteArgs>(name);
}

class ChatViewRouteArgs {
  const ChatViewRouteArgs({
    this.key,
    required this.dealId,
    required this.row,
  });

  final _i18.Key? key;

  final dynamic dealId;

  final Map<String, dynamic> row;

  @override
  String toString() {
    return 'ChatViewRouteArgs{key: $key, dealId: $dealId, row: $row}';
  }
}

/// generated route for
/// [_i4.DealDetailView]
class DealDetailViewRoute extends _i17.PageRouteInfo<DealDetailViewRouteArgs> {
  DealDetailViewRoute({
    _i18.Key? key,
    required String id,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          DealDetailViewRoute.name,
          args: DealDetailViewRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'DealDetailViewRoute';

  static const _i17.PageInfo<DealDetailViewRouteArgs> page =
      _i17.PageInfo<DealDetailViewRouteArgs>(name);
}

class DealDetailViewRouteArgs {
  const DealDetailViewRouteArgs({
    this.key,
    required this.id,
  });

  final _i18.Key? key;

  final String id;

  @override
  String toString() {
    return 'DealDetailViewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i5.DealListView]
class DealListViewRoute extends _i17.PageRouteInfo<void> {
  const DealListViewRoute({List<_i17.PageRouteInfo>? children})
      : super(
          DealListViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealListViewRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i6.DealOrderPage]
class DealOrderPageRoute extends _i17.PageRouteInfo<void> {
  const DealOrderPageRoute({List<_i17.PageRouteInfo>? children})
      : super(
          DealOrderPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealOrderPageRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i7.DealRegistSelectBookView]
class DealRegistSelectBookViewRoute extends _i17.PageRouteInfo<void> {
  const DealRegistSelectBookViewRoute({List<_i17.PageRouteInfo>? children})
      : super(
          DealRegistSelectBookViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealRegistSelectBookViewRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i8.DealRegistView]
class DealRegistViewRoute extends _i17.PageRouteInfo<DealRegistViewRouteArgs> {
  DealRegistViewRoute({
    _i18.Key? key,
    required _i19.Book book,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          DealRegistViewRoute.name,
          args: DealRegistViewRouteArgs(
            key: key,
            book: book,
          ),
          initialChildren: children,
        );

  static const String name = 'DealRegistViewRoute';

  static const _i17.PageInfo<DealRegistViewRouteArgs> page =
      _i17.PageInfo<DealRegistViewRouteArgs>(name);
}

class DealRegistViewRouteArgs {
  const DealRegistViewRouteArgs({
    this.key,
    required this.book,
  });

  final _i18.Key? key;

  final _i19.Book book;

  @override
  String toString() {
    return 'DealRegistViewRouteArgs{key: $key, book: $book}';
  }
}

/// generated route for
/// [_i9.DealStoreSelectView]
class DealStoreSelectViewRoute extends _i17.PageRouteInfo<void> {
  const DealStoreSelectViewRoute({List<_i17.PageRouteInfo>? children})
      : super(
          DealStoreSelectViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealStoreSelectViewRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i10.HomeView]
class HomeViewRoute extends _i17.PageRouteInfo<void> {
  const HomeViewRoute({List<_i17.PageRouteInfo>? children})
      : super(
          HomeViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeViewRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i11.LoginView]
class LoginViewRoute extends _i17.PageRouteInfo<void> {
  const LoginViewRoute({List<_i17.PageRouteInfo>? children})
      : super(
          LoginViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginViewRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i12.PhoneAuthView]
class PhoneAuthViewRoute extends _i17.PageRouteInfo<void> {
  const PhoneAuthViewRoute({List<_i17.PageRouteInfo>? children})
      : super(
          PhoneAuthViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneAuthViewRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i13.ReviewView]
class ReviewViewRoute extends _i17.PageRouteInfo<void> {
  const ReviewViewRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ReviewViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReviewViewRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i14.UserBookRegistSelectView]
class UserBookRegistSelectViewRoute extends _i17.PageRouteInfo<void> {
  const UserBookRegistSelectViewRoute({List<_i17.PageRouteInfo>? children})
      : super(
          UserBookRegistSelectViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserBookRegistSelectViewRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i15.UserBookRegistView]
class UserBookRegistViewRoute
    extends _i17.PageRouteInfo<UserBookRegistViewRouteArgs> {
  UserBookRegistViewRoute({
    _i18.Key? key,
    String? code,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          UserBookRegistViewRoute.name,
          args: UserBookRegistViewRouteArgs(
            key: key,
            code: code,
          ),
          initialChildren: children,
        );

  static const String name = 'UserBookRegistViewRoute';

  static const _i17.PageInfo<UserBookRegistViewRouteArgs> page =
      _i17.PageInfo<UserBookRegistViewRouteArgs>(name);
}

class UserBookRegistViewRouteArgs {
  const UserBookRegistViewRouteArgs({
    this.key,
    this.code,
  });

  final _i18.Key? key;

  final String? code;

  @override
  String toString() {
    return 'UserBookRegistViewRouteArgs{key: $key, code: $code}';
  }
}

/// generated route for
/// [_i16.UserSettingView]
class UserSettingViewRoute extends _i17.PageRouteInfo<void> {
  const UserSettingViewRoute({List<_i17.PageRouteInfo>? children})
      : super(
          UserSettingViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserSettingViewRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}
