import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// CanGetEnvValues
///
/// This mixing contains the private functions needed for reading env values.
mixin CanGetEnvValues {
  /// helper method to accurate check the types.
  bool _isTypesEqual<T1, T2>() => T1 == T2;

  /// retrieves the env values.
  T _getEnvValue<T>(String key) {
    final value = dotenv.env[key] as String;

    if (_isTypesEqual<T, bool?>()) {
      return (value.isNotEmpty ? value == 'true' : null) as T;
    }

    return (value.isNotEmpty ? value : null) as T;
  }
}

/// EmailActionCodeSettings
///
/// Class helper for creating action code settings for email verification and
/// password reset
class EmailActionCodeSettings extends ActionCodeSettings with CanGetEnvValues {
  EmailActionCodeSettings({String? url}) : super(url: url ?? '');

  EmailActionCodeSettings.full({
    required String url,
    String? androidPackageName,
    String? androidMinimumVersion,
    bool? androidInstallApp,
    String? dynamicLinkDomain,
    bool? handleCodeInApp,
    String? iOSBundleId,
  }) : super(
    url: url,
    androidPackageName: androidPackageName,
    androidMinimumVersion: androidMinimumVersion,
    androidInstallApp: androidInstallApp,
    dynamicLinkDomain: dynamicLinkDomain,
    handleCodeInApp: handleCodeInApp,
    iOSBundleId: iOSBundleId,
  );

  /// Creates a copy of the instance with email and minimum version of the app.
  ///
  /// The [email] is the email of the user for continue url.
  /// The [androidMinimumVersion] is the minimum version of the app.
  EmailActionCodeSettings createWith({
    required String email,
    String? androidMinimumVersion,
  }) {
    final url = _getEnvValue<String>('APP_URL') + '?email=$email';
    final androidPackageName = _getEnvValue<String?>('ANDROID_PACKAGE_NAME');
    final androidInstallApp = _getEnvValue<bool?>('ANDROID_INSTALL_APP');
    final dynamicLinkDomain = _getEnvValue<String?>('DYNAMIC_LINK_DOMAIN');
    final handleCodeInApp = _getEnvValue<bool?>('HANDLE_CODE_IN_APP');
    final iOSBundleId = _getEnvValue<String?>('IOS_BUNDLE_ID');

    return EmailActionCodeSettings.full(
      url: url,
      androidPackageName: androidPackageName,
      androidMinimumVersion: androidMinimumVersion,
      androidInstallApp: androidInstallApp,
      dynamicLinkDomain: dynamicLinkDomain,
      handleCodeInApp: handleCodeInApp,
      iOSBundleId: iOSBundleId,
    );
  }
}
