import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CommonPicker {
  static Future<int> showPicker({
    BuildContext context,
    List<String> options,
    int value,
  }) {
    return showCupertinoModalPopup<int>(
        context: context,
        builder: (BuildContext context) {
          var buttonTextStyle = TextStyle(color:Theme.of(context).primaryColor,fontWeight: FontWeight.w600);

          var controller = FixedExtentScrollController(initialItem: value);

          return Container(
              color: Colors.grey,
              height: 300,
              child: Column(children: <Widget>[
                Container(
                  color: Colors.white,
                  height: 40.0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('取消',style: buttonTextStyle,),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(controller.selectedItem);
                          },
                          child: Text('确定·',style: buttonTextStyle,),
                        )
                      ]),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: controller,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    itemExtent: 32.0,
                    onSelectedItemChanged: (val) {},
                    children: options.map((f) => Text(f)).toList(),
                  ),
                )
              ]));
        });
  }
}
