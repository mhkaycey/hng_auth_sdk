// import 'package:flutter/material.dart';
// import 'package:hng_auth_sdk/src/exceptions/auth_exceptions.dart';
// import '../../core/auth_config.dart';
// import '../../core/auth_service.dart';

// class SocialAuthButtons extends StatefulWidget {
//   final AuthConfig config;
//   final AuthService authService;
//   final VoidCallback? onSuccess;
//   final Function(String)? onError;

//   const SocialAuthButtons({
//     super.key,
//     required this.config,
//     required this.authService,
//     this.onSuccess,
//     this.onError,
//   });

//   @override
//   State<SocialAuthButtons> createState() => _SocialAuthButtonsState();
// }

// class _SocialAuthButtonsState extends State<SocialAuthButtons> {
//   bool _isGoogleLoading = false;
//   bool _isAppleLoading = false;

//   Future<void> _handleGoogleSignIn() async {
//     setState(() => _isGoogleLoading = true);
//     try {
//       await widget.authService.signInWithGoogle();
//       widget.onSuccess?.call();
//     } on AuthCancelledException {
//       // User cancelled, do nothing
//     } on AuthException catch (e) {
//       widget.onError?.call(e.message);
//     } catch (e) {
//       widget.onError?.call('An unexpected error occurred');
//     } finally {
//       if (mounted) {
//         setState(() => _isGoogleLoading = false);
//       }
//     }
//   }

//   Future<void> _handleAppleSignIn() async {
//     setState(() => _isAppleLoading = true);
//     try {
//       await widget.authService.signInWithApple();
//       widget.onSuccess?.call();
//     } on AuthCancelledException {
//       // User cancelled, do nothing
//     } on AuthException catch (e) {
//       widget.onError?.call(e.message);
//     } catch (e) {
//       widget.onError?.call('An unexpected error occurred');
//     } finally {
//       if (mounted) {
//         setState(() => _isAppleLoading = false);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final hasSocialAuth =
//         widget.config.providers.google || widget.config.providers.apple;

//     if (!hasSocialAuth) return const SizedBox.shrink();

//     return Column(
//       children: [
//         if (widget.config.providers.emailPassword)
//           Row(
//             children: [
//               Expanded(child: Divider()),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Text('OR', style: TextStyle(color: Colors.grey)),
//               ),
//               Expanded(child: Divider()),
//             ],
//           ),
//         const SizedBox(height: 24),

//         // Google Sign In Button
//         if (widget.config.providers.google)
//           SizedBox(
//             height: 50,
//             width: double.infinity,
//             child: OutlinedButton.icon(
//               onPressed: _isGoogleLoading ? null : _handleGoogleSignIn,
//               icon: _isGoogleLoading
//                   ? const SizedBox(
//                       height: 20,
//                       width: 20,
//                       child: CircularProgressIndicator(strokeWidth: 2),
//                     )
//                   : Image.asset(
//                       'assets/google_icon.png',
//                       height: 10,
//                       width: 10,
//                     ),
//               label: const Text('Continue with Google'),
//               style: OutlinedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//         if (widget.config.providers.google && widget.config.providers.apple)
//           const SizedBox(height: 12),

//         // Apple Sign In Button
//         if (widget.config.providers.apple)
//           SizedBox(
//             height: 50,
//             width: double.infinity,
//             child: OutlinedButton.icon(
//               onPressed: _isAppleLoading ? null : _handleAppleSignIn,
//               icon: _isAppleLoading
//                   ? const SizedBox(
//                       height: 20,
//                       width: 20,
//                       child: CircularProgressIndicator(strokeWidth: 2),
//                     )
//                   : const Icon(Icons.apple, size: 24),
//               label: const Text('Continue with Apple1'),
//               style: OutlinedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hng_auth_sdk/src/exceptions/auth_exceptions.dart';
import '../../core/auth_config.dart';
import '../../core/auth_service.dart';
import 'package:hng_auth_sdk/src/ui/widgets/provider_button.dart';

class SocialAuthButtons extends StatefulWidget {
  final AuthConfig config;
  final AuthService authService;
  final VoidCallback? onSuccess;
  final Function(String)? onError;

  const SocialAuthButtons({
    super.key,
    required this.config,
    required this.authService,
    this.onSuccess,
    this.onError,
  });

  @override
  State<SocialAuthButtons> createState() => _SocialAuthButtonsState();
}

class _SocialAuthButtonsState extends State<SocialAuthButtons> {
  bool _isGoogleLoading = false;
  bool _isAppleLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isGoogleLoading = true);
    try {
      await widget.authService.signInWithGoogle();
      widget.onSuccess?.call();
    } on AuthCancelledException {
      // User cancelled, do nothing
    } on AuthException catch (e) {
      widget.onError?.call(e.message);
    } catch (e) {
      widget.onError?.call('An unexpected error occurred');
    } finally {
      if (mounted) {
        setState(() => _isGoogleLoading = false);
      }
    }
  }

  Future<void> _handleAppleSignIn() async {
    setState(() => _isAppleLoading = true);
    try {
      await widget.authService.signInWithApple();
      widget.onSuccess?.call();
    } on AuthCancelledException {
      // User cancelled, do nothing
    } on AuthException catch (e) {
      widget.onError?.call(e.message);
    } catch (e) {
      widget.onError?.call('An unexpected error occurred');
    } finally {
      if (mounted) {
        setState(() => _isAppleLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasSocialAuth =
        widget.config.providers.google || widget.config.providers.apple;

    if (!hasSocialAuth) return const SizedBox.shrink();

    return Column(
      children: [
        if (widget.config.providers.emailPassword)
          Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('OR', style: TextStyle(color: Colors.grey)),
              ),
              Expanded(child: Divider()),
            ],
          ),
        const SizedBox(height: 24),

        // Google Sign In Button
        if (widget.config.providers.google)
          // Image.asset(
          //   'assets/google_icon.png',
          //   package: 'hng_auth_sdk',),
          SvgBorderButton(
            svgAsset: 'assets/icons/googleicon.svg',
            package: 'hng_auth_sdk',
            title: _isGoogleLoading ? 'Signing in...' : 'Continue with Google',
            onPressed: _isGoogleLoading ? () {} : _handleGoogleSignIn,
          ),
        if (widget.config.providers.google && widget.config.providers.apple)
          const SizedBox(height: 12),

        // Apple Sign In Button
        if (widget.config.providers.apple)
          SvgBorderButton(
            svgAsset: 'assets/icons/appleicon.svg', // Replace with your SVG
            package: 'hng_auth_sdk',
            title: _isAppleLoading ? 'Signing in...' : 'Continue with Apple',
            onPressed: _isAppleLoading ? () {} : _handleAppleSignIn,
          ),
      ],
    );
  }
}
