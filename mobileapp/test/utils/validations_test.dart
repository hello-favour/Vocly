import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/utils/validations.dart';

void main() {
  group('AppValidations', () {
    test('requires a real name', () {
      expect(AppValidations.validatedName(null), isNotNull);
      expect(AppValidations.validatedName(' P '), isNotNull);
      expect(AppValidations.validatedName('Pat'), isNull);
    });

    test('validates email addresses', () {
      expect(AppValidations.validatedEmail(''), isNotNull);
      expect(AppValidations.validatedEmail('not-an-email'), isNotNull);
      expect(AppValidations.validatedEmail('person@domain.com'), isNull);
    });

    test('requires a production-strength password', () {
      expect(AppValidations.validatePassword('short'), isNotNull);
      expect(AppValidations.validatePassword('alllowercase1'), isNotNull);
      expect(AppValidations.validatePassword('NoNumberHere'), isNotNull);
      expect(AppValidations.validatePassword('SecurePass1'), isNull);
    });

    test('requires matching password confirmation', () {
      expect(
        AppValidations.validateConfirmPassword('', password: 'SecurePass1'),
        isNotNull,
      );
      expect(
        AppValidations.validateConfirmPassword(
          'SecurePass2',
          password: 'SecurePass1',
        ),
        isNotNull,
      );
      expect(
        AppValidations.validateConfirmPassword(
          'SecurePass1',
          password: 'SecurePass1',
        ),
        isNull,
      );
    });
  });
}
