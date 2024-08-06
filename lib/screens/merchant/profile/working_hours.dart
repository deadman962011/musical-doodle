import 'package:com.mybill.app/custom/box_decorations.dart';
import 'package:com.mybill.app/custom/input_decorations.dart';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/helpers/shimmer_helper.dart';
import 'package:com.mybill.app/models/responses/merchant/availability/merchant_availability_response.dart';
import 'package:com.mybill.app/my_theme.dart';
import 'package:com.mybill.app/repositories/merchant/merchant_repository.dart';
import 'package:com.mybill.app/ui_elements/merchant_appbar.dart';
import 'package:flutter/material.dart';
import 'package:com.mybill.app/ui_elements/merchant_drawer.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:com.mybill.app/generated/l10n.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart' as intl;
import 'package:toast/toast.dart';

class WorkingHours extends StatefulWidget {
  const WorkingHours({super.key});

  @override
  _WorkingHoursState createState() => _WorkingHoursState();
}

class _WorkingHoursState extends State<WorkingHours> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormBuilderState>();

  bool isLoading = true;
  bool isLoadingInBackground = false;

  List<AvailabilityDay> _availability_days = [];

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  fetchAll() {
    setState(() {
      isLoadingInBackground = true;
    });
    fetchAvailability();
  }

  reset() {
    setState(() {
      isLoading = true;
    });
    fetchAll();
  }

  fetchAvailability() async {
    var response = await MerchantRepository().getMerchantAvailabilityResponse();
    if (response.runtimeType.toString() == 'MerchantAvailabilityResponse') {
      setState(() {
        _availability_days = response.payload;
      });
    } else {}

    setState(() {
      isLoading = false;
      isLoadingInBackground = false;
    });
  }

  toggleDay(int id) async {
    var response =
        await MerchantRepository().getMerchantAvailabilityToggleDayResponse(id);
    if (response.runtimeType.toString() ==
        'MerchantAvailabilityToggleDayStatusResponse') {
      ToastComponent.showDialog(S.of(context).day_status_updated, context,
          gravity: Toast.bottom, duration: Toast.lengthLong);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  addSlot(int id) async {
    var response =
        await MerchantRepository().getMerchantAvailabilityAddSlotResponse(id);
    if (response.runtimeType.toString() ==
        'MerchantAvailabilityAddSlotResponse') {
      fetchAll();
    } else {}
  }

  removeSlot(int id) async {
    var response = await MerchantRepository()
        .getMerchantAvailabilityRemoveSlotResponse(id);
    if (response.runtimeType.toString() ==
        'MerchantAvailabilityAddSlotResponse') {
      fetchAll();
    } else {}
  }

  updatSlot(int id) async {
    _formKey.currentState!.save();

    var response = await MerchantRepository()
        .getMerchantAvailabilityUpdateSlotResponse(
            id,
            _formKey.currentState!.value['start_date_$id'].toString(),
            _formKey.currentState!.value['end_date_$id'].toString());
    if (response.runtimeType.toString() ==
        'MerchantAvailabilityAddSlotResponse') {
      ToastComponent.showDialog(S.of(context).availability_slot_updated, context,
          gravity: Toast.bottom, duration: Toast.lengthLong);
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
    });
    fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: MerchantAppBar.buildMerchantAppBar(context, 'working_hours',
                _scaffoldKey, S.of(context).working_hours),
            drawer: MerchantDrawer.buildDrawer(context),
            backgroundColor: Colors.transparent,
            body: RefreshIndicator(
                color: MyTheme.accent_color,
                backgroundColor: Colors.white,
                displacement: 0,
                onRefresh: _onRefresh,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: SingleChildScrollView(
                    child: isLoading
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ShimmerHelper().buildBasicShimmer(height: 160),
                              ShimmerHelper().buildBasicShimmer(height: 160),
                              ShimmerHelper().buildBasicShimmer(height: 160),
                              ShimmerHelper().buildBasicShimmer(height: 160),
                              ShimmerHelper().buildBasicShimmer(height: 160),
                            ],
                          )
                        : Column(
                            children: [_buildDaySlotsList()],
                          ),
                  ),
                ))));
  }

  Widget _buildDaySlotsList() {
    return FormBuilder(
        key: _formKey,
        child: Column(
            children: _availability_days.map((day) {
          return _buildDaySlotDay(day);
        }).toList()));
  }

  Widget _buildDaySlotDay(AvailabilityDay day) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecorations.buildBoxDecoration_1(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: FormBuilderSwitch(
                  name: 'day_status_${day.id}',
                  title: Text(day.day),
                  initialValue: day.status == 1 ? true : false,
                  activeColor: MyTheme.accent_color,
                  inactiveThumbColor: Colors.grey.shade300,
                  inactiveTrackColor: Colors.grey.shade500,
                  onChanged: (value) {
                    toggleDay(day.id);
                  },
                )),
              ],
            ),
            Column(
              children: day.slots.map((slot) => _buildSlot(slot)).toList(),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: GestureDetector(
                  child: Text(
                    '+ ${S.of(context).add_new_slot}',
                    style: TextStyle(
                        color: isLoadingInBackground
                            ? MyTheme.grey_153
                            : MyTheme.accent_color,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    addSlot(day.id);
                  },
                ))
          ],
        ));
  }

  Widget _buildSlot(AvailabilitySlot slot) {
    DateTime? startDate =
        slot.start != null ? DateTime.parse(slot.start) : null;
    DateTime? endDate = slot.start != null ? DateTime.parse(slot.start) : null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(S.of(context).start),
              ),
              FormBuilderDateTimePicker(
                name: 'start_date_${slot.id}',
                format: intl.DateFormat('HH:mm'),
                inputType: InputType.time,
                initialValue: startDate,
                decoration: InputDecorations.buildInputDecoration_1(
                    hint_text: S.of(context).start_date_placeholder),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                textInputAction: TextInputAction.next,
                firstDate: DateTime.now(),
                onChanged: (DateTime? value) {
                  updatSlot(slot.id);
                  if (value != null) {}
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(S.of(context).end),
              ),
              FormBuilderDateTimePicker(
                name: 'end_date_${slot.id}',
                format: intl.DateFormat('HH:mm'),
                inputType: InputType.time,
                initialValue: endDate,
                // controller: _offerEndDateController,
                decoration: InputDecorations.buildInputDecoration_1(
                    hint_text: S.of(context).end_date_placeholder),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                textInputAction: TextInputAction.next,
                onChanged: (DateTime? value) {
                  updatSlot(slot.id);
                  if (value != null) {}
                },
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          color: isLoadingInBackground ? MyTheme.grey_153 : Colors.black,
          onPressed: !isLoadingInBackground
              ? () {
                  removeSlot(slot.id);
                }
              : null,
        )
      ],
    );
  }
}
