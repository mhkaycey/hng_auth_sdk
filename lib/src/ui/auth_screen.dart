// // lib/src/ui/auth_screen.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../core/auth_config.dart';
// import '../core/auth_service.dart';

// class AuthScreen extends ConsumerWidget {
//   final AuthConfig config;
//   final String? title;

//   const AuthScreen({super.key, required this.config, this.title = "Login"});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Watch the auth state from our provider
//     final authState = ref.watch(authServiceProvider);
//     final authService = ref.read(authServiceProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(title: Text(title!)),
//       body: Center(
//         child: authState.when(
//           data: (state) {
//             if (state is Authenticated) {
//               // User is logged in
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Welcome, ${state.user.email}'),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () => authService.signOut(),
//                     child: const Text('Sign Out'),
//                   ),
//                 ],
//               );
//             }

//             // User is not logged in, show login options
//             return Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   if (config.enableEmailPassword) ...[
//                     const TextField(
//                       decoration: InputDecoration(labelText: 'Email'),
//                     ),
//                     const TextField(
//                       decoration: InputDecoration(labelText: 'Password'),
//                       obscureText: true,
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () => authService.signInWithEmailPassword(
//                         'test@example.com',
//                         'password',
//                       ), // Add real fields
//                       child: const Text('Sign In with Email'),
//                     ),
//                     const SizedBox(height: 16),
//                   ],
//                   if (config.enableGoogle)
//                     ElevatedButton.icon(
//                       icon: const Icon(Icons.login),
//                       label: const Text('Sign In with Google'),
//                       onPressed: () => authService.signInWithGoogle(),
//                     ),
//                   if (config.enableApple &&
//                       Theme.of(context).platform == TargetPlatform.iOS)
//                     ElevatedButton.icon(
//                       icon: const Icon(Icons.apple),
//                       label: const Text('Sign In with Apple'),
//                       onPressed: () => authService.signInWithApple(),
//                     ),
//                 ],
//               ),
//             );
//           },
//           loading: () => const CircularProgressIndicator(),
//           error: (error, stack) {
//             final hngError = error as HngAuthException;
//             return Text(
//               'Error: ${hngError.message}',
//               style: const TextStyle(color: Colors.red),
//               textAlign: TextAlign.center,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
