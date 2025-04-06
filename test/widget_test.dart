import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:child_emotion/main.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Displays average sentiment from JSON', (WidgetTester tester) async {
    final mockJson = '''
    {
      "average_sentiment": 2.5555
    }
    ''';

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
      (message) async {
        if (message == null) return null;

        final String key = utf8.decode(message.buffer.asUint8List());
        if (key == 'assets/sentiment_score.json') {
          return const StandardMethodCodec().encodeSuccessEnvelope(utf8.encode(mockJson));
        }
        return null;
      },
    );

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('2.5555'), findsOneWidget);
  });
}
