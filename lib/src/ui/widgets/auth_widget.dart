import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_auth_sdk/src/core/auth_config.dart';
import 'package:hng_auth_sdk/src/core/auth_service.dart';
import 'package:hng_auth_sdk/src/ui/widgets/social_auth_buttons.dart';
import 'package:hng_auth_sdk/src/ui/widgets/custom_checkbutton.dart';

import 'email_login_form.dart';

class AuthWidget extends ConsumerStatefulWidget {
  final AuthConfig config;
  final VoidCallback? onSuccess;
  final Function(String)? onError;

  const AuthWidget({
    super.key,
    required this.config,
    this.onSuccess,
    this.onError,
  });

  @override
  ConsumerState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends ConsumerState<AuthWidget> {
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    // Create a provider for the AuthService with the widget's config
    final authServiceProvider = Provider<AuthService>((ref) {
      return AuthService(config: widget.config, ref: ref);
    });
    final authService = ref.watch(authServiceProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              Text(
                _isLogin ? 'Welcome Back' : 'Create Account',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              if (widget.config.providers.emailPassword)
                EmailLoginForm(
                  isLogin: _isLogin,
                  onSubmit: (email, password) async {
                    try {
                      if (_isLogin) {
                        await authService.signInWithEmailPassword(
                          email,
                          password,
                        );
                      } else {
                        await authService.signUpWithEmailPassword(
                          email,
                          password,
                        );
                      }
                      widget.onSuccess?.call();
                    } catch (e) {
                      widget.onError?.call(e.toString());
                    }
                  },
                ),
                 SizedBox(height:20.0),
                 CustomCheckbox(
                  label:  _isLogin ? "Remember information" :  "I agree to Platform Terms of Serivce and Privacy Policy",
                  initialValue: false,
                  onChanged: (value) {
                    print("Checkbox is: $value");
                  },
                ),
                  
              const SizedBox(height: 24),

              SocialAuthButtons(
                config: widget.config,
                authService: authService,
                onSuccess: widget.onSuccess,
                onError: widget.onError,
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () => setState(() => _isLogin = !_isLogin),
                child: Text(
                  _isLogin
                      ? "Don't have an account? Sign up"
                      : "Already have an account? Login",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
