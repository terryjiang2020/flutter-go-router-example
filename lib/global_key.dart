import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final ScreenshotController screenshotController = ScreenshotController();

String openedDialog = '';
