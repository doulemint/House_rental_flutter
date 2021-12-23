import 'package:flutter/material.dart';

import 'function_button_data.dart';
import 'function_button_widget.dart';

class FunctionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 1.0,
        runSpacing: 1.0,
        children: list
            .map((item) =>
            FunctionButtonWidget(item)
                // Container(
                //   height: 20.0,
                //   width: MediaQuery.of(context).size.width*0.33,
                //   decoration: BoxDecoration(color: Colors.red) )
               )
            .toList(),
      ),
    );
  }
}
