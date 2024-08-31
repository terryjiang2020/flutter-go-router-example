import 'package:androidrouting/controller/navigation_cubit.dart';
import 'package:androidrouting/global_key.dart';
import 'package:androidrouting/presentation/home/home_details_screen.dart';
import 'package:androidrouting/presentation/home/home_screen.dart';
import 'package:androidrouting/presentation/main_screen.dart';
import 'package:androidrouting/presentation/profile/profile_details_screen.dart';
import 'package:androidrouting/presentation/profile/profile_screen.dart';
import 'package:androidrouting/presentation/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/constants.dart';
import 'screens/not_found_page.dart';

// final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {

  static final GoRouter _router = GoRouter(
    initialLocation: Routes.homeNamedPage,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => NavigationCubit(),
            child: MainScreen(screen: child),
          );
        },
        routes: [
          GoRoute(
            path: Routes.homeNamedPage,
            pageBuilder: (context, state) =>
            const NoTransitionPage(
              child: HomeScreen(),
            ),
            routes: [
              GoRoute(
                path: Routes.homeDetailsNamedPage,
                builder: (context, state) => const HomeDetailsScreen(),
              ),
            ],
          ),
          GoRoute(
            path: Routes.profileNamedPage,
            pageBuilder: (context, state) =>
            const NoTransitionPage(
              child: ProfileScreen(),
            ),
            routes: [
              GoRoute(
                path: Routes.profileDetailsNamedPage,
                builder: (context, state) => const ProfileDetailsScreen(),
              ),
            ],
          ),
          GoRoute(
            path: Routes.settingsNamedPage,
            pageBuilder: (context, state) =>
            const NoTransitionPage(
              child: SettingScreen(),
            ),
          ),
          // This solution doesn't make sense. It is just using a dialog as a page.
          // GoRoute(
          //   path: Routes.settingsNamedPage,
          //   builder: (context, state) => const ProfileScreen(),
          //   pageBuilder: (context, state) {
          //     return CustomTransitionPage<vorid>(
          //       key: state.pageKey,
          //       child: const ProfileScreen(), // Current page
          //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
          //         return Stack(
          //           children: [
          //             child,
          //             AlertDialogWidget(), // Dialog on top of the current page
          //           ],
          //         );
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),

  );

  static GoRouter get router => _router;
}

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dialog'),
      content: const Text('This is a dialog'),
      actions: [
        TextButton(
          onPressed: () {
            // Close the dialog and navigate back to the previous route
            context.pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
