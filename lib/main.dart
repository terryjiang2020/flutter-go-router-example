import 'package:androidrouting/global_key.dart';
import 'package:androidrouting/visual_exact_button.dart';
// import 'package:androidrouting/visual_exact_cover.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'app/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(const MyApp()); 

  runApp(
    ChangeNotifierProvider(
      create: (context) => DialogState(),
      child: const MyApp(),
    ),
  );
}

final ScreenshotController screenshotController = ScreenshotController();
bool loading = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    void _onTap() {
      print('Tap detected');
      // 在这里添加你想要触发的功能
    }

    void _onLongPress() {
      print('Long press detected');
      // 在这里添加你想要触发的功能
    }

    void _onHorizontalDragEnd(DragEndDetails details) {
      if (details.primaryVelocity! > 0) {
        print('Right swipe detected');
        // 在这里添加你想要触发的功能=
      }
    }

    void _showAlert(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

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
      builder: (contextA, child) {
        // When you wish to disable the floating button, you can return the child directly.
        // if (true) {
        //   return child!;
        // }
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () { // this one 
                        debugPrint("on White pan onTap");
                        // _showAlert(context, "on White pan onTap");
                      },
                      onTapDown: (_) { // this one 
                        debugPrint("on White pan down");
                        // _showAlert(context, "on White pan down");
                      },
                      onLongPress: _onLongPress,
                      onHorizontalDragEnd: _onHorizontalDragEnd,
                      child: Stack(
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
                          ),
                        ], // 设置透明背景以确保手势检测
                      ),
                    );
                  },
                ),
              ),
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
