import 'package:flutter/material.dart';

class EditWidget extends StatelessWidget {
  VoidCallback onTap;
  EditWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 17,
          width: 17,
          child: Image.asset('assets/edit.png'),
        ),
      ),
    );
  }
}
