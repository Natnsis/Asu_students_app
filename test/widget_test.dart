import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uni_app/main.dart';
import 'package:uni_app/src/app_state.dart';
import 'package:uni_app/src/data.dart';

void main() {
  testWidgets('welcome → onboarding → auth → setup → app', (tester) async {
    // Fixed pumps rather than pumpAndSettle — the home screen has an
    // intentionally infinite "next up" pulse animation.
    Future<void> settle() => tester.pump(const Duration(milliseconds: 450));

    await tester.pumpWidget(const UniCoreApp());
    await settle();
    expect(find.text('Your whole campus,\nin one quiet place.'), findsOneWidget);

    await tester.tap(find.text('Get started'));
    await settle();
    await settle();
    expect(find.text('Know before you walk over.'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await settle();
    await tester.tap(find.text('Next'));
    await settle();
    await tester.tap(find.text('Get started'));
    await settle();
    await settle();
    expect(find.text('Welcome back'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'UC/2941/16');
    await tester.enterText(find.byType(TextFormField).last, 'hunter2');
    await tester.tap(find.text('Sign in'));
    await settle();
    await settle();
    expect(find.text('Which department are you in?'), findsOneWidget);

    await tester.tap(find.text('Enter UniCore'));
    await settle();
    await settle();
    expect(find.text('Morning, Natnael'), findsOneWidget);

    // Tab bar switches screens.
    await tester.tap(find.text('Grades'));
    await settle();
    await settle();
    expect(find.text('Academics'), findsOneWidget);
  });

  test('GPA solver matches the design formula', () {
    final s = AppState();
    // Default roster: A-*4, B+*3, A*4, B*3  -> 50.5 / 14 credits.
    final sem = s.semGpa;
    expect(sem.cr, 14);
    expect(sem.gpa, closeTo(3.6071, 0.0001));
    expect(s.cumGpa, closeTo(3.53, 0.01));

    s.setDeadline(2);
    // need = (3.8 * (2 + 2) - 6.99) / 2
    expect(s.needAvg, closeTo(4.105, 0.001));
    expect(s.solverReachable, isFalse);
    expect(s.solverValue, 'Out of reach');
  });

  test('report routing follows the selected category', () {
    final s = AppState();
    expect(s.reportOffice, 'Facilities Office');
    s.setReportCat('Harassment');
    expect(s.reportOffice, 'Gender Office');
    s.submitReport();
    expect(s.reportSent, isTrue);
    expect(int.parse(s.ticket), inInclusiveRange(4431, 4490));
  });

  test('notification deep-links open the right overlay', () {
    final s = AppState();
    s.openNotif(kNotifs.firstWhere((n) => n.id == 'n1'));
    expect(s.overlay, 'chat');
    expect(s.chatId, 'c1');
    expect(s.read['n1'], isTrue);
  });
}
