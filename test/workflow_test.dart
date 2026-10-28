import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_portal/main.dart';

void main() {
  testWidgets('Complete end-to-end user workflow test', (WidgetTester tester) async {
    // Set standard desktop browser resolution
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // 1. Build and open the app
    await tester.pumpWidget(const FreshGradJobPortalApp());
    await tester.pumpAndSettle();

    // Verify Home Page components
    expect(find.text('Job Portal for Fresh Graduates'), findsWidgets);
    expect(find.text('Featured Opportunities'), findsOneWidget);
    expect(find.text('Sustainable Development Goals (SDG) Alignment'), findsOneWidget);

    // 2. Search for a job from Home Hero
    final searchInput = find.byType(TextField).first;
    await tester.enterText(searchInput, 'Flutter');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();

    // Verify it transitioned to Find Jobs and filtered jobs
    expect(find.text('Explore Entry-Level Jobs'), findsOneWidget);
    expect(find.text('Junior Flutter Developer'), findsOneWidget);

    // 3. Open Job Details
    final detailsBtn = find.text('View Details').first;
    await tester.tap(detailsBtn);
    await tester.pumpAndSettle();

    // Verify Job Details dialog content
    expect(find.text('Job Description'), findsOneWidget);
    expect(find.text('Eligibility Criteria'), findsOneWidget);
    expect(find.text('Required Skills'), findsOneWidget);

    // 4. Click Apply Now from details dialog
    final applyNowDialogBtn = find.text('Apply Now');
    await tester.tap(applyNowDialogBtn);
    await tester.pumpAndSettle();

    // 5. Enter candidate details in application form
    expect(find.text('Apply for Position'), findsOneWidget);

    final nameField = find.widgetWithText(TextFormField, 'Candidate Full Name *');
    final emailField = find.widgetWithText(TextFormField, 'Email Address *');
    final eduField = find.widgetWithText(TextFormField, 'Education / Degree *');
    final skillsField = find.widgetWithText(TextFormField, 'Key Skills & Technologies *');

    await tester.enterText(nameField, 'Alex Morgan');
    await tester.enterText(emailField, 'alex.morgan@univ.edu');
    await tester.enterText(eduField, 'B.Tech in Computer Science');
    await tester.enterText(skillsField, 'Flutter, Dart, Git, REST APIs');
    await tester.pumpAndSettle();

    // 6. Submit the application
    final submitBtn = find.text('Submit Application');
    await tester.ensureVisible(submitBtn);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();

    // 7. Verify Success message is displayed
    expect(find.text('Application Submitted!'), findsOneWidget);

    // 8. Open My Applications via success dialog button
    final viewAppsBtn = find.text('View My Applications');
    await tester.tap(viewAppsBtn);
    await tester.pumpAndSettle();

    // Verify submitted application in My Applications list
    expect(find.text('My Applications'), findsWidgets);
    expect(find.text('Alex Morgan'), findsOneWidget);
    expect(find.text('Junior Flutter Developer'), findsOneWidget);
    expect(find.text('Applied'), findsWidgets);

    // 9. Verify duplicate prevention
    // Go to Find Jobs tab
    await tester.tap(find.text('Find Jobs').first);
    await tester.pumpAndSettle();

    // For the Flutter job, it should now display "Applied"
    expect(find.text('Applied'), findsWidgets);
  });
}
