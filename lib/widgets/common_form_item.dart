import 'package:flutter/material.dart';

class CommonFormItem extends StatelessWidget {
  final String label;
  final Widget Function(BuildContext context) contenetBuild;
  final Widget suffix;
  final String suffixText;
  final String hintText;
  final ValueChanged<int> onChanged;
  final TextEditingController controller;

  const CommonFormItem(
      {Key key,
      this.label,
      this.contenetBuild,
      this.suffix,
      this.suffixText,
      this.hintText,
      this.onChanged,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:14.0,right:14.0),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0,color: Theme.of(context).dividerColor))),
      child: Row(
      children: <Widget>[
        Container(width: 100.0, child: Text(label, style: TextStyle(fontSize: 16.0, color: Colors.black87),)),
      
       contenetBuild != null ? contenetBuild(context):
      Expanded(child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText),

      )),
      if(suffix!=null) suffix,
      if(suffixText!=null&&suffix==null) Text(suffixText),

      ],
    ) //,
        );
  }
}
