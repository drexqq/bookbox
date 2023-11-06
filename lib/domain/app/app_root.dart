import 'package:auto_route/auto_route.dart';
import 'package:bookbox/domain/app/views/app_error_view.dart';
import 'package:bookbox/domain/app/views/app_first_view.dart';
import 'package:bookbox/domain/app/views/app_loading_view.dart';
import 'package:bookbox/domain/app/app_provider.dart';
import 'package:bookbox/domain/app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appNotifierProvider);
    return state.when(
      data: (data) {
        return data.maybeWhen(
          initial: () => const AppFirstView(),
          authenticated: () => const HomeView(),
          unauthenticated: () => const AppFirstView(),
          error: (e) => const AppErrorView(),
          orElse: () => const AppErrorView(),
        );
      },
      error: (e, st) => const AppErrorView(),
      loading: () => const AppLoadingView(),
    );
  }
}
