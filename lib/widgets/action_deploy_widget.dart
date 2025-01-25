import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionDeployWidget extends StatelessWidget {
  final Widget textTitle;
  final Widget? icon;
  final RxBool boolCtx;
  final Widget deployWidget;
  final MainAxisAlignment? rowMainAxisAlignment;
  final double? borderRadius;
  final CrossAxisAlignment? crossAxisAlignmentColumn;

   ActionDeployWidget({super.key, 
    required this.textTitle,
    this.icon,
    required this.boolCtx,
    required this.deployWidget,
    this.rowMainAxisAlignment,
    this.borderRadius, this.crossAxisAlignmentColumn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment:crossAxisAlignmentColumn ?? CrossAxisAlignment.start,
      children: [
        InkWell(
          
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          onTap: () => boolCtx.value = !boolCtx.value,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: rowMainAxisAlignment ?? MainAxisAlignment.spaceBetween,
              children: [
                textTitle,
                Obx(() => AnimatedCrossFade(
                      firstChild: icon ?? Icon(Icons.arrow_drop_down),
                      secondChild: icon ?? Icon(Icons.arrow_drop_up),
                      crossFadeState: boolCtx.value
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: Duration(milliseconds: 200),
                    )),
              ],
            ),
          ),
        ),
        Obx(() => AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: boolCtx.value ? deployWidget : SizedBox.shrink(),
            )),
      ],
    );
  }

}