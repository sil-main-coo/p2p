import 'package:flutter/material.dart';
import 'package:p2p_borrower/data/model/response/addresses_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_step_action.dart';
import 'package:p2p_borrower/presentation/common/components/layout/compact_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_text_field_suffix_dropdown.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_textfield.dart';
import 'package:p2p_borrower/presentation/journey/select_address/model/address_selected.dart';
import 'package:p2p_borrower/presentation/journey/select_address/widgets/select_address_dialog.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({
    Key? key,
    this.selected,
    required this.title,
    required this.addresses,
  }) : super(key: key);

  final String title;
  final Addresses addresses;
  final AddressSelected? selected;

  @override
  _SelectAddressScreenState createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  final TextEditingController _ctrlProvince = TextEditingController();
  final TextEditingController _ctrlDistrict = TextEditingController();
  final TextEditingController _ctrlWard = TextEditingController();
  final TextEditingController _ctrlDetail = TextEditingController();

  final _formKeyProvince = GlobalKey<FormState>();
  final _formKeyDistrict = GlobalKey<FormState>();
  final _formKeyWard = GlobalKey<FormState>();
  final _formDetail = GlobalKey<FormState>();

  DataAddress? _province;
  Level2s? _district;
  Level3s? _ward;

  void _saveAddress() {
    if (_checkValidateProvince() &&
        _checkValidateDistrict() &&
        _checkValidateWard() &&
        _checkValidateDetail()) {
      Navigator.pop(
          context,
          AddressSelected(
              _province!, _district!, _ward!, _ctrlDetail.text.trim()));
    }
  }

  void _provinceSelected(DataAddress province) {
    setState(() {
      _ctrlProvince.text = province.name!;
      _province = province;

      // clear children data
      _ctrlDistrict.clear();
      _district = null;
      _ctrlWard.clear();
      _ward = null;

      _checkValidateProvince();
    });
  }

  void _districtSelected(Level2s district) {
    setState(() {
      _ctrlDistrict.text = district.name!;
      _district = district;

      // clear child data
      _ctrlWard.clear();
      _ward = null;

      _checkValidateDistrict();
    });
  }

  void _wardSelected(Level3s ward) {
    setState(() {
      _ctrlWard.text = ward.name!;
      _ward = ward;
      _checkValidateWard();
    });
  }

  bool _checkValidateProvince() {
    return _formKeyProvince.currentState!.validate();
  }

  bool _checkValidateDistrict() {
    return _formKeyDistrict.currentState!.validate();
  }

  bool _checkValidateWard() {
    return _formKeyWard.currentState!.validate();
  }

  bool _checkValidateDetail() {
    return _formDetail.currentState!.validate();
  }

  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      _province = widget.selected!.province;
      _district = widget.selected!.district;
      _ward = widget.selected!.ward;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _ctrlProvince.dispose();
    _ctrlDistrict.dispose();
    _ctrlWard.dispose();
    _ctrlDetail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarAction(
        titleText: widget.title,
        callbackLeading: () => Navigator.pop(context),
        leadingTextButton: S.current.cancel,
        textAction: S.current.save,
        callbackAction: () => _saveAddress(),
      ),
      body: CompactLayout(
        child: Column(
          children: [
            Form(
              key: _formKeyProvince,
              child: AppTextFieldSuffixDropDown(
                controller: _ctrlProvince,
                initialValue: widget.selected != null
                    ? widget.selected!.province!.name
                    : null,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '${S.current.dropDownValidateText} ${S.current.provinceOrCity}';
                  }
                  return null;
                },
                onTapFieldCallback: () => SelectAddressDialog.show<DataAddress>(
                    context: context,
                    data: widget.addresses.data!,
                    dataSelected: widget.addresses.data![0],
                    callbackSelect: _provinceSelected),
                labelText: S.current.provinceOrCity,
                hintText: S.current.clickToSelect,
              ),
            ),
            VerticalSpace(
              height: 24,
            ),
            Form(
              key: _formKeyDistrict,
              child: AppTextFieldSuffixDropDown(
                controller: _ctrlDistrict,
                initialValue: widget.selected != null
                    ? widget.selected!.district!.name
                    : null,
                validator: (value) {
                  if (value!.isEmpty && _province != null) {
                    return '${S.current.dropDownValidateText} ${S.current.district}';
                  }
                  return null;
                },
                onTapFieldCallback: () {
                  if (_checkValidateProvince()) {
                    SelectAddressDialog.show<Level2s>(
                        context: context,
                        data: _province!.level2s!,
                        dataSelected: _province!.level2s![0],
                        callbackSelect: _districtSelected);
                  }
                },
                labelText: S.current.district,
                hintText: S.current.clickToSelect,
              ),
            ),
            VerticalSpace(
              height: 24,
            ),
            Form(
              key: _formKeyWard,
              child: AppTextFieldSuffixDropDown(
                controller: _ctrlWard,
                initialValue: widget.selected != null
                    ? widget.selected!.ward!.name
                    : null,
                validator: (value) {
                  if (value!.isEmpty &&
                      _district != null &&
                      _province != null) {
                    return '${S.current.dropDownValidateText} ${S.current.ward}';
                  }
                  return null;
                },
                onTapFieldCallback: () {
                  if (_checkValidateProvince() && _checkValidateDistrict()) {
                    SelectAddressDialog.show<Level3s>(
                        context: context,
                        data: _district!.level3s!,
                        dataSelected: _district!.level3s![0],
                        callbackSelect: _wardSelected);
                  }
                },
                labelText: S.current.ward,
                hintText: S.current.clickToSelect,
              ),
            ),
            VerticalSpace(
              height: 24,
            ),
            Form(
              key: _formDetail,
              child: AppTextField(
                controller: _ctrlDetail,
                initialValue:
                    widget.selected != null ? widget.selected!.detail : null,
                maxLen: 50,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '${S.current.dropDownValidateText} ${S.current.address}';
                  }
                },
                labelText: S.current.address,
                hintText: S.current.hintDetailAddress,
              ),
            )
          ],
        ),
      ),
    );
  }
}
