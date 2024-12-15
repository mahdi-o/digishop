import 'package:digishop/controller/invoice_controller.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

  class DropDownCustom extends StatefulWidget {
    DropDownCustom({super.key});
 final GetxController xController = Get.find<InvoiceController>();

  @override
  State<DropDownCustom> createState() => _DropDownCustomState();
}

class _DropDownCustomState extends State<DropDownCustom> {


  @override
  Widget build(BuildContext context) {
     return BaseWidget(
    appBar: null,
       bottomNavigation: null,
    child:
    Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            'نام محصول',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: null,
          value: 'selectedValue',
          // onChanged: (String? value) {
          //   setState(() {
          //     selectedValue = value;
          //   });
          // },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            width: 140,
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 8.0),),
          iconStyleData: const IconStyleData(
            openMenuIcon: Icon(Icons.arrow_drop_up),
          ),
        ),
      ),
    ),
     );
  }
}
