import 'package:artis/data/models/user.dart';
import 'package:artis/src/layouts/general_layout.dart';
import 'package:artis/src/ui_widgets/ui_card.dart';
import 'package:artis/src/ui_widgets/ui_button.dart';
import 'package:artis/src/ui_widgets/ui_toast.dart';
import 'package:artis/src/utilities/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  static String route = "/login";

  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool widgetsInitialized = false;

  late Text titleApp;
  late Text subtitleApp;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializeWidgets();
  }

  void initializeWidgets() {
    if (!widgetsInitialized) {
      titleApp = Text("artis", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 25));
      subtitleApp = Text(AppLocalizations.of(context)!.subtitleApp, style: TextStyle(color: Theme.of(context).colorScheme.secondary.withAlpha(150), fontSize: 15));

      widgetsInitialized = true;
    }
  }

  Stack getContent() {
    Widget content;

    if (Util.isMobileSize(context)) {
      content = Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              spacing: 13,
              children: [
                getAppLogo(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleApp,
                    subtitleApp
                  ]
                )
              ],
            ),
            Divider(indent: 50, endIndent: 50, thickness: 2),
            SizedBox(height: 30),
            getWelcomeLogInCard()
          ],
        ),
      );
    } else {
      content = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              getAppLogo(),
              titleApp,
              subtitleApp
            ],
          ),
          VerticalDivider(indent: 50, endIndent: 50, thickness: 2),
          getWelcomeLogInCard()
        ],
      );
    }

    return Stack(children: [ content, getAppCredits(context) ]);
  }

  ClipRRect getAppLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        bottomLeft: Radius.circular(25),
        topRight: Radius.circular(5),
        bottomRight: Radius.circular(5)
      ),
      child: Image(image: AssetImage('assets/images/artis_logo.png'), width: Util.isMobileSize(context) ? 100: 180)
    );
  }

  Widget getWelcomeLogInCard() {
    return UICard(
      verticalSpacing: 15,
      widgets: [
        RichText(
          text: TextSpan(
            text: "${AppLocalizations.of(context)!.hi}, ",
            style: TextStyle(fontFamily: "RobotoSlab"),
            children: [
              WidgetSpan(child: Text("miguellrp", style: TextStyle(color: Theme.of(context).colorScheme.onTertiary))),
            ]
          ),
        ),
        User.getUserPic(presetUserPicNumber: 1),
        UIButton(
          text: AppLocalizations.of(context)!.login,
          icon: Icons.login,
          onPressed: logInAction
        )
      ],
    );
  }

  void logInAction() async {
    // TODO: dynamic user
    User user = User(
      username: "miguellrp",
      hashedPassword: User.hashPassword("testpass")
    );

    bool userValid = await user.login();
    if (userValid) {
      Navigator.of(context).pushNamed(HomePage.route);
    } else {
      UIToast.show(context,
        type: ToastType.error,
        message: AppLocalizations.of(context)!.errorMessage
      );
      List<User> users = await User.list(whereConditions: "a_username like ?", whereArgs: ["miguellrp"]);
    }
  }

  Positioned getAppCredits(BuildContext context) {
    InkWell getUrlLink ({required String text, required String link}) => InkWell(
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      onTap: () async => await launchUrl(Uri.parse("https://github.com/miguellrp")),
      child: Text(text, style: TextStyle(color: Theme.of(context).colorScheme.primary.withAlpha(200))),
    );
    final TextStyle creditsStyle = TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(150));

    return Positioned(
      bottom: 12,
      right: 10,
      child: Container(
        color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 2.5,
          children: [
            RichText(
              text: TextSpan(
                style: creditsStyle,
                text: "${AppLocalizations.of(context)!.madeBy}: ",
                children: [
                  WidgetSpan(child: getUrlLink(text: "@miguellrp", link: "https://github.com/miguellrp"))
                ]
              )
            ),
            RichText(
              text: TextSpan(
                style: creditsStyle,
                text: "${AppLocalizations.of(context)!.iconBy}: ",
                children: [
                  WidgetSpan(child:  getUrlLink(text: "@maia.therat", link: "https://www.instagram.com/maia.therat"))
                ]
              )
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GeneralLayout(
      content: getContent(),
    );
  }
}