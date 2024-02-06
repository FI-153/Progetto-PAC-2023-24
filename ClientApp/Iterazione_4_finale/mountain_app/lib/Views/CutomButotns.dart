import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? width;
  final double? borderRadius;
  final Color? color;
  final Color? textColor;

  const MainButton(
      {super.key,
      this.borderRadius,
      this.onPressed,
      this.width,
      this.textColor,
      this.color,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200,
      child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 24))),
          elevation: 0,
          backgroundColor: color ?? Theme.of(context).colorScheme.secondary,
          hoverElevation: 0,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: textColor ?? Colors.white,
              fontSize: 17,
            ),
          ),
          onPressed: onPressed),
    );
  }
}

class MenuButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final double iconSize;

  const MenuButton(
      {super.key, this.onPressed, required this.icon, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      iconSize: iconSize,
      onPressed: onPressed ?? () {},
    );
  }
}
