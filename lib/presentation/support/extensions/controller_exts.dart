import 'package:flutter/cupertino.dart';

extension RestoreExts on TextEditingController {

  void updateOnRestore(String? stateValue) {
    if (text.isEmpty){
      text = (text != stateValue ? stateValue ?? "" : text);
    }
  }

  void updateOnRestoreOnChanged(String? stateValue) {
    text = (text != stateValue ? stateValue ?? "" : text);
  }
}
