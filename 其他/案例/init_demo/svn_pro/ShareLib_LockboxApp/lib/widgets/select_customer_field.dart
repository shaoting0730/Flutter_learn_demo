import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'input_field.dart';
import '../models/showing.dart';

typedef OnSelectCustomer = void Function(ShowingProfileModel model);
typedef OnEditingCustomName = void Function();

class SelectCustomerField extends InputField {

  final PagedListShowingProfileModel model;
  final OnSelectCustomer onSelectCustomer;
  final OnEditingCustomName onEditingCustomName;
  SelectCustomerField({Key key, this.model, this.onSelectCustomer, this.onEditingCustomName }):super(key: key);

  @override
  State<SelectCustomerField> createState() {
    return SelectCustomerFieldState();
  }

} 

class SelectCustomerFieldState extends InputFieldState<SelectCustomerField> {

  String _text;
  String get text => _text;
  TextEditingController _editingController = TextEditingController();
  @override
  Widget buildFieldContent(BuildContext context) {
    var node = new FocusNode();

    var list = List<Widget>();

    list.add(
      Expanded(
        child:TextField(
          controller: _editingController,
          onChanged: (str) {
            _text = str;
            if(widget.onEditingCustomName != null) {
              widget.onEditingCustomName();
            }
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            border: InputBorder.none
          ),
          onSubmitted: (text) {
            FocusScope.of(context).reparentIfNeeded(node);
          }
        )
      ),
    );
    list.add(
      InkWell(
        onTap: () {
          _onSelectCustomer(context);
        },
      child: Container(
          height: 40,
          width: 40,
          alignment: Alignment(0, 0),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: <Widget>[
              Image.asset('assets/down_arrow.png', color: Color(0xFF727E98),)
            ],
          ),
        )
      )
    );
    
    return Container(
      child: Row(
        children: list
      ),
    );
  }

  void _onSelectCustomer(BuildContext context) {
    List<PickerItem<ShowingProfileModel>> items = List<PickerItem<ShowingProfileModel>>();

    if(widget.model != null) {
      for(int index = 0; index < widget.model.ListObjects.length; index ++ ) {
        var profileModel = widget.model.ListObjects[index];
        items.add(PickerItem(text: Text(profileModel.CustomerName), value: profileModel));
      }  
      Picker(
        adapter: PickerDataAdapter<ShowingProfileModel>(data: items),
        changeToFirst: true,
        hideHeader: false,
        onConfirm: (Picker picker, List value) {
          var selectedValue = picker.getSelectedValues().first as ShowingProfileModel;
          
          setState(() {
            _text = selectedValue.CustomerName;
            _editingController.text = _text;
            if(widget.onSelectCustomer != null) {
              widget.onSelectCustomer(selectedValue);
            }
          });
        }
      ).showModal(this.context); 
    }

  }

}