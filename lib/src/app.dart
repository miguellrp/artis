import 'package:artis/src/pages/home_page.dart';
import 'package:artis/src/pages/login_page.dart';
import 'package:artis/src/settings/global_theme_data.dart';
import 'package:artis/src/settings/settings_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';


class ArtisApp extends StatelessWidget {
  final SettingsController settingsController;

  const ArtisApp({super.key, required this.settingsController});

  @override
  Widget build(BuildContext context) {
    final virtualWindowFrameBuilder = VirtualWindowFrameInit();
    final bool isSystemDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: isSystemDarkMode ? GlobalThemeData.darkThemeData : GlobalThemeData.lightThemeData,
      builder: (context, child) {
        child = virtualWindowFrameBuilder(context, child);
        return child;
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MainWindow(),
      routes: {
        LoginPage.route: (context) => LoginPage(),
        HomePage.route: (context) => HomePage()
      }
    );
  }
}

// To avoid delay on onPressed from window buttons:
class DraggableWindow extends StatelessWidget {
  final Widget child;

  const DraggableWindow({super.key, required this.child});

  @override Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (_) => windowManager.startDragging(),
      child: child,
    );
  }
}

class MainWindow extends StatelessWidget {
  const MainWindow({super.key});

  @override
  Widget build(BuildContext context) {
    Text getTitleApp() {
      return Text("artis", style: TextStyle(color: Theme.of(context).colorScheme.onTertiary));
    }

    IconButton getWindowOptionButton({required IconData icon, required VoidCallback onPressed, Color? hoverColor}) {
      return IconButton(
        icon: Icon(icon),
        color: Theme.of(context).colorScheme.onTertiary,
        iconSize: 14,
        padding: EdgeInsets.zero,
        mouseCursor: SystemMouseCursors.basic,
        highlightColor: Colors.transparent,
        splashRadius: 10,
        hoverColor: hoverColor,
        style: ButtonStyle(shape: WidgetStateProperty.all(RoundedRectangleBorder())),
        onPressed: () => onPressed()
      );
    }

    return Scaffold(
      body: Column(
        children: [
          DraggableWindow(
            child: Container(
              color: Theme.of(context).colorScheme.tertiary,
              height: 23,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(margin: EdgeInsets.only(left: 10), child: getTitleApp()),
                  Row(
                    children: [
                      getWindowOptionButton(icon: Icons.minimize, onPressed: () => windowManager.minimize()),
                      getWindowOptionButton(
                        icon: Icons.crop_square,
                        onPressed: () async => await windowManager.isMaximized() ? windowManager.restore() : windowManager.maximize()
                      ),
                      getWindowOptionButton(icon: Icons.close, hoverColor: Color(0x88C72A2A), onPressed: () => windowManager.close())
                    ],
                  )
                ]
              )
            ),
          ),
          Expanded(child: Center(child: LoginPage()))
        ]
      )
    );
  }
}