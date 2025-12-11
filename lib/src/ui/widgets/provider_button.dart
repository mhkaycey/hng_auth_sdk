import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgBorderButton extends StatelessWidget {
  final String svgAsset;
  final String title;
  final VoidCallback onPressed;
  final String package;

  const SvgBorderButton({
    super.key,
    required this.svgAsset,
    required this.title,
    required this.onPressed,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth > 600 ? screenWidth * 0.7 : screenWidth;
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: buttonWidth,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                svgAsset,
                width: 35,
                height: 35,
                package: package,
                placeholderBuilder: (context) =>
                    const Icon(Icons.image_not_supported, size: 24),
              ),

              SizedBox(width: screenWidth > 600 ? 40 : 20),

              Container(height: 30, width: 2, color: Colors.grey),

              // SizedBox(width: screenWidth > 600 ? 60 : 20),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
