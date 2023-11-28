import 'package:flutter/cupertino.dart';

class DialogUtils {
  static Future<bool?> showConfirmDialog(
    BuildContext context, {
    String title = 'Confirm',
    String content = 'Do you really want to exit?',
    String noText = 'No',
    String yesText = 'Yes',
  }) async {
    return await showCupertinoDialog<bool?>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(noText),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(yesText),
            ),
          ],
        );
      },
    );
  }
}
