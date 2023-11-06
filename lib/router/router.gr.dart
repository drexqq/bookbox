// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:bookbox/domain/app/app_root.dart' as _i1;
import 'package:bookbox/domain/app/views/home_view.dart' as _i6;
import 'package:bookbox/domain/auth/login_view.dart' as _i7;
import 'package:bookbox/domain/auth/phone_auth_view.dart' as _i8;
import 'package:bookbox/domain/book/model/book.dart' as _i13;
import 'package:bookbox/domain/deal/deal_detail_view.dart' as _i2;
import 'package:bookbox/domain/deal/deal_list_view.dart' as _i3;
import 'package:bookbox/domain/deal/deal_regist_view.dart' as _i5;
import 'package:bookbox/domain/deal/widget/deal_regist_select_book_view.dart'
    as _i4;
import 'package:bookbox/domain/user/user_book_regist_view.dart' as _i9;
import 'package:bookbox/domain/user/user_setting_view.dart' as _i10;
import 'package:flutter/material.dart' as _i12;

abstract class $AppRouter extends _i11.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    AppRootRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AppRoot(),
      );
    },
    DealDetailViewRoute.name: (routeData) {
      final args = routeData.argsAs<DealDetailViewRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.DealDetailView(
          key: args.key,
          id: args.id,
        ),
      );
    },
    DealListViewRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.DealListView(),
      );
    },
    DealRegistSelectBookViewRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.DealRegistSelectBookView(),
      );
    },
    DealRegistViewRoute.name: (routeData) {
      final args = routeData.argsAs<DealRegistViewRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.DealRegistView(
          key: args.key,
          book: args.book,
        ),
      );
    },
    HomeViewRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomeView(),
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoginView(),
      );
    },
    PhoneAuthViewRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.PhoneAuthView(),
      );
    },
    UserBookRegistViewRoute.name: (routeData) {
      final args = routeData.argsAs<UserBookRegistViewRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.UserBookRegistView(
          key: args.key,
          notifyParent: args.notifyParent,
        ),
      );
    },
    UserSettingViewRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.UserSettingView(),
      );
    },
  };
}

/// generated route for
/// [_i1.AppRoot]
class AppRootRoute extends _i11.PageRouteInfo<void> {
  const AppRootRoute({List<_i11.PageRouteInfo>? children})
      : super(
          AppRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRootRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DealDetailView]
class DealDetailViewRoute extends _i11.PageRouteInfo<DealDetailViewRouteArgs> {
  DealDetailViewRoute({
    _i12.Key? key,
    required String id,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          DealDetailViewRoute.name,
          args: DealDetailViewRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'DealDetailViewRoute';

  static const _i11.PageInfo<DealDetailViewRouteArgs> page =
      _i11.PageInfo<DealDetailViewRouteArgs>(name);
}

class DealDetailViewRouteArgs {
  const DealDetailViewRouteArgs({
    this.key,
    required this.id,
  });

  final _i12.Key? key;

  final String id;

  @override
  String toString() {
    return 'DealDetailViewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i3.DealListView]
class DealListViewRoute extends _i11.PageRouteInfo<void> {
  const DealListViewRoute({List<_i11.PageRouteInfo>? children})
      : super(
          DealListViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealListViewRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i4.DealRegistSelectBookView]
class DealRegistSelectBookViewRoute extends _i11.PageRouteInfo<void> {
  const DealRegistSelectBookViewRoute({List<_i11.PageRouteInfo>? children})
      : super(
          DealRegistSelectBookViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealRegistSelectBookViewRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i5.DealRegistView]
class DealRegistViewRoute extends _i11.PageRouteInfo<DealRegistViewRouteArgs> {
  DealRegistViewRoute({
    _i12.Key? key,
    required _i13.Book book,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          DealRegistViewRoute.name,
          args: DealRegistViewRouteArgs(
            key: key,
            book: book,
          ),
          initialChildren: children,
        );

  static const String name = 'DealRegistViewRoute';

  static const _i11.PageInfo<DealRegistViewRouteArgs> page =
      _i11.PageInfo<DealRegistViewRouteArgs>(name);
}

class DealRegistViewRouteArgs {
  const DealRegistViewRouteArgs({
    this.key,
    required this.book,
  });

  final _i12.Key? key;

  final _i13.Book book;

  @override
  String toString() {
    return 'DealRegistViewRouteArgs{key: $key, book: $book}';
  }
}

/// generated route for
/// [_i6.HomeView]
class HomeViewRoute extends _i11.PageRouteInfo<void> {
  const HomeViewRoute({List<_i11.PageRouteInfo>? children})
      : super(
          HomeViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeViewRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LoginView]
class LoginViewRoute extends _i11.PageRouteInfo<void> {
  const LoginViewRoute({List<_i11.PageRouteInfo>? children})
      : super(
          LoginViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginViewRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i8.PhoneAuthView]
class PhoneAuthViewRoute extends _i11.PageRouteInfo<void> {
  const PhoneAuthViewRoute({List<_i11.PageRouteInfo>? children})
      : super(
          PhoneAuthViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneAuthViewRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i9.UserBookRegistView]
class UserBookRegistViewRoute
    extends _i11.PageRouteInfo<UserBookRegistViewRouteArgs> {
  UserBookRegistViewRoute({
    _i12.Key? key,
    required void Function() notifyParent,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          UserBookRegistViewRoute.name,
          args: UserBookRegistViewRouteArgs(
            key: key,
            notifyParent: notifyParent,
          ),
          initialChildren: children,
        );

  static const String name = 'UserBookRegistViewRoute';

  static const _i11.PageInfo<UserBookRegistViewRouteArgs> page =
      _i11.PageInfo<UserBookRegistViewRouteArgs>(name);
}

class UserBookRegistViewRouteArgs {
  const UserBookRegistViewRouteArgs({
    this.key,
    required this.notifyParent,
  });

  final _i12.Key? key;

  final void Function() notifyParent;

  @override
  String toString() {
    return 'UserBookRegistViewRouteArgs{key: $key, notifyParent: $notifyParent}';
  }
}

/// generated route for
/// [_i10.UserSettingView]
class UserSettingViewRoute extends _i11.PageRouteInfo<void> {
  const UserSettingViewRoute({List<_i11.PageRouteInfo>? children})
      : super(
          UserSettingViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserSettingViewRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}
