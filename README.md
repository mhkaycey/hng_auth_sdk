## 🚀 Usage Examples

### **Configuring Authentication Providers**

You can easily enable or disable specific authentication providers by configuring the `AuthProviderConfig` class. This gives you full control over which authentication methods are available to your users.

#### Method 1: Using AuthConfigBuilder (Recommended)

The `AuthConfigBuilder` utility class provides convenient methods for common authentication configurations:

```dart
import 'package:hng_auth_sdk/hng_auth_sdk.dart';

// Enable only Email/Password authentication
AuthConfig config = AuthConfigBuilder.emailOnly();

// Enable only Google authentication
AuthConfig config = AuthConfigBuilder.googleOnly();

// Enable only Apple authentication
AuthConfig config = AuthConfigBuilder.appleOnly();

// Enable Email + Google
AuthConfig config = AuthConfigBuilder.emailAndGoogle();

// Enable Email + Apple
AuthConfig config = AuthConfigBuilder.emailAndApple();

// Enable Google + Apple
AuthConfig config = AuthConfigBuilder.googleAndApple();

// Enable all providers
AuthConfig config = AuthConfigBuilder.allProviders();

// Custom configuration
AuthConfig config = AuthConfigBuilder.custom(
  emailPassword: true,
  google: false,
  apple: true,
);
```

#### Method 2: Manual Configuration

You can also manually configure the `AuthProviderConfig` class:

```dart
import 'package:hng_auth_sdk/hng_auth_sdk.dart';

// Enable only Email/Password authentication
AuthConfig(
  providers: AuthProviderConfig(
    emailPassword: true,  // Enable email/password
    google: false,        // Disable Google
    apple: false,         // Disable Apple
  ),
)

// Enable only Google authentication
AuthConfig(
  providers: AuthProviderConfig(
    emailPassword: false, // Disable email/password
    google: true,         // Enable Google
    apple: false,         // Disable Apple
  ),
)

// Enable multiple providers
AuthConfig(
  providers: AuthProviderConfig(
    emailPassword: true,  // Enable email/password
    google: true,         // Enable Google
    apple: false,         // Disable Apple
  ),
)
```

### **Example 1: Default UI Mode**

```dart
import 'package:hng_auth_sdk/hng_auth_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthWidget(
        config: AuthConfig(
          providers: AuthProviderConfig(
            emailPassword: true,
            google: true,
            apple: true,
          ),
          uiMode: AuthUIMode.defaultUI,
        ),
        onSuccess: () {
          // Navigate to home screen
        },
        onError: (error) {
          // Show error message
        },
      ),
    );
  }
}
```

### **Example 2: Headless/Custom UI Mode**

```dart
import 'package:firebase_auth_sdk/headless/auth_sdk_headless.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomLoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      body: Column(
        children: [
          // Your custom UI
          ElevatedButton(
            onPressed: () async {
              try {
                await authService.signInWithGoogle();
              } on InvalidCredentialsException catch (e) {
                // Handle specific error
              } on NetworkException catch (e) {
                // Handle network error
              }
            },
            child: Text('Sign in with Google'),
          ),

          // Display auth state
          Text('State: ${authState.state}'),
          if (authState.user != null)
            Text('User: ${authState.user!.email}'),
        ],
      ),
    );
  }
}
```
