import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

import 'package:gp_foundations/core/configs.dart';
import 'package:gp_foundations/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:gp_foundations/features/user/data/repositories/authentication_repository_implementation.dart';
import 'package:gp_foundations/features/user/domain/errors.dart';

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late MockGoogleSignIn mockGoogleSignIn;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockGoogleSignIn = MockGoogleSignIn();
  });

  test('Test confirm password reset', () async {
    final emailActionCodeSettings = EmailActionCodeSettings(
      url: 'https://test.com/',
    );

    final authRepositoryImplementation = AuthenticationRepositoryImplementation(
      firebaseAuth: mockFirebaseAuth,
      userRemoteDataSource: mockUserRemoteDataSource,
      googleSignIn: mockGoogleSignIn,
      emailActionCodeSettings: emailActionCodeSettings,
    );

    when(
      () => mockFirebaseAuth.confirmPasswordReset(
        code: 'testCode',
        newPassword: 'new-password',
      ),
    ).thenAnswer(
      (invocation) => Future<void>.value(),
    );

    final futureResult = authRepositoryImplementation.confirmPasswordReset(
      'testCode',
      'new-password',
    );

    expect(futureResult, const TypeMatcher<Future<void>>());

    await futureResult;
  });

  test('Test logOut', () async {
    final emailActionCodeSettings = EmailActionCodeSettings(
      url: 'https://test.com/',
    );

    final authRepositoryImplementation = AuthenticationRepositoryImplementation(
      firebaseAuth: mockFirebaseAuth,
      userRemoteDataSource: mockUserRemoteDataSource,
      googleSignIn: mockGoogleSignIn,
      emailActionCodeSettings: emailActionCodeSettings,
    );

    when(
      () => mockFirebaseAuth.signOut(),
    ).thenAnswer(
      (invocation) => Future<void>.value(),
    );
    when(
      () => mockGoogleSignIn.signOut(),
    ).thenAnswer(
      (invocation) => Future<GoogleSignInAccount?>.value(null),
    );

    final futureResult = authRepositoryImplementation.logOut();

    expect(futureResult, const TypeMatcher<Future<void>>());

    await futureResult;
  });

  test('Test logOut with exceptions', () {
    final emailActionCodeSettings = EmailActionCodeSettings(
      url: 'https://test.com/',
    );

    final authRepositoryImplementation = AuthenticationRepositoryImplementation(
      firebaseAuth: mockFirebaseAuth,
      userRemoteDataSource: mockUserRemoteDataSource,
      googleSignIn: mockGoogleSignIn,
      emailActionCodeSettings: emailActionCodeSettings,
    );

    when(
      () => mockFirebaseAuth.signOut(),
    ).thenThrow(
      Exception('Something went wrong!'),
    );
    when(
      () => mockGoogleSignIn.signOut(),
    ).thenAnswer(
      (invocation) => Future<GoogleSignInAccount?>.value(null),
    );

    final futureResult = authRepositoryImplementation.logOut();

    expect(futureResult, const TypeMatcher<Future<void>>());
    expect(
      () => futureResult.then((_) {
        return;
      }),
      throwsA(const TypeMatcher<LogOutFailure>()),
    );
  });
}
