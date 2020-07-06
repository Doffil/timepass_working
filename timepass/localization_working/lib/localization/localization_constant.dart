
import 'package:flutter/cupertino.dart';
import 'package:localizationworking/localization/demo_localization.dart';

String getTranslated(BuildContext context,String key){
    return DemoLocalizations.of(context).getTranslatedValues(key);
}