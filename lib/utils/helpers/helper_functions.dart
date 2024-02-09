
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class THelperFunctions {
  static Color getColor(String value) {
    if(value == 'Green' || value == 'Vert') {
      return Colors.green;
    }else if(value == 'Red' || value == 'Rouge') {
      return Colors.red;
    }else if(value == 'Blue' || value == 'Bleu') {
      return Colors.blue;
    }else if(value == 'Yellow' || value == 'Jaune') {
      return Colors.yellow;
    }else if(value == 'Orange' || value == 'Orange') {
      return Colors.orange;
    }else if(value == 'Purple' || value == 'Violet') {
      return Colors.purple;
    }else if(value == 'Pink' || value == 'Rose') {
      return Colors.pink;
    }else if(value == 'Cyan' || value == 'Cyan') {
      return Colors.cyan;
    }else if(value == 'Teal' || value == 'Turquoise') {
      return Colors.teal;
    }else if(value == 'Black' || value == 'Noir') {
      return Colors.black;
    }else if(value == 'White' || value == 'Blanc') {
      return Colors.white;
    }else if(value == 'Brown' || value == 'Marron') {
      return Colors.brown;
    }else if(value == 'Grey' || value == 'Gris') {
      return Colors.grey;
    }
    return Colors.transparent;
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        }
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int length) {
    if(text.length > length) {
      return text;
    } else {
      return '${text.substring(0, length)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery
        .of(Get.context!)
        .size
        .height;
  }

  static double screenWidth() {
    return MediaQuery
        .of(Get.context!)
        .size
        .width;
  }

  static String getFormattedDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for(var i=0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(
        children: rowChildren,
      ));
    }
    return wrappedList;
  }

}