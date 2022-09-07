import 'package:dogs_and_cats/main.dart' as app;
import 'package:dogs_and_cats/src/ui/widgets/buttons_widgets.dart';
import 'package:dogs_and_cats/src/ui/widgets/text_fields_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test app, user need to login case', (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();
    await FirebaseAuth.instance.signOut();
    await tester.pumpAndSettle();

    var emailTextFormField = find.byType(EmailTextFieldWidget);
    await tester.enterText(emailTextFormField, 'ali@algooru.com');
    await tester.pumpAndSettle();

    var passwordTextFormField = find.byType(PasswordTextFieldWidget);
    await tester.enterText(passwordTextFormField, "ali.assi");
    await tester.pumpAndSettle();

    expect(emailTextFormField, findsOneWidget);
    expect(passwordTextFormField, findsOneWidget);

    var loginButton = find.widgetWithText(BlackButton, 'Login');
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    /// home page
    await tester.pumpAndSettle(Duration(seconds: 5));
    await tester.tap(find.text('Cats'));
    await tester.pumpAndSettle(Duration(seconds: 5));

    /// should not load, already loaded
    await tester.tap(find.text('Dogs'));
    await tester.pumpAndSettle(Duration(seconds: 5));

    /// should not load, already loaded
    await tester.tap(find.text('Cats'));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await FirebaseAuth.instance.signOut();
    await tester.pumpAndSettle(Duration(seconds: 5));


  });



  testWidgets('Test app, fail to login, then login again and continue', (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();
    await FirebaseAuth.instance.signOut();
    await tester.pumpAndSettle();

    var emailTextFormField = find.byType(EmailTextFieldWidget);
    await tester.enterText(emailTextFormField, 'wrong@email.com');
    await tester.pumpAndSettle();

    var passwordTextFormField = find.byType(PasswordTextFieldWidget);
    await tester.enterText(passwordTextFormField, "ali.assi");
    await tester.pumpAndSettle();

    expect(emailTextFormField, findsOneWidget);
    expect(passwordTextFormField, findsOneWidget);

    var loginButton = find.widgetWithText(BlackButton, 'Login');
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(Duration(seconds: 5));

    var okButton = find.widgetWithText(TextButton, 'OK');
    expect(loginButton, findsOneWidget);

    await tester.tap(okButton);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(Duration(seconds: 5));


    ///login again
    await tester.enterText(emailTextFormField, 'ali@algooru.com');
    await tester.pumpAndSettle();

    await tester.enterText(passwordTextFormField, "ali.assi");
    await tester.pumpAndSettle();

    expect(emailTextFormField, findsOneWidget);
    expect(passwordTextFormField, findsOneWidget);

    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(Duration(seconds: 5));


    /// home page
    await tester.pumpAndSettle(Duration(seconds: 5));
    await tester.tap(find.text('Cats'));
    await tester.pumpAndSettle(Duration(seconds: 5));

    /// should not load, already loaded
    await tester.tap(find.text('Dogs'));
    await tester.pumpAndSettle(Duration(seconds: 5));

    /// should not load, already loaded
    await tester.tap(find.text('Cats'));
    await tester.pumpAndSettle(Duration(seconds: 5));
  });

}
