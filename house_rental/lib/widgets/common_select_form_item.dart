import 'package:flutter/material.dart';
import 'package:house_rental/utils/common_picker/common_picker.dart';
import 'package:house_rental/widgets/common_form_item.dart';

class CommonSelectFormItem extends StatelessWidget {
  final String label;
  final List<String> options;
  final int value;
  final ValueChanged<int> onChange;

  const CommonSelectFormItem({Key key, this.label, this.options, this.value, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonFormItem(
      label: label,
      contenetBuild: (context){
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
              var result = CommonPicker.showPicker(context: context,options: options,value: value);

              result.then((selectedValue){
                if(value!=selectedValue &&
                  selectedValue != null && 
                  onChange!=null){
                    onChange(selectedValue);
                }
              });
            },
            child: Container(
            height:40.0,
            child: Row(children:<Widget>[
              Text(options[value],style: TextStyle(fontSize: 16.0),),
              Icon(Icons.keyboard_arrow_right)
            ]),
          ),
        );
      },
    );
  }
}