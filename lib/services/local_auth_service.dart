// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuth {
  static final auth = LocalAuthentication();
  static Future<bool> canAuthenticate() async =>
      await auth.canCheckBiometrics || await auth.isDeviceSupported();
  static Future<bool> authenticate() async {
    try {
      if (!await canAuthenticate()) return false;
      return await auth.authenticate(
        authMessages: const [
          AndroidAuthMessages(
              signInTitle: 'Sign in', cancelButton: 'No Thanks'),
          IOSAuthMessages(
            cancelButton: 'No Thanks',
          ),
        ],
        localizedReason: 'Use Face Id to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      debugPrint('error $e');
      return false;
    }
  }
}
