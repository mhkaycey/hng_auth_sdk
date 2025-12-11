import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isEnabled; 

  const AuthButton({
    super.key,
    required this.title,
    required this.onPressed,
       this.isEnabled = true, 
  });

  @override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final buttonWidth = screenWidth > 600
      ? screenWidth * 0.7
      : screenWidth; 
    return SizedBox(
      width: buttonWidth, 
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isEnabled ? Colors.blueAccent : Colors.grey[400],      
          foregroundColor: Colors.white, 
          padding: const EdgeInsets.symmetric(vertical: 16.0 ),     
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), 
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
