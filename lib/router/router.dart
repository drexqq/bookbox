// Flutter imports:
// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:bookbox/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "View")
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AppRootRoute.page, initial: true),
        AutoRoute(page: LoginViewRoute.page),
        AutoRoute(page: PhoneAuthViewRoute.page),
        AutoRoute(page: HomeViewRoute.page),
        AutoRoute(page: DealDetailViewRoute.page),
        AutoRoute(page: DealStoreSelectViewRoute.page),
        AutoRoute(page: DealOrderPageRoute.page),
        AutoRoute(page: DealRegistViewRoute.page),
        AutoRoute(page: DealRegistSelectBookViewRoute.page),
        AutoRoute(page: UserSettingViewRoute.page),
        AutoRoute(page: UserBookRegistSelectViewRoute.page),
        AutoRoute(page: UserBookRegistViewRoute.page),
        AutoRoute(page: ChatViewRoute.page),
        AutoRoute(page: ReviewViewRoute.page),
        AutoRoute(page: BookScanViewRoute.page),
        AutoRoute(page: BookScanRegistViewRoute.page),
        AutoRoute(page: BookScanDetailViewRoute.page),
        AutoRoute(page: BookScanRegistDoneViewRoute.page),
        AutoRoute(page: BookScanHistoryViewRoute.page),
        AutoRoute(page: BookScanPdfViewRoute.page),
      ];
}
