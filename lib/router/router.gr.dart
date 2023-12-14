// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i22;
import 'package:bookbox/domain/app/app_root.dart' as _i1;
import 'package:bookbox/domain/app/views/home_view.dart' as _i15;
import 'package:bookbox/domain/auth/login_view.dart' as _i16;
import 'package:bookbox/domain/auth/phone_auth_view.dart' as _i17;
import 'package:bookbox/domain/book/book_scan_detail_view.dart' as _i2;
import 'package:bookbox/domain/book/book_scan_history_view.dart' as _i3;
import 'package:bookbox/domain/book/book_scan_pdf_view.dart' as _i4;
import 'package:bookbox/domain/book/book_scan_regist_done_view.dart' as _i5;
import 'package:bookbox/domain/book/book_scan_regist_view.dart' as _i6;
import 'package:bookbox/domain/book/book_scan_view.dart' as _i7;
import 'package:bookbox/domain/book/model/book.dart' as _i25;
import 'package:bookbox/domain/book/model/search_book.dart' as _i24;
import 'package:bookbox/domain/chat/chat_view.dart' as _i8;
import 'package:bookbox/domain/chat/review_view.dart' as _i18;
import 'package:bookbox/domain/deal/deal_detail_view.dart' as _i9;
import 'package:bookbox/domain/deal/deal_list_view.dart' as _i10;
import 'package:bookbox/domain/deal/deal_order_page.dart' as _i11;
import 'package:bookbox/domain/deal/deal_regist_view.dart' as _i13;
import 'package:bookbox/domain/deal/deal_store_select_view.dart' as _i14;
import 'package:bookbox/domain/deal/widget/deal_regist_select_book_view.dart'
    as _i12;
import 'package:bookbox/domain/user/user_book_regist_select_view.dart' as _i19;
import 'package:bookbox/domain/user/user_book_regist_view.dart' as _i20;
import 'package:bookbox/domain/user/user_setting_view.dart' as _i21;
import 'package:flutter/material.dart' as _i23;

abstract class $AppRouter extends _i22.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i22.PageFactory> pagesMap = {
    AppRootRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AppRoot(),
      );
    },
    BookScanDetailViewRoute.name: (routeData) {
      final args = routeData.argsAs<BookScanDetailViewRouteArgs>();
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BookScanDetailView(
          key: args.key,
          book: args.book,
        ),
      );
    },
    BookScanHistoryViewRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BookScanHistoryView(),
      );
    },
    BookScanPdfViewRoute.name: (routeData) {
      final args = routeData.argsAs<BookScanPdfViewRouteArgs>();
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.BookScanPdfView(
          key: args.key,
          title: args.title,
          path: args.path,
          filename: args.filename,
        ),
      );
    },
    BookScanRegistDoneViewRoute.name: (routeData) {
      final args = routeData.argsAs<BookScanRegistDoneViewRouteArgs>();
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.BookScanRegistDoneView(
          key: args.key,
          image: args.image,
        ),
      );
    },
    BookScanRegistViewRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.BookScanRegistView(),
      );
    },
    BookScanViewRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.BookScanView(),
      );
    },
    ChatViewRoute.name: (routeData) {
      final args = routeData.argsAs<ChatViewRouteArgs>();
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.ChatView(
          key: args.key,
          dealId: args.dealId,
          row: args.row,
        ),
      );
    },
    DealDetailViewRoute.name: (routeData) {
      final args = routeData.argsAs<DealDetailViewRouteArgs>();
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.DealDetailView(
          key: args.key,
          id: args.id,
        ),
      );
    },
    DealListViewRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.DealListView(),
      );
    },
    DealOrderPageRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.DealOrderPage(),
      );
    },
    DealRegistSelectBookViewRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.DealRegistSelectBookView(),
      );
    },
    DealRegistViewRoute.name: (routeData) {
      final args = routeData.argsAs<DealRegistViewRouteArgs>();
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.DealRegistView(
          key: args.key,
          book: args.book,
        ),
      );
    },
    DealStoreSelectViewRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.DealStoreSelectView(),
      );
    },
    HomeViewRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.HomeView(),
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.LoginView(),
      );
    },
    PhoneAuthViewRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.PhoneAuthView(),
      );
    },
    ReviewViewRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.ReviewView(),
      );
    },
    UserBookRegistSelectViewRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.UserBookRegistSelectView(),
      );
    },
    UserBookRegistViewRoute.name: (routeData) {
      final args = routeData.argsAs<UserBookRegistViewRouteArgs>(
          orElse: () => const UserBookRegistViewRouteArgs());
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.UserBookRegistView(
          key: args.key,
          code: args.code,
        ),
      );
    },
    UserSettingViewRoute.name: (routeData) {
      return _i22.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.UserSettingView(),
      );
    },
  };
}

