import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({
    super.key,
    required this.label,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
  final buttonWidth = screenWidth > 600
      ? screenWidth * 0.7
      : screenWidth; 
    return SizedBox(
      width: buttonWidth,
      child: Row(
        children: [
      Checkbox(
        value: _isChecked,
        onChanged: (value) {
          setState(() {
            _isChecked = value ?? false;
          });
          widget.onChanged(value);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), 
          side: BorderSide(
            color:  Colors.grey[600]!,
            width: 1,
          ),
        ),
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.blue; 
          }
          return Colors.white; 
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(horizontal: 0, vertical: 0), 
      ),
      const SizedBox(width: 2),
      Expanded(
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
      ),
        ],
      ),
    );
  }
}
