import 'package:artis/data/models/user.dart';
import 'package:artis/src/ui_widgets/ui_card.dart';
import 'package:artis/src/ui_widgets/ui_text_form_field.dart';
import 'package:artis/src/utilities/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:window_manager/window_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with WindowListener {
  bool widgetsInitialized = false;

  late Text titleApp;
  late Text subtitleApp;
  late UITextFormField usernameFormField;
  late UITextFormField passwordFormField;


  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void initializeWidgets() {
    if (!widgetsInitialized) {
      titleApp = Text("artis", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 25));
      subtitleApp = Text(AppLocalizations.of(context)!.subtitleApp, style: TextStyle(color: Theme.of(context).colorScheme.secondary.withAlpha(150), fontSize: 15));
      usernameFormField = UITextFormField(labelText: AppLocalizations.of(context)!.userName);
      passwordFormField = UITextFormField(inputType: TextInputType.visiblePassword, labelText: AppLocalizations.of(context)!.password);

      widgetsInitialized = true;
    }
  }

  Form getLoginForm() {
    return Form(
      key: Key("login-form-field"),
      child: Column(
        spacing: 10,
        children: [
          usernameFormField,
          passwordFormField,
          TextButton(
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary), elevation: WidgetStatePropertyAll(20), foregroundColor: WidgetStatePropertyAll(Colors.black)),
            onPressed: () => logInAction(),
            child: Text(AppLocalizations.of(context)!.login)
          )
        ],
      ),
    );
  }

  void logInAction() {
    if (!Util.strIsEmpty(usernameFormField.text) && !Util.strIsEmpty(passwordFormField.text)) {
      User user = User(
        username: usernameFormField.text!,
        hashedPassword: User.hashPassword(passwordFormField.text!)
      );

      print(user.login());
    } else {
      Util.showWarningMessage(context, AppLocalizations.of(context)!.emptyFieldsWarning);
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeWidgets();

    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(image: AssetImage('assets/images/artis_logo.png'),width: 180,),
              titleApp,
              subtitleApp
            ],
          ),
          VerticalDivider(indent: 50, endIndent: 50, thickness: 2,),
          UICard(
            widgets: [
              Text("Login", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
              getLoginForm()
            ],
          )
        ],
      ),
    );
  }
}