// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:bookbox/domain/app/app_root.dart' as _i1;
import 'package:bookbox/domain/app/views/home_view.dart' as _i9;
import 'package:bookbox/domain/auth/login_view.dart' as _i10;
import 'package:bookbox/domain/auth/phone_auth_view.dart' as _i11;
import 'package:bookbox/domain/book/model/book.dart' as _i16;
import 'package:bookbox/domain/chat/chat_view.dart' as _i2;
import 'package:bookbox/domain/deal/deal_detail_view.dart' as _i3;
import 'package:bookbox/domain/deal/deal_list_view.dart' as _i4;
import 'package:bookbox/domain/deal/deal_order_page.dart' as _i5;
import 'package:bookbox/domain/deal/deal_regist_view.dart' as _i7;
import 'package:bookbox/domain/deal/deal_store_select_view.dart' as _i8;
import 'package:bookbox/domain/deal/widget/deal_regist_select_book_view.dart'
    as _i6;
import 'package:bookbox/domain/user/user_book_regist_view.dart' as _i12;
import 'package:bookbox/domain/user/user_setting_view.dart' as _i13;
import 'package:flutter/material.dart' as _i15;

abstract class $AppRouter extends _i14.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    AppRootRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AppRoot(),
      );
    },
    ChatViewRoute.name: (routeData) {
      final args = routeData.argsAs<ChatViewRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ChatView(
          key: args.key,
          dealId: args.dealId,
        ),
      );
    },
    DealDetailViewRoute.name: (routeData) {
      final args = routeData.argsAs<DealDetailViewRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.DealDetailView(
          key: args.key,
          id: args.id,
        ),
      );
    },
    DealListViewRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.DealListView(),
      );
    },
    DealOrderPageRoute.name: (routeData) {
      final args = routeData.argsAs<DealOrderPageRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.DealOrderPage(
          key: args.key,
          fee: args.fee,
          day: args.day,
        ),
      );
    },
    DealRegistSelectBookViewRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.DealRegistSelectBookView(),
      );
    },
    DealRegistViewRoute.name: (routeData) {
      final args = routeData.argsAs<DealRegistViewRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.DealRegistView(
          key: args.key,
          book: args.book,
        ),
      );
    },
    DealStoreSelectViewRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.DealStoreSelectView(),
      );
    },
    HomeViewRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.HomeView(),
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LoginView(),
      );
    },
    PhoneAuthViewRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.PhoneAuthView(),
      );
    },
    UserBookRegistViewRoute.name: (routeData) {
      final args = routeData.argsAs<UserBookRegistViewRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.UserBookRegistView(
          key: args.key,
          notifyParent: args.notifyParent,
        ),
      );
    },
    UserSettingViewRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.UserSettingView(),
      );
    },
  };
}

