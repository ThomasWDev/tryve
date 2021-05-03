import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;

void initHive(VoidCallback callback) async {
  if (kIsWeb) {
    Hive.openBox('settings').then((_) {
      Hive.openBox('data').then((_) {
        Hive.openBox('user').then((_) {
          callback();
        });
      });
    });
  } else {
    path.getApplicationDocumentsDirectory().then((appDocumentDir) {
      Hive.init(appDocumentDir.path);
      Hive.openBox('settings').then((_) {
        Hive.openBox('data').then((_) {
          Hive.openBox('user').then((_) {
            callback();
          });
        });
      });
    });
  }
}
