import 'package:flutter_test/flutter_test.dart';
import 'package:job_portal/main.dart';

void main() {
  testWidgets('Job portal app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FreshGradJobPortalApp());

    // Verify that project title is displayed
    expect(find.text('FreshGrad Jobs'), findsWidgets);
    expect(find.text('Job Portal for Fresh Graduates'), findsWidgets);
  });
}
