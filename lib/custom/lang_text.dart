import 'package:com.mybill.app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

class LangText {
  BuildContext context;
  late S local;

  LangText(this.context) {
    local = S.of(context);
  }
}
