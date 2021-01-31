import 'package:flutter/material.dart';

Widget buildAppBarContent(
    String title, BuildContext context, Color iconThemeColor) {
  return AppBar(
    title: Text(
      title,
    ),
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: iconThemeColor),
  );
}

Widget buildAppBarContentWithAction(
    BuildContext context, String title, IconButton iconButton) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: Text(
      title,
    ),
    elevation: 0.0,
    iconTheme: Theme.of(context).iconTheme,
    actions: <Widget>[
      iconButton,
    ],
  );
}

Widget buildRaisedButton(
    BuildContext context, String title, Color color, Function onPressed) {
  return Expanded(
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textColor: Colors.white,
        color: color,
        padding: const EdgeInsets.all(8.0),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget buildTextFormField(String labelText, bool obsecureText,
    Widget inkWellStatus, TextInputType keyboardType) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    child: Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        border: Border.all(
          width: 0.8,
          color: Colors.grey,
        ),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obsecureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          labelText: labelText,
          border: InputBorder.none,
          suffix: inkWellStatus,
        ),
      ),
    ),
  );
}

Widget buildIconButtonNumCounter(
    BuildContext context, IconData icon, Function onPressed) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
          icon: Icon(
            icon,
            color: Theme.of(context).accentColor,
          ),
          onPressed: onPressed),
    ),
  );
}

Widget buildSnackBar(BuildContext context, String title, Function onPressed) {
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      action: SnackBarAction(
        onPressed: onPressed,
        label: 'UNDO',
        textColor: Theme.of(context).errorColor,
      ),
      duration: Duration(seconds: 2),
    ),
  );
}
