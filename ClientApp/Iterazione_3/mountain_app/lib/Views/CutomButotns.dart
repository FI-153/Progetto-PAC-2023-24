import 'package:flutter/material.dart';
import 'package:mountain_app/Utilities/Misc.dart';

class MainButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double? width;
  final double? borderRadius;
  final Color? color;

  const MainButton(
      {super.key,
      this.borderRadius,
      this.onPressed,
      this.width,
      required this.color,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 16))),
          elevation: 0,
          backgroundColor: color,
          hoverElevation: 0,
          child: Text(
            text,
            style: sottotitoloGrassetto,
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
