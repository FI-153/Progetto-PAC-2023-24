import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mountain_app/Utilities/Misc.dart';

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

Widget customTextFieldDateSection(
    IconData icon,
    String name,
    String text,
    TextEditingController controller,
    bool isRequired,
    bool obscured,
    TextInputType keyboardType,
    bool allowEmpty,
    BuildContext context) {
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
        CustumDatePicker(
          icon,
          text,
          controller,
          obscured,
          keyboardType,
          allowEmpty,
          context,
        ),
      ],
    ),
  );
}

Widget CustumDatePicker(
  IconData icon,
  String hintText,
  TextEditingController _controller,
  bool obscureText,
  TextInputType keyboardType,
  bool allowEmpty,
  BuildContext context,
) {
  return TextField(
      controller: _controller,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.black38),
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.date_range),
        prefixIconColor: Colors.black38,
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );

        String formattedDate =
            DateFormat('yyyy-MM-dd').format(pickedDate ?? DateTime.now());

        _controller.text = formattedDate;
      });
}
