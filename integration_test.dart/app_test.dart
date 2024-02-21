import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app_new/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("end-to-end-test", () {
    testWidgets("show the current weather data with enter city name ",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key("text-field")), "London");
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(find.text("London"), findsOneWidget);
    });
  });
}
