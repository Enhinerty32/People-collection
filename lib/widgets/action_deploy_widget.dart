import 'package:flutter/material.dart';
import 'package:get/get.dart';

Column actionDeployWidget(
    {required Widget textTittle,
    Widget? icon,
    required RxBool boolCtx,
    required Widget deployWidget,
    MainAxisAlignment? rowMainAxisAlignment,
    double? borderRadius}) {
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          onTap: () => boolCtx.value = !boolCtx.value,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment:
                  rowMainAxisAlignment ?? MainAxisAlignment.spaceBetween,
              children: [
                textTittle,
                icon ??
                    (boolCtx.value
                        ? Icon(Icons.arrow_drop_up)
                        : Icon(Icons.arrow_drop_down)),
              ],
            ),
          ),
        ),
      ),
      Visibility(visible: boolCtx.value, child: deployWidget),
    ],
  );
}