/// generated route for
/// [_i1.AppRoot]
class AppRootRoute extends _i22.PageRouteInfo<void> {
  const AppRootRoute({List<_i22.PageRouteInfo>? children})
      : super(
          AppRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRootRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BookScanDetailView]
class BookScanDetailViewRoute
    extends _i22.PageRouteInfo<BookScanDetailViewRouteArgs> {
  BookScanDetailViewRoute({
    _i23.Key? key,
    required _i24.SearchBook book,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          BookScanDetailViewRoute.name,
          args: BookScanDetailViewRouteArgs(
            key: key,
            book: book,
          ),
          initialChildren: children,
        );

  static const String name = 'BookScanDetailViewRoute';

  static const _i22.PageInfo<BookScanDetailViewRouteArgs> page =
      _i22.PageInfo<BookScanDetailViewRouteArgs>(name);
}

class BookScanDetailViewRouteArgs {
  const BookScanDetailViewRouteArgs({
    this.key,
    required this.book,
  });

  final _i23.Key? key;

  final _i24.SearchBook book;

  @override
  String toString() {
    return 'BookScanDetailViewRouteArgs{key: $key, book: $book}';
  }
}

/// generated route for
/// [_i3.BookScanHistoryView]
class BookScanHistoryViewRoute extends _i22.PageRouteInfo<void> {
  const BookScanHistoryViewRoute({List<_i22.PageRouteInfo>? children})
      : super(
          BookScanHistoryViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookScanHistoryViewRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i4.BookScanPdfView]
class BookScanPdfViewRoute
    extends _i22.PageRouteInfo<BookScanPdfViewRouteArgs> {
  BookScanPdfViewRoute({
    _i23.Key? key,
    required String title,
    required String path,
    required String filename,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          BookScanPdfViewRoute.name,
          args: BookScanPdfViewRouteArgs(
            key: key,
            title: title,
            path: path,
            filename: filename,
          ),
          initialChildren: children,
        );

  static const String name = 'BookScanPdfViewRoute';

  static const _i22.PageInfo<BookScanPdfViewRouteArgs> page =
      _i22.PageInfo<BookScanPdfViewRouteArgs>(name);
}

class BookScanPdfViewRouteArgs {
  const BookScanPdfViewRouteArgs({
    this.key,
    required this.title,
    required this.path,
    required this.filename,
  });

  final _i23.Key? key;

  final String title;

  final String path;

  final String filename;

  @override
  String toString() {
    return 'BookScanPdfViewRouteArgs{key: $key, title: $title, path: $path, filename: $filename}';
  }
}

/// generated route for
/// [_i5.BookScanRegistDoneView]
class BookScanRegistDoneViewRoute
    extends _i22.PageRouteInfo<BookScanRegistDoneViewRouteArgs> {
  BookScanRegistDoneViewRoute({
    _i23.Key? key,
    required String image,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          BookScanRegistDoneViewRoute.name,
          args: BookScanRegistDoneViewRouteArgs(
            key: key,
            image: image,
          ),
          initialChildren: children,
        );

  static const String name = 'BookScanRegistDoneViewRoute';

  static const _i22.PageInfo<BookScanRegistDoneViewRouteArgs> page =
      _i22.PageInfo<BookScanRegistDoneViewRouteArgs>(name);
}

class BookScanRegistDoneViewRouteArgs {
  const BookScanRegistDoneViewRouteArgs({
    this.key,
    required this.image,
  });

  final _i23.Key? key;

  final String image;

  @override
  String toString() {
    return 'BookScanRegistDoneViewRouteArgs{key: $key, image: $image}';
  }
}

/// generated route for
/// [_i6.BookScanRegistView]
class BookScanRegistViewRoute extends _i22.PageRouteInfo<void> {
  const BookScanRegistViewRoute({List<_i22.PageRouteInfo>? children})
      : super(
          BookScanRegistViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookScanRegistViewRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i7.BookScanView]
class BookScanViewRoute extends _i22.PageRouteInfo<void> {
  const BookScanViewRoute({List<_i22.PageRouteInfo>? children})
      : super(
          BookScanViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookScanViewRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ChatView]
class ChatViewRoute extends _i22.PageRouteInfo<ChatViewRouteArgs> {
  ChatViewRoute({
    _i23.Key? key,
    required dynamic dealId,
    required Map<String, dynamic> row,
    List<_i22.PageRouteInfo>? children,
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

  static const _i22.PageInfo<ChatViewRouteArgs> page =
      _i22.PageInfo<ChatViewRouteArgs>(name);
}

class ChatViewRouteArgs {
  const ChatViewRouteArgs({
    this.key,
    required this.dealId,
    required this.row,
  });

  final _i23.Key? key;

  final dynamic dealId;

  final Map<String, dynamic> row;

  @override
  String toString() {
    return 'ChatViewRouteArgs{key: $key, dealId: $dealId, row: $row}';
  }
}

/// generated route for
/// [_i9.DealDetailView]
class DealDetailViewRoute extends _i22.PageRouteInfo<DealDetailViewRouteArgs> {
  DealDetailViewRoute({
    _i23.Key? key,
    required String id,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          DealDetailViewRoute.name,
          args: DealDetailViewRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'DealDetailViewRoute';

  static const _i22.PageInfo<DealDetailViewRouteArgs> page =
      _i22.PageInfo<DealDetailViewRouteArgs>(name);
}

class DealDetailViewRouteArgs {
  const DealDetailViewRouteArgs({
    this.key,
    required this.id,
  });

  final _i23.Key? key;

  final String id;

  @override
  String toString() {
    return 'DealDetailViewRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i10.DealListView]
class DealListViewRoute extends _i22.PageRouteInfo<void> {
  const DealListViewRoute({List<_i22.PageRouteInfo>? children})
      : super(
          DealListViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealListViewRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i11.DealOrderPage]
class DealOrderPageRoute extends _i22.PageRouteInfo<void> {
  const DealOrderPageRoute({List<_i22.PageRouteInfo>? children})
      : super(
          DealOrderPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealOrderPageRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i12.DealRegistSelectBookView]
class DealRegistSelectBookViewRoute extends _i22.PageRouteInfo<void> {
  const DealRegistSelectBookViewRoute({List<_i22.PageRouteInfo>? children})
      : super(
          DealRegistSelectBookViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealRegistSelectBookViewRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i13.DealRegistView]
class DealRegistViewRoute extends _i22.PageRouteInfo<DealRegistViewRouteArgs> {
  DealRegistViewRoute({
    _i23.Key? key,
    required _i25.Book book,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          DealRegistViewRoute.name,
          args: DealRegistViewRouteArgs(
            key: key,
            book: book,
          ),
          initialChildren: children,
        );

  static const String name = 'DealRegistViewRoute';

  static const _i22.PageInfo<DealRegistViewRouteArgs> page =
      _i22.PageInfo<DealRegistViewRouteArgs>(name);
}

class DealRegistViewRouteArgs {
  const DealRegistViewRouteArgs({
    this.key,
    required this.book,
  });

  final _i23.Key? key;

  final _i25.Book book;

  @override
  String toString() {
    return 'DealRegistViewRouteArgs{key: $key, book: $book}';
  }
}

/// generated route for
/// [_i14.DealStoreSelectView]
class DealStoreSelectViewRoute extends _i22.PageRouteInfo<void> {
  const DealStoreSelectViewRoute({List<_i22.PageRouteInfo>? children})
      : super(
          DealStoreSelectViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealStoreSelectViewRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i15.HomeView]
class HomeViewRoute extends _i22.PageRouteInfo<void> {
  const HomeViewRoute({List<_i22.PageRouteInfo>? children})
      : super(
          HomeViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeViewRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i16.LoginView]
class LoginViewRoute extends _i22.PageRouteInfo<void> {
  const LoginViewRoute({List<_i22.PageRouteInfo>? children})
      : super(
          LoginViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginViewRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i17.PhoneAuthView]
class PhoneAuthViewRoute extends _i22.PageRouteInfo<void> {
  const PhoneAuthViewRoute({List<_i22.PageRouteInfo>? children})
      : super(
          PhoneAuthViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneAuthViewRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i18.ReviewView]
class ReviewViewRoute extends _i22.PageRouteInfo<void> {
  const ReviewViewRoute({List<_i22.PageRouteInfo>? children})
      : super(
          ReviewViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReviewViewRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i19.UserBookRegistSelectView]
class UserBookRegistSelectViewRoute extends _i22.PageRouteInfo<void> {
  const UserBookRegistSelectViewRoute({List<_i22.PageRouteInfo>? children})
      : super(
          UserBookRegistSelectViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserBookRegistSelectViewRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}

/// generated route for
/// [_i20.UserBookRegistView]
class UserBookRegistViewRoute
    extends _i22.PageRouteInfo<UserBookRegistViewRouteArgs> {
  UserBookRegistViewRoute({
    _i23.Key? key,
    String? code,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          UserBookRegistViewRoute.name,
          args: UserBookRegistViewRouteArgs(
            key: key,
            code: code,
          ),
          initialChildren: children,
        );

  static const String name = 'UserBookRegistViewRoute';

  static const _i22.PageInfo<UserBookRegistViewRouteArgs> page =
      _i22.PageInfo<UserBookRegistViewRouteArgs>(name);
}

class UserBookRegistViewRouteArgs {
  const UserBookRegistViewRouteArgs({
    this.key,
    this.code,
  });

  final _i23.Key? key;

  final String? code;

  @override
  String toString() {
    return 'UserBookRegistViewRouteArgs{key: $key, code: $code}';
  }
}

/// generated route for
/// [_i21.UserSettingView]
class UserSettingViewRoute extends _i22.PageRouteInfo<void> {
  const UserSettingViewRoute({List<_i22.PageRouteInfo>? children})
      : super(
          UserSettingViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserSettingViewRoute';

  static const _i22.PageInfo<void> page = _i22.PageInfo<void>(name);
}
