import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posyandu_apps/presentation/page/auth/login_page.dart';

void main() {
  testWidgets('Login Page Testing', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );
    await tester.pump();
    expect(find.byType(Image), findsOneWidget);

    final nikField = find.byType(TextFormField).first;
    expect(nikField, findsOneWidget);
    // await tester.enterText(nikField, '352');
    await tester.pumpAndSettle();

    final passwordField = find.byType(TextFormField).last;
    expect(passwordField, findsOneWidget);
    // await tester.enterText(passwordField, '123');
    await tester.pumpAndSettle();

    expect(find.text('Masuk'), findsOneWidget);

    final loginBtn = find.byType(InkWell);
    expect(loginBtn, findsOneWidget);

    await tester.tap(loginBtn);
    await tester.pumpAndSettle();
  });
}
