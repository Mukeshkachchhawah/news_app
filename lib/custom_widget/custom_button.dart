// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget{
  Icon icons;
  VoidCallback onTap;
  CustomIcon({super.key, required this.icons, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white
          ),
          child: Center(
            child: icons,
          ),
        ),
    );
  }
}