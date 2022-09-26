import 'package:flutter_test/flutter_test.dart';
import 'package:gp_foundations/features/user/domain/models/user.dart';

import '../../../../test_data.dart';

void main() {
  test('Test user fromJson and toJson methods.', () {
    final user = User.fromJson(userJsonExample);
    final userJson = user.toJson();

    expect(user.id, 'id-foo');
    expect(user.firstName, 'John');
    expect(user.lastName, 'Doe');
    expect(user.verified, true);
    expect(userJson['id'], user.id);
    expect(userJson['firstName'], user.firstName);
    expect(userJson['lastName'], user.lastName);
    expect(userJson['verified'], user.verified);
  });
}
