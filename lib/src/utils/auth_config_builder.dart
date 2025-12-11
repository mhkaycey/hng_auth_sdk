import '../core/auth_config.dart';
import '../ui/theme/auth_theme.dart';

/// Utility class for easily creating common authentication configurations
class AuthConfigBuilder {
  /// Create configuration with only email/password authentication
  static AuthConfig emailOnly({
    AuthUIMode uiMode = AuthUIMode.defaultUI,
    AuthThemeData? theme,
    bool autoRefreshToken = true,
    Duration tokenRefreshThreshold = const Duration(minutes: 5),
  }) {
    return AuthConfig(
      providers: const AuthProviderConfig(
        emailPassword: true,
        google: false,
        apple: false,
      ),
      uiMode: uiMode,
      theme: theme,
      autoRefreshToken: autoRefreshToken,
      tokenRefreshThreshold: tokenRefreshThreshold,
    );
  }

  /// Create configuration with only Google authentication
  static AuthConfig googleOnly({
    AuthUIMode uiMode = AuthUIMode.defaultUI,
    AuthThemeData? theme,
    bool autoRefreshToken = true,
    Duration tokenRefreshThreshold = const Duration(minutes: 5),
  }) {
    return AuthConfig(
      providers: const AuthProviderConfig(
        emailPassword: false,
        google: true,
        apple: false,
      ),
      uiMode: uiMode,
      theme: theme,
      autoRefreshToken: autoRefreshToken,
      tokenRefreshThreshold: tokenRefreshThreshold,
    );
  }

  /// Create configuration with only Apple authentication
  static AuthConfig appleOnly({
    AuthUIMode uiMode = AuthUIMode.defaultUI,
    AuthThemeData? theme,
    bool autoRefreshToken = true,
    Duration tokenRefreshThreshold = const Duration(minutes: 5),
  }) {
    return AuthConfig(
      providers: const AuthProviderConfig(
        emailPassword: false,
        google: false,
        apple: true,
      ),
      uiMode: uiMode,
      theme: theme,
      autoRefreshToken: autoRefreshToken,
      tokenRefreshThreshold: tokenRefreshThreshold,
    );
  }

  /// Create configuration with email/password and Google authentication
  static AuthConfig emailAndGoogle({
    AuthUIMode uiMode = AuthUIMode.defaultUI,
    AuthThemeData? theme,
    bool autoRefreshToken = true,
    Duration tokenRefreshThreshold = const Duration(minutes: 5),
  }) {
    return AuthConfig(
      providers: const AuthProviderConfig(
        emailPassword: true,
        google: true,
        apple: false,
      ),
      uiMode: uiMode,
      theme: theme,
      autoRefreshToken: autoRefreshToken,
      tokenRefreshThreshold: tokenRefreshThreshold,
    );
  }

  /// Create configuration with email/password and Apple authentication
  static AuthConfig emailAndApple({
    AuthUIMode uiMode = AuthUIMode.defaultUI,
    AuthThemeData? theme,
    bool autoRefreshToken = true,
    Duration tokenRefreshThreshold = const Duration(minutes: 5),
  }) {
    return AuthConfig(
      providers: const AuthProviderConfig(
        emailPassword: true,
        google: false,
        apple: true,
      ),
      uiMode: uiMode,
      theme: theme,
      autoRefreshToken: autoRefreshToken,
      tokenRefreshThreshold: tokenRefreshThreshold,
    );
  }

  /// Create configuration with Google and Apple authentication
  static AuthConfig googleAndApple({
    AuthUIMode uiMode = AuthUIMode.defaultUI,
    AuthThemeData? theme,
    bool autoRefreshToken = true,
    Duration tokenRefreshThreshold = const Duration(minutes: 5),
  }) {
    return AuthConfig(
      providers: const AuthProviderConfig(
        emailPassword: false,
        google: true,
        apple: true,
      ),
      uiMode: uiMode,
      theme: theme,
      autoRefreshToken: autoRefreshToken,
      tokenRefreshThreshold: tokenRefreshThreshold,
    );
  }

  /// Create configuration with all authentication providers
  static AuthConfig allProviders({
    AuthUIMode uiMode = AuthUIMode.defaultUI,
    AuthThemeData? theme,
    bool autoRefreshToken = true,
    Duration tokenRefreshThreshold = const Duration(minutes: 5),
  }) {
    return AuthConfig(
      providers: const AuthProviderConfig(
        emailPassword: true,
        google: true,
        apple: true,
      ),
      uiMode: uiMode,
      theme: theme,
      autoRefreshToken: autoRefreshToken,
      tokenRefreshThreshold: tokenRefreshThreshold,
    );
  }

  /// Create custom configuration with specific providers
  static AuthConfig custom({
    required bool emailPassword,
    required bool google,
    required bool apple,
    AuthUIMode uiMode = AuthUIMode.defaultUI,
    AuthThemeData? theme,
    bool autoRefreshToken = true,
    Duration tokenRefreshThreshold = const Duration(minutes: 5),
  }) {
    return AuthConfig(
      providers: AuthProviderConfig(
        emailPassword: emailPassword,
        google: google,
        apple: apple,
      ),
      uiMode: uiMode,
      theme: theme,
      autoRefreshToken: autoRefreshToken,
      tokenRefreshThreshold: tokenRefreshThreshold,
    );
  }
}
