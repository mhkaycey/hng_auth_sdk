import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hng_auth_sdk/hng_auth_sdk.dart';

void main() {
  group('AuthProviderConfig', () {
    test('should correctly identify enabled providers', () {
      // Test with all providers enabled
      final allProvidersConfig = AuthProviderConfig(
        emailPassword: true,
        google: true,
        apple: true,
      );

      final enabledProviders = allProvidersConfig.enabledProviders;
      expect(enabledProviders.length, 3);
      expect(enabledProviders, contains(AuthProviderType.emailPassword));
      expect(enabledProviders, contains(AuthProviderType.google));
      expect(enabledProviders, contains(AuthProviderType.apple));

      // Test with only email/password enabled
      final emailOnlyConfig = AuthProviderConfig(
        emailPassword: true,
        google: false,
        apple: false,
      );

      final emailOnlyProviders = emailOnlyConfig.enabledProviders;
      expect(emailOnlyProviders.length, 1);
      expect(emailOnlyProviders, contains(AuthProviderType.emailPassword));
      expect(emailOnlyProviders, isNot(contains(AuthProviderType.google)));
      expect(emailOnlyProviders, isNot(contains(AuthProviderType.apple)));

      // Test with only Google enabled
      final googleOnlyConfig = AuthProviderConfig(
        emailPassword: false,
        google: true,
        apple: false,
      );

      final googleOnlyProviders = googleOnlyConfig.enabledProviders;
      expect(googleOnlyProviders.length, 1);
      expect(googleOnlyProviders, contains(AuthProviderType.google));
      expect(
        googleOnlyProviders,
        isNot(contains(AuthProviderType.emailPassword)),
      );
      expect(googleOnlyProviders, isNot(contains(AuthProviderType.apple)));

      // Test with only Apple enabled
      final appleOnlyConfig = AuthProviderConfig(
        emailPassword: false,
        google: false,
        apple: true,
      );

      final appleOnlyProviders = appleOnlyConfig.enabledProviders;
      expect(appleOnlyProviders.length, 1);
      expect(appleOnlyProviders, contains(AuthProviderType.apple));
      expect(
        appleOnlyProviders,
        isNot(contains(AuthProviderType.emailPassword)),
      );
      expect(appleOnlyProviders, isNot(contains(AuthProviderType.google)));

      // Test with no providers enabled
      final noProvidersConfig = AuthProviderConfig(
        emailPassword: false,
        google: false,
        apple: false,
      );

      final noProviders = noProvidersConfig.enabledProviders;
      expect(noProviders.length, 0);
    });
  });

  group('AuthConfigBuilder', () {
    test('should create correct configurations for each preset', () {
      // Test emailOnly
      final emailOnlyConfig = AuthConfigBuilder.emailOnly();
      expect(emailOnlyConfig.providers.emailPassword, true);
      expect(emailOnlyConfig.providers.google, false);
      expect(emailOnlyConfig.providers.apple, false);

      // Test googleOnly
      final googleOnlyConfig = AuthConfigBuilder.googleOnly();
      expect(googleOnlyConfig.providers.emailPassword, false);
      expect(googleOnlyConfig.providers.google, true);
      expect(googleOnlyConfig.providers.apple, false);

      // Test appleOnly
      final appleOnlyConfig = AuthConfigBuilder.appleOnly();
      expect(appleOnlyConfig.providers.emailPassword, false);
      expect(appleOnlyConfig.providers.google, false);
      expect(appleOnlyConfig.providers.apple, true);

      // Test emailAndGoogle
      final emailAndGoogleConfig = AuthConfigBuilder.emailAndGoogle();
      expect(emailAndGoogleConfig.providers.emailPassword, true);
      expect(emailAndGoogleConfig.providers.google, true);
      expect(emailAndGoogleConfig.providers.apple, false);

      // Test emailAndApple
      final emailAndAppleConfig = AuthConfigBuilder.emailAndApple();
      expect(emailAndAppleConfig.providers.emailPassword, true);
      expect(emailAndAppleConfig.providers.google, false);
      expect(emailAndAppleConfig.providers.apple, true);

      // Test googleAndApple
      final googleAndAppleConfig = AuthConfigBuilder.googleAndApple();
      expect(googleAndAppleConfig.providers.emailPassword, false);
      expect(googleAndAppleConfig.providers.google, true);
      expect(googleAndAppleConfig.providers.apple, true);

      // Test allProviders
      final allProvidersConfig = AuthConfigBuilder.allProviders();
      expect(allProvidersConfig.providers.emailPassword, true);
      expect(allProvidersConfig.providers.google, true);
      expect(allProvidersConfig.providers.apple, true);

      // Test custom
      final customConfig = AuthConfigBuilder.custom(
        emailPassword: true,
        google: false,
        apple: true,
      );
      expect(customConfig.providers.emailPassword, true);
      expect(customConfig.providers.google, false);
      expect(customConfig.providers.apple, true);
    });

    test('should apply default values correctly', () {
      final config = AuthConfigBuilder.emailOnly();

      // Test default values
      expect(config.uiMode, AuthUIMode.defaultUI);
      expect(config.autoRefreshToken, true);
      expect(config.tokenRefreshThreshold, const Duration(minutes: 5));
      expect(config.theme, isNull);
    });

    test('should accept custom parameters', () {
      final customTheme = AuthThemeData(
        primaryColor: Colors.red,
        backgroundColor: Colors.white,
      );

      final config = AuthConfigBuilder.emailOnly(
        uiMode: AuthUIMode.headless,
        theme: customTheme,
        autoRefreshToken: false,
        tokenRefreshThreshold: const Duration(minutes: 10),
      );

      expect(config.uiMode, AuthUIMode.headless);
      expect(config.autoRefreshToken, false);
      expect(config.tokenRefreshThreshold, const Duration(minutes: 10));
      expect(config.theme, isNotNull);
      expect(config.theme!.primaryColor, Colors.red);
    });
  });
}
