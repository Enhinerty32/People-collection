import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ViewPersonPageSettings extends GetxService {
  var general_information_deplegate_value = false.obs;  
  var interest_deplegate_value = false.obs;  
  var touch_sensitive_body_deplegate_value =false.obs;
  var psychological_analysis_deplegate_value =false.obs;
  var diagnosed_data_deplegate_value =false.obs;
  var contact_about_deplegate_value =false.obs;

  final List<Widget> items = [];


}