import 'package:hng_auth_sdk/src/ui/theme/auth_theme.dart';

class AuthConfig {
  final AuthProviderConfig providers;
  final AuthUIMode uiMode;
  final AuthThemeData? theme;
  final bool autoRefreshToken;
  final Duration tokenRefreshThreshold;

  const AuthConfig({
    required this.providers,
    this.uiMode = AuthUIMode.defaultUI,
    this.theme,
    this.autoRefreshToken = true,
    this.tokenRefreshThreshold = const Duration(minutes: 5),
  });
}

/// Provider configuration
class AuthProviderConfig {
  final bool emailPassword;
  final bool google;
  final bool apple;

  const AuthProviderConfig({
    this.emailPassword = true,
    this.google = false,
    this.apple = false,
  });

  List get enabledProviders {
    final providers = [];
    if (emailPassword) providers.add(AuthProviderType.emailPassword);
    if (google) providers.add(AuthProviderType.google);
    if (apple) providers.add(AuthProviderType.apple);
    return providers;
  }
}

enum AuthUIMode { defaultUI, headless }

enum AuthProviderType { emailPassword, google, apple }

enum AuthState { authenticated, unauthenticated, tokenExpired }
