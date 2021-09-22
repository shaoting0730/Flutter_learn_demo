import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../service/baseapi.dart';
import 'input_field.dart';

class PhoneNumberField extends InputField {

  final bool displayContryCode ;
  final String phoneNumber;
  PhoneNumberField({Key key, this.displayContryCode = true, this.phoneNumber}):super(key: key);
 
  @override
  State<PhoneNumberField> createState() {
    return PhoneNumberFieldState();
  }

} 

class PhoneNumberFieldState extends InputFieldState<PhoneNumberField> {

  String _phoneRegionCode = isOnlyForPerson ? "+86" : "+1";

  String _phoneNumber;
  TextEditingController _editingController = TextEditingController();

  String phoneNumber() {
    if(_phoneNumber == null || _phoneNumber == "") {
      return "";
    }
    return _phoneRegionCode+_phoneNumber;
  } 

  void setPhoneNumber(String phoneNumber) {
    setState(() {
      if(phoneNumber != null) {
        _phoneNumber = phoneNumber;
        if(_phoneNumber.indexOf("+86") == 0){
          _phoneNumber = _phoneNumber.substring(3);
          _phoneRegionCode = "+86";
        } else if(_phoneNumber.indexOf("+44") == 0) {
          _phoneNumber = _phoneNumber.substring(3);
          _phoneRegionCode = "+44";
        } else if(_phoneNumber.indexOf("+1") == 0) {
          _phoneNumber = _phoneNumber.substring(2);
          _phoneRegionCode = "+1";
        }
        _editingController.text = _phoneNumber;
      }  
    });
  }

  @override
  void initState() {
    super.initState();

    setPhoneNumber(widget.phoneNumber);
    
  }

  

  @override
  Widget buildFieldContent(BuildContext context) {
    var node = new FocusNode();

    var list = List<Widget>();

    if(widget.displayContryCode) {
      list.add(
        InkWell(
          onTap: () {
            _onSelectedRegion(context);
          },
          child: Container(
            height: 40,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: <Widget>[
                Text(_phoneRegionCode, style: TextStyle(fontSize: 14, color: Color(0xFF727E98), fontWeight: FontWeight.w600),),
                SizedBox(width: 8,),
                Image.asset('assets/down_arrow.png', color: Color(0xFF727E98),)
              ],
            ),
          )
        )
      );

      list.add(
        Container(
          height: 40.0,
          width: 1.0,
          color: Color(0xFF727E98),
        )
      );
    }

