import 'package:androidrouting/global_key.dart';
import 'package:androidrouting/visual_exact_button.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'app/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(const MyApp()); 

  runApp(
    ChangeNotifierProvider(
      create: (context) => DialogState(),
      child: MyApp(),
    ),
  );
}

final ScreenshotController screenshotController = ScreenshotController();
bool loading = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      title: 'Go Router',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black
      ),
      // VM Setup
      builder: (context, child) {
        // When you wish to disable the floating button, you can return the child directly.
        // if (true) {
        //   return child!;
        // }
        return Scaffold(
          body: 
          Stack(
            children: [
              Screenshot(
                controller: screenshotController,
                child: child,
              ),
              Visibility(
                visible: loading,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: VisualExactButton(
            setLoading: (bool value) {
              loading = value;
            },
            apiToken: '67fd3d00-2439-11ef-bef2-dbb7af0bf2601717701444816', // Use a valid API Token here
            currentContext: context,
            navigatorKey: navigatorKey,
            screenshotController: screenshotController,
            // apiToken: '67fd3d00-2439-11ef-bef2-dbb7af0bf2601717701444816',
            child: child,
          ),
          // The following decides the location of the floating button. Feel free to change it.
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        );
      },
    );
  }
}