/// generated route for
/// [_i1.AppRoot]
class AppRootRoute extends _i14.PageRouteInfo<void> {
  const AppRootRoute({List<_i14.PageRouteInfo>? children})
      : super(
          AppRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRootRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChatView]
class ChatViewRoute extends _i14.PageRouteInfo<ChatViewRouteArgs> {
  ChatViewRoute({
    _i15.Key? key,
    required dynamic dealId,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          ChatViewRoute.name,
          args: ChatViewRouteArgs(
            key: key,
            dealId: dealId,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatViewRoute';

  static const _i14.PageInfo<ChatViewRouteArgs> page =
      _i14.PageInfo<ChatViewRouteArgs>(name);
}

class ChatViewRouteArgs {
  const ChatViewRouteArgs({
    this.key,
    required this.dealId,
  });

  final _i15.Key? key;

  final dynamic dealId;

  @override
  String toString() {
    return 'ChatViewRouteArgs{key: $key, dealId: $dealId}';
  }
}

/// generated route for
/// [_i3.DealDetailView]
class DealDetailViewRoute extends _i14.PageRouteInfo<DealDetailViewRouteArgs> {
  DealDetailViewRoute({
    _i15.Key? key,
    required String id,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          DealDetailViewRoute.name,
          args: DealDetailViewRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'DealDetailViewRoute';

  static const _i14.PageInfo<DealDetailViewRouteArgs> page =
      _i14.PageInfo<DealDetailViewRouteArgs>(name);
}

class DealDetailViewRouteArgs {
  const DealDetailViewRouteArgs({
    this.key,
    required this.id,
  });

  final _i15.Key? key;

  final String id;

  @override
  String toString() {
    return 'DealDetailViewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i4.DealListView]
class DealListViewRoute extends _i14.PageRouteInfo<void> {
  const DealListViewRoute({List<_i14.PageRouteInfo>? children})
      : super(
          DealListViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealListViewRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DealOrderPage]
class DealOrderPageRoute extends _i14.PageRouteInfo<DealOrderPageRouteArgs> {
  DealOrderPageRoute({
    _i15.Key? key,
    required int fee,
    required int day,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          DealOrderPageRoute.name,
          args: DealOrderPageRouteArgs(
            key: key,
            fee: fee,
            day: day,
          ),
          initialChildren: children,
        );

  static const String name = 'DealOrderPageRoute';

  static const _i14.PageInfo<DealOrderPageRouteArgs> page =
      _i14.PageInfo<DealOrderPageRouteArgs>(name);
}

class DealOrderPageRouteArgs {
  const DealOrderPageRouteArgs({
    this.key,
    required this.fee,
    required this.day,
  });

  final _i15.Key? key;

  final int fee;

  final int day;

  @override
  String toString() {
    return 'DealOrderPageRouteArgs{key: $key, fee: $fee, day: $day}';
  }
}

/// generated route for
/// [_i6.DealRegistSelectBookView]
class DealRegistSelectBookViewRoute extends _i14.PageRouteInfo<void> {
  const DealRegistSelectBookViewRoute({List<_i14.PageRouteInfo>? children})
      : super(
          DealRegistSelectBookViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealRegistSelectBookViewRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i7.DealRegistView]
class DealRegistViewRoute extends _i14.PageRouteInfo<DealRegistViewRouteArgs> {
  DealRegistViewRoute({
    _i15.Key? key,
    required _i16.Book book,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          DealRegistViewRoute.name,
          args: DealRegistViewRouteArgs(
            key: key,
            book: book,
          ),
          initialChildren: children,
        );

  static const String name = 'DealRegistViewRoute';

  static const _i14.PageInfo<DealRegistViewRouteArgs> page =
      _i14.PageInfo<DealRegistViewRouteArgs>(name);
}

class DealRegistViewRouteArgs {
  const DealRegistViewRouteArgs({
    this.key,
    required this.book,
  });

  final _i15.Key? key;

  final _i16.Book book;

  @override
  String toString() {
    return 'DealRegistViewRouteArgs{key: $key, book: $book}';
  }
}

/// generated route for
/// [_i8.DealStoreSelectView]
class DealStoreSelectViewRoute extends _i14.PageRouteInfo<void> {
  const DealStoreSelectViewRoute({List<_i14.PageRouteInfo>? children})
      : super(
          DealStoreSelectViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealStoreSelectViewRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i9.HomeView]
class HomeViewRoute extends _i14.PageRouteInfo<void> {
  const HomeViewRoute({List<_i14.PageRouteInfo>? children})
      : super(
          HomeViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeViewRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i10.LoginView]
class LoginViewRoute extends _i14.PageRouteInfo<void> {
  const LoginViewRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LoginViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginViewRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i11.PhoneAuthView]
class PhoneAuthViewRoute extends _i14.PageRouteInfo<void> {
  const PhoneAuthViewRoute({List<_i14.PageRouteInfo>? children})
      : super(
          PhoneAuthViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneAuthViewRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i12.UserBookRegistView]
class UserBookRegistViewRoute
    extends _i14.PageRouteInfo<UserBookRegistViewRouteArgs> {
  UserBookRegistViewRoute({
    _i15.Key? key,
    required void Function() notifyParent,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          UserBookRegistViewRoute.name,
          args: UserBookRegistViewRouteArgs(
            key: key,
            notifyParent: notifyParent,
          ),
          initialChildren: children,
        );

  static const String name = 'UserBookRegistViewRoute';

  static const _i14.PageInfo<UserBookRegistViewRouteArgs> page =
      _i14.PageInfo<UserBookRegistViewRouteArgs>(name);
}

class UserBookRegistViewRouteArgs {
  const UserBookRegistViewRouteArgs({
    this.key,
    required this.notifyParent,
  });

  final _i15.Key? key;

  final void Function() notifyParent;

  @override
  String toString() {
    return 'UserBookRegistViewRouteArgs{key: $key, notifyParent: $notifyParent}';
  }
}

/// generated route for
/// [_i13.UserSettingView]
class UserSettingViewRoute extends _i14.PageRouteInfo<void> {
  const UserSettingViewRoute({List<_i14.PageRouteInfo>? children})
      : super(
          UserSettingViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserSettingViewRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}