    list.add(
      Expanded(
        child:TextField(
          controller: _editingController,
          onChanged: (str) {
            _phoneNumber = str;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            border: InputBorder.none
          ),
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number,
          onSubmitted: (text) {
            FocusScope.of(context).reparentIfNeeded(node);
          }
        )
      ),
    );
    return Container(
      child: Row(
        children: list
      ),
    );
  }

  void _onSelectedRegion(BuildContext context) {
    List<PickerItem<String>> items = List<PickerItem<String>>();

    items.add(PickerItem(text: Text("+1"), value: "+1"));
    items.add(PickerItem(text: Text("+86"), value: "+86"));
    items.add(PickerItem(text: Text("+44"), value: "+44"));
    if(isOnlyForPerson)
    {
      items.add(PickerItem(text: Text("+20"), value: "+20"));
      items.add(PickerItem(text: Text("+211"), value: "+211"));
      items.add(PickerItem(text: Text("+212"), value: "+212"));
      items.add(PickerItem(text: Text("+213"), value: "+213"));
      items.add(PickerItem(text: Text("+216"), value: "+216"));
      items.add(PickerItem(text: Text("+218"), value: "+218"));
      items.add(PickerItem(text: Text("+220"), value: "+220"));
      items.add(PickerItem(text: Text("+221"), value: "+221"));
      items.add(PickerItem(text: Text("+222"), value: "+222"));
      items.add(PickerItem(text: Text("+223"), value: "+223"));
      items.add(PickerItem(text: Text("+224"), value: "+224"));
      items.add(PickerItem(text: Text("+225"), value: "+225"));
      items.add(PickerItem(text: Text("+226"), value: "+226"));
      items.add(PickerItem(text: Text("+227"), value: "+227"));
      items.add(PickerItem(text: Text("+228"), value: "+228"));
      items.add(PickerItem(text: Text("+229"), value: "+229"));
      items.add(PickerItem(text: Text("+230"), value: "+230"));
      items.add(PickerItem(text: Text("+231"), value: "+231"));
      items.add(PickerItem(text: Text("+232"), value: "+232"));
      items.add(PickerItem(text: Text("+233"), value: "+233"));
      items.add(PickerItem(text: Text("+234"), value: "+234"));
      items.add(PickerItem(text: Text("+235"), value: "+235"));
      items.add(PickerItem(text: Text("+236"), value: "+236"));
      items.add(PickerItem(text: Text("+237"), value: "+237"));
      items.add(PickerItem(text: Text("+238"), value: "+238"));
      items.add(PickerItem(text: Text("+239"), value: "+239"));
      items.add(PickerItem(text: Text("+240"), value: "+240"));
      items.add(PickerItem(text: Text("+241"), value: "+241"));
      items.add(PickerItem(text: Text("+242"), value: "+242"));
      items.add(PickerItem(text: Text("+243"), value: "+243"));
      items.add(PickerItem(text: Text("+244"), value: "+244"));
      items.add(PickerItem(text: Text("+245"), value: "+245"));
      items.add(PickerItem(text: Text("+246"), value: "+246"));
      items.add(PickerItem(text: Text("+247"), value: "+247"));
      items.add(PickerItem(text: Text("+248"), value: "+248"));
      items.add(PickerItem(text: Text("+249"), value: "+249"));
      items.add(PickerItem(text: Text("+250"), value: "+250"));
      items.add(PickerItem(text: Text("+251"), value: "+251"));
      items.add(PickerItem(text: Text("+252"), value: "+252"));
      items.add(PickerItem(text: Text("+253"), value: "+253"));
      items.add(PickerItem(text: Text("+254"), value: "+254"));
      items.add(PickerItem(text: Text("+255"), value: "+255"));
      items.add(PickerItem(text: Text("+256"), value: "+256"));
      items.add(PickerItem(text: Text("+257"), value: "+257"));
      items.add(PickerItem(text: Text("+258"), value: "+258"));
      items.add(PickerItem(text: Text("+259"), value: "+259"));
      items.add(PickerItem(text: Text("+260"), value: "+260"));
      items.add(PickerItem(text: Text("+261"), value: "+261"));
      items.add(PickerItem(text: Text("+262"), value: "+262"));
      items.add(PickerItem(text: Text("+263"), value: "+263"));
      items.add(PickerItem(text: Text("+264"), value: "+264"));
      items.add(PickerItem(text: Text("+265"), value: "+265"));
      items.add(PickerItem(text: Text("+266"), value: "+266"));
      items.add(PickerItem(text: Text("+267"), value: "+267"));
      items.add(PickerItem(text: Text("+268"), value: "+268"));
      items.add(PickerItem(text: Text("+269"), value: "+269"));
      items.add(PickerItem(text: Text("+27"), value: "+27"));
      items.add(PickerItem(text: Text("+290"), value: "+290"));
      items.add(PickerItem(text: Text("+291"), value: "+291"));
      items.add(PickerItem(text: Text("+297"), value: "+297"));
      items.add(PickerItem(text: Text("+298"), value: "+298"));
      items.add(PickerItem(text: Text("+299"), value: "+299"));
      items.add(PickerItem(text: Text("+30"), value: "+30"));
      items.add(PickerItem(text: Text("+31"), value: "+31"));
      items.add(PickerItem(text: Text("+32"), value: "+32"));
      items.add(PickerItem(text: Text("+33"), value: "+33"));
      items.add(PickerItem(text: Text("+34"), value: "+34"));
      items.add(PickerItem(text: Text("+350"), value: "+350"));
      items.add(PickerItem(text: Text("+351"), value: "+351"));
      items.add(PickerItem(text: Text("+352"), value: "+352"));
      items.add(PickerItem(text: Text("+353"), value: "+353"));
      items.add(PickerItem(text: Text("+354"), value: "+354"));
      items.add(PickerItem(text: Text("+355"), value: "+355"));
      items.add(PickerItem(text: Text("+356"), value: "+356"));
      items.add(PickerItem(text: Text("+357"), value: "+357"));
      items.add(PickerItem(text: Text("+358"), value: "+358"));
      items.add(PickerItem(text: Text("+359"), value: "+359"));
      items.add(PickerItem(text: Text("+36"), value: "+36"));
      items.add(PickerItem(text: Text("+37"), value: "+37"));
      items.add(PickerItem(text: Text("+370"), value: "+370"));
      items.add(PickerItem(text: Text("+371"), value: "+371"));
      items.add(PickerItem(text: Text("+372"), value: "+372"));
      items.add(PickerItem(text: Text("+373"), value: "+373"));
      items.add(PickerItem(text: Text("+374"), value: "+374"));
      items.add(PickerItem(text: Text("+375"), value: "+375"));
      items.add(PickerItem(text: Text("+376"), value: "+376"));
      items.add(PickerItem(text: Text("+377"), value: "+377"));
      items.add(PickerItem(text: Text("+378"), value: "+378"));
      items.add(PickerItem(text: Text("+379"), value: "+379"));
      items.add(PickerItem(text: Text("+38"), value: "+38"));
      items.add(PickerItem(text: Text("+380"), value: "+380"));
      items.add(PickerItem(text: Text("+381"), value: "+381"));
      items.add(PickerItem(text: Text("+382"), value: "+382"));
      items.add(PickerItem(text: Text("+385"), value: "+385"));
      items.add(PickerItem(text: Text("+386"), value: "+386"));
      items.add(PickerItem(text: Text("+387"), value: "+387"));
      items.add(PickerItem(text: Text("+388"), value: "+388"));
      items.add(PickerItem(text: Text("+389"), value: "+389"));
      items.add(PickerItem(text: Text("+39"), value: "+39"));
      items.add(PickerItem(text: Text("+40"), value: "+40"));
      items.add(PickerItem(text: Text("+41"), value: "+41"));
      items.add(PickerItem(text: Text("+42"), value: "+42"));
      items.add(PickerItem(text: Text("+420"), value: "+420"));
      items.add(PickerItem(text: Text("+421"), value: "+421"));
      items.add(PickerItem(text: Text("+423"), value: "+423"));
      items.add(PickerItem(text: Text("+43"), value: "+43"));
      items.add(PickerItem(text: Text("+44"), value: "+44"));
      items.add(PickerItem(text: Text("+45"), value: "+45"));
      items.add(PickerItem(text: Text("+46"), value: "+46"));
      items.add(PickerItem(text: Text("+47"), value: "+47"));
      items.add(PickerItem(text: Text("+48"), value: "+48"));
      items.add(PickerItem(text: Text("+49"), value: "+49"));
      items.add(PickerItem(text: Text("+500"), value: "+500"));
      items.add(PickerItem(text: Text("+501"), value: "+501"));
      items.add(PickerItem(text: Text("+502"), value: "+502"));
      items.add(PickerItem(text: Text("+503"), value: "+503"));
      items.add(PickerItem(text: Text("+504"), value: "+504"));
      items.add(PickerItem(text: Text("+505"), value: "+505"));
      items.add(PickerItem(text: Text("+506"), value: "+506"));
      items.add(PickerItem(text: Text("+507"), value: "+507"));
      items.add(PickerItem(text: Text("+508"), value: "+508"));
      items.add(PickerItem(text: Text("+509"), value: "+509"));
      items.add(PickerItem(text: Text("+51"), value: "+51"));
      items.add(PickerItem(text: Text("+52"), value: "+52"));
      items.add(PickerItem(text: Text("+53"), value: "+53"));
      items.add(PickerItem(text: Text("+54"), value: "+54"));
      items.add(PickerItem(text: Text("+55"), value: "+55"));
      items.add(PickerItem(text: Text("+56"), value: "+56"));
      items.add(PickerItem(text: Text("+57"), value: "+57"));
      items.add(PickerItem(text: Text("+58"), value: "+58"));
      items.add(PickerItem(text: Text("+590"), value: "+590"));
      items.add(PickerItem(text: Text("+591"), value: "+591"));
      items.add(PickerItem(text: Text("+592"), value: "+592"));
      items.add(PickerItem(text: Text("+593"), value: "+593"));
      items.add(PickerItem(text: Text("+594"), value: "+594"));
      items.add(PickerItem(text: Text("+595"), value: "+595"));
      items.add(PickerItem(text: Text("+596"), value: "+596"));
      items.add(PickerItem(text: Text("+597"), value: "+597"));
      items.add(PickerItem(text: Text("+598"), value: "+598"));
      items.add(PickerItem(text: Text("+599"), value: "+599"));
      items.add(PickerItem(text: Text("+60"), value: "+60"));
      items.add(PickerItem(text: Text("+61"), value: "+61"));
      items.add(PickerItem(text: Text("+62"), value: "+62"));
      items.add(PickerItem(text: Text("+63"), value: "+63"));
      items.add(PickerItem(text: Text("+64"), value: "+64"));
      items.add(PickerItem(text: Text("+65"), value: "+65"));
      items.add(PickerItem(text: Text("+66"), value: "+66"));
      items.add(PickerItem(text: Text("+670"), value: "+670"));
      items.add(PickerItem(text: Text("+672"), value: "+672"));
      items.add(PickerItem(text: Text("+673"), value: "+673"));
      items.add(PickerItem(text: Text("+674"), value: "+674"));
      items.add(PickerItem(text: Text("+675"), value: "+675"));
      items.add(PickerItem(text: Text("+676"), value: "+676"));
      items.add(PickerItem(text: Text("+677"), value: "+677"));
      items.add(PickerItem(text: Text("+678"), value: "+678"));
      items.add(PickerItem(text: Text("+679"), value: "+679"));
      items.add(PickerItem(text: Text("+680"), value: "+680"));
      items.add(PickerItem(text: Text("+681"), value: "+681"));
      items.add(PickerItem(text: Text("+682"), value: "+682"));
      items.add(PickerItem(text: Text("+683"), value: "+683"));
      items.add(PickerItem(text: Text("+685"), value: "+685"));
      items.add(PickerItem(text: Text("+686"), value: "+686"));
      items.add(PickerItem(text: Text("+687"), value: "+687"));
      items.add(PickerItem(text: Text("+688"), value: "+688"));
      items.add(PickerItem(text: Text("+689"), value: "+689"));
      items.add(PickerItem(text: Text("+690"), value: "+690"));
      items.add(PickerItem(text: Text("+691"), value: "+691"));
      items.add(PickerItem(text: Text("+692"), value: "+692"));
      items.add(PickerItem(text: Text("+7"), value: "+7"));
      items.add(PickerItem(text: Text("+81"), value: "+81"));
      items.add(PickerItem(text: Text("+82"), value: "+82"));
      items.add(PickerItem(text: Text("+84"), value: "+84"));
      items.add(PickerItem(text: Text("+850"), value: "+850"));
      items.add(PickerItem(text: Text("+852"), value: "+852"));
      items.add(PickerItem(text: Text("+853"), value: "+853"));
      items.add(PickerItem(text: Text("+855"), value: "+855"));
      items.add(PickerItem(text: Text("+856"), value: "+856"));
      items.add(PickerItem(text: Text("+86"), value: "+86"));
      items.add(PickerItem(text: Text("+870"), value: "+870"));
      items.add(PickerItem(text: Text("+878"), value: "+878"));
      items.add(PickerItem(text: Text("+880"), value: "+880"));
      items.add(PickerItem(text: Text("+881"), value: "+881"));
      items.add(PickerItem(text: Text("+882"), value: "+882"));
      items.add(PickerItem(text: Text("+886"), value: "+886"));
      items.add(PickerItem(text: Text("+888"), value: "+888"));
      items.add(PickerItem(text: Text("+90"), value: "+90"));
      items.add(PickerItem(text: Text("+91"), value: "+91"));
      items.add(PickerItem(text: Text("+92"), value: "+92"));
      items.add(PickerItem(text: Text("+93"), value: "+93"));
      items.add(PickerItem(text: Text("+94"), value: "+94"));
      items.add(PickerItem(text: Text("+95"), value: "+95"));
      items.add(PickerItem(text: Text("+960"), value: "+960"));
      items.add(PickerItem(text: Text("+961"), value: "+961"));
      items.add(PickerItem(text: Text("+962"), value: "+962"));
      items.add(PickerItem(text: Text("+963"), value: "+963"));
      items.add(PickerItem(text: Text("+964"), value: "+964"));
      items.add(PickerItem(text: Text("+965"), value: "+965"));
      items.add(PickerItem(text: Text("+966"), value: "+966"));
      items.add(PickerItem(text: Text("+967"), value: "+967"));
      items.add(PickerItem(text: Text("+968"), value: "+968"));
      items.add(PickerItem(text: Text("+969"), value: "+969"));
      items.add(PickerItem(text: Text("+970"), value: "+970"));
      items.add(PickerItem(text: Text("+971"), value: "+971"));
      items.add(PickerItem(text: Text("+972"), value: "+972"));
      items.add(PickerItem(text: Text("+973"), value: "+973"));
      items.add(PickerItem(text: Text("+974"), value: "+974"));
      items.add(PickerItem(text: Text("+975"), value: "+975"));
      items.add(PickerItem(text: Text("+976"), value: "+976"));
      items.add(PickerItem(text: Text("+977"), value: "+977"));
      items.add(PickerItem(text: Text("+979"), value: "+979"));
      items.add(PickerItem(text: Text("+98"), value: "+98"));
      items.add(PickerItem(text: Text("+991"), value: "+991"));
      items.add(PickerItem(text: Text("+992"), value: "+992"));
      items.add(PickerItem(text: Text("+993"), value: "+993"));
      items.add(PickerItem(text: Text("+994"), value: "+994"));
      items.add(PickerItem(text: Text("+995"), value: "+995"));
      items.add(PickerItem(text: Text("+996"), value: "+996"));
      items.add(PickerItem(text: Text("+998"), value: "+998"));
    }
    Picker(
      adapter: PickerDataAdapter<String>(data: items),
      changeToFirst: true,
      hideHeader: false,
      onConfirm: (Picker picker, List value) {
        setState(() {
          _phoneRegionCode = picker.getSelectedValues()[0];
        });
      }
    ).showModal(this.context); 
  }

  
}