import 'package:flutter/material.dart';
import 'package:hng_auth_sdk/src/ui/widgets/auth_button.dart';

class EmailLoginForm extends StatefulWidget {
  final bool isLogin;
  final Future<void> Function(String email, String password) onSubmit;

  const EmailLoginForm({
    super.key,
    required this.isLogin,
    required this.onSubmit,
  });

  @override
  State<EmailLoginForm> createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Rebuild widget whenever the text changes
    _emailController.addListener(_updateState);
    _passwordController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {}); // Triggers rebuild to update button color
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await widget.onSubmit(
          _emailController.text.trim(),
          _passwordController.text,
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
     final isFormFilled =
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
        final isButtonEnabled = isFormFilled  && !_isLoading;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email Field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Password Field
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outlined),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (!widget.isLogin && value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
         AuthButton(
            title: _isLoading
                ? 'Processing...'
                : widget.isLogin
                    ? 'Login'
                    : 'Sign Up',
            onPressed: isButtonEnabled ? _handleSubmit : (){},
            isEnabled: isButtonEnabled,
          ),
          // Submit Button
          // SizedBox(
          //   height: 50,
          //   child: ElevatedButton(
          //     onPressed: _isLoading ? null : _handleSubmit,
          //     style: ElevatedButton.styleFrom(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //     child: _isLoading
          //         ? const SizedBox(
          //             height: 20,
          //             width: 20,
          //             child: CircularProgressIndicator(strokeWidth: 2),
          //           )
          //         : Text(
          //             widget.isLogin ? 'Login' : 'Sign Up',
          //             style: const TextStyle(fontSize: 16),
          //           ),
          //   ),
          // ),
        ],
      ),
    );
  }
}


