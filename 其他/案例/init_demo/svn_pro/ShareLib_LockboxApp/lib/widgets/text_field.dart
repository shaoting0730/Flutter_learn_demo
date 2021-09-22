import 'package:flutter/material.dart';
import 'input_field.dart';


typedef TextInputFieldTextChanged = void Function(String);
class TextInputField extends InputField {

  final int maxLines;
  final String text;
  final TextInputFieldTextChanged textInputFieldTextChanged;
  final bool enabled;
  TextInputField({Key key, double height = 40, this.maxLines = 1, this.text = "", this.textInputFieldTextChanged, this.enabled = true}):super(key: key, height: height);

  @override
  State<TextInputField> createState() {
    return TextInputFieldState();
  }

} 

class TextInputFieldState extends InputFieldState<TextInputField> {

  String _text = "";
  String get text => _text;
  TextEditingController _editingController;

  void setText(String text) {
    _editingController.text = text;
  }
  
  @override
  void initState() {
    super.initState();
    _text = widget.text;
    _editingController = TextEditingController(text: _text);
    
  }

  @override
  Widget buildFieldContent(BuildContext context) {
    var node = new FocusNode();
    return Container(
      child: TextField(
        enabled: widget.enabled,
        controller: _editingController,
        onChanged: (str) {
          _text = str;
          if(widget.textInputFieldTextChanged != null) {
            widget.textInputFieldTextChanged(_text);
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          border: InputBorder.none
        ),
        maxLines: widget.maxLines,
        onSubmitted: (text) {
          FocusScope.of(context).reparentIfNeeded(node);
        }
      )
    );
  }
}