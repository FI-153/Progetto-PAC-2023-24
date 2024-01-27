import 'package:flutter/material.dart';

TextStyle tileTitle = const TextStyle(
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontSize: 23,
);

TextStyle titolo = const TextStyle(
  fontWeight: FontWeight.w600,
  color: Colors.black,
  fontSize: 30,
);

TextStyle sottotitoloGrassetto = const TextStyle(
  fontWeight: FontWeight.w600,
  color: Colors.black,
  fontSize: 15,
);

TextStyle sottotitolo = const TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.black,
  fontSize: 15,
);

TextStyle sottotitoloRed = const TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.red,
  fontSize: 15,
);

TextStyle sottotitoloLink = const TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.blueAccent,
  fontSize: 15,
);

TextStyle sottotitoloOpaco = const TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.black54,
  fontSize: 15,
);

Widget customDivider() {
  return const Divider(indent: 16, endIndent: 16);
}

Widget customTextFieldSection(
  IconData icon,
  String name,
  String text,
  TextEditingController controller,
  bool isRequired,
  bool obscured,
  TextInputType keyboardType,
  bool allowEmpty,
) {
  return Container(
    height: 110,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "$name" + ((isRequired) ? "*" : ""),
          style: sottotitoloGrassetto,
        ),
        CustomTextField(
          icon,
          text,
          controller,
          obscured,
          keyboardType,
          allowEmpty,
        ),
      ],
    ),
  );
}

Widget CustomTextField(
  IconData icon,
  String hintText,
  TextEditingController _controller,
  bool obscureText,
  TextInputType keyboardType,
  bool allowEmpty,
) {
  return TextFormField(
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.black38),
      border: OutlineInputBorder(),
      prefixIcon: Icon(icon),
      prefixIconColor: Colors.black38,
    ),
    controller: _controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    validator: (value) {
      if (!allowEmpty && (value == null || value.isEmpty)) {
        return "Richiesto";
      }

      return null;
    },
    autocorrect: false,
  );
}

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
