// Flutter imports:
import 'package:bookbox/router/router.gr.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: "View")
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AppRootRoute.page, initial: true),
        AutoRoute(page: LoginViewRoute.page),
        AutoRoute(page: PhoneAuthViewRoute.page),
        AutoRoute(page: HomeViewRoute.page),
        AutoRoute(page: DealDetailViewRoute.page),
        AutoRoute(page: DealRegistViewRoute.page),
        AutoRoute(page: DealRegistSelectBookViewRoute.page),
        AutoRoute(page: UserSettingViewRoute.page),
        AutoRoute(page: UserBookRegistViewRoute.page),
      ];
}
