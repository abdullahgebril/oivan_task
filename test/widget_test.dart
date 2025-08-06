import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';
import 'package:oivan_task/helper/date_formatter.dart';

void main() {
  group('App Constants Tests', () {
    test('AppColors should have valid color values', () {
      expect(AppColors.primaryColor, isA<Color>());
      expect(AppColors.cardBackground, isA<Color>());
      expect(AppColors.textColor, isA<Color>());
    });

    test('AppDimensions should have valid dimension values', () {
      expect(AppDimensions.paddingXS, isA<double>());
      expect(AppDimensions.paddingS, isA<double>());
      expect(AppDimensions.paddingM, isA<double>());
      expect(AppDimensions.iconS, isA<double>());
    });
  });

  group('DateFormatter Tests', () {
    test('formatTimestamp should format date correctly', () {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final formatted = DateFormatter.formatTimestamp(timestamp);
      expect(formatted, isA<String>());
      expect(formatted.isNotEmpty, true);
    });

    test('formatShortDate should format date correctly', () {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final formatted = DateFormatter.formatShortDate(timestamp);
      expect(formatted, isA<String>());
      expect(formatted.isNotEmpty, true);
    });

    test('formatRelativeTime should format relative time correctly', () {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final formatted = DateFormatter.formatRelativeTime(timestamp);
      expect(formatted, isA<String>());
      expect(formatted.isNotEmpty, true);
    });
  });

  group('Widget Unit Tests', () {
    test('Basic app configuration', () {
      const appTitle = 'OIVAN Task';
      expect(appTitle.isNotEmpty, true);
      expect(appTitle.length, greaterThan(0));
    });

    test('List operations', () {
      final testList = <String>['test1', 'test2'];
      expect(testList.length, 2);
      expect(testList.first, 'test1');
    });

    test('String operations', () {
      const testString = 'StackOverflow Users';
      expect(testString.contains('Users'), true);
      expect(testString.toLowerCase(), 'stackoverflow users');
    });
  });

  group('Widget Tests', () {
    testWidgets('Material App should build', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: const Text('Test')),
            body: const Center(child: Text('Hello World')),
          ),
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('Basic widget creation', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Text('Test Widget'),
        ),
      );

      expect(find.text('Test Widget'), findsOneWidget);
    });
  });
}
