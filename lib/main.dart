import 'package:artis/src/app.dart';
import 'package:artis/src/pages/home_page.dart';
import 'package:artis/src/pages/login_page.dart';
import 'package:artis/src/settings/settings_controller.dart';
import 'package:artis/src/settings/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    minimumSize: Size(550, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,windowButtonVisibility: true
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  databaseFactory = databaseFactoryFfi;

  sqfliteFfiInit();

  runApp(ArtisApp(settingsController: settingsController));
}