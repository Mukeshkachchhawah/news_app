import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget{
  Icon icons;
  VoidCallback ontap;
  CustomIcon({required this.icons, required this.ontap});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: ontap,
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