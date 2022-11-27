import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iclinic/custom_lib/custom_drop_down/custom_dropdown.dart';
import 'package:iclinic/dialogs/image_picker.dart';
import 'package:iclinic/interfaces/success_interface.dart';
import 'package:iclinic/response/response_add_clinic.dart';
import 'package:iclinic/screens/add_clinic_ui/add_clinic_controller.dart';
import 'package:iclinic/utils/colors.dart';
import 'package:iclinic/widgets/cached_network_image.dart';
import 'package:iclinic/widgets/custom_app_bar.dart';
import 'package:iclinic/widgets/custom_button.dart';
import 'package:iclinic/widgets/custom_text.dart';
import 'package:iclinic/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../utils/helpers.dart';

class AddClinicUi extends StatefulWidget {
  Clinic? clinic;
  String? title;
  Function(Clinic?)? onUpdate;

  AddClinicUi({Key? key, this.clinic, this.title, this.onUpdate})
      : super(key: key);

  @override
  State<AddClinicUi> createState() => _AddClinicUiState();
}

class _AddClinicUiState extends State<AddClinicUi> implements SuccessInterface {
  final Completer<GoogleMapController> _controller = Completer();
  static List<String> days = [
    "السبت",
    "الأحد",
    "الإثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة"
  ];
  late List<String> workDays = widget.clinic?.workdays ?? [];
  var formKey = GlobalKey<FormState>();
  late TextEditingController clinicNameController =
      TextEditingController(text: widget.clinic?.name);
  late TextEditingController doctorNameController =
      TextEditingController(text: widget.clinic?.doctorName);
  late TextEditingController mobileNumController =
      TextEditingController(text: widget.clinic?.mobileNumber);
  late TextEditingController phoneNumController =
      TextEditingController(text: widget.clinic?.telephoneNumber);
  late TextEditingController emailController =
      TextEditingController(text: widget.clinic?.email);
  late TextEditingController whatsappController =
      TextEditingController(text: widget.clinic?.whatsappNumber);
  late TextEditingController clinicAddress =
      TextEditingController(text: widget.clinic?.address);
  late TextEditingController clinicSpecialty =
      TextEditingController(text: widget.clinic?.clinicType?.name);
  late TextEditingController cityController =
      TextEditingController(text: widget.clinic?.city?.area?.name);
  late TextEditingController numOfChairs =
      TextEditingController(text: widget.clinic?.clinicChairs);
  late TextEditingController governorateController =
      TextEditingController(text: widget.clinic?.city?.name);
  late TextEditingController from =
      TextEditingController(text: widget.clinic?.timeStart);
  late TextEditingController to =
      TextEditingController(text: widget.clinic?.timeEnd);
  bool numOfChairsVisibility = false;
  late String clinicCard = widget.clinic?.businessCardUrl ?? "";
  late String clinicLogo = widget.clinic?.logoUrl ?? "";
  late AddClinicController controller;
  late int clinicTypeId = widget.clinic?.clinicType?.id ?? 0;
  late int cityId = widget.clinic?.city?.id ?? 0;
  late int countryId = widget.clinic?.city?.area?.id ?? 0;
  late double longitude = widget.clinic?.longitude ?? 0.0;
  late double latitude = widget.clinic?.latitude ?? 0.0;
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(31.243600, 34.232400),
    zoom: 14.4746,
  );

  // on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: const MarkerId('1'),
        position: const LatLng(20.42796133580664, 75.885749655962),
        draggable: true,
        infoWindow: const InfoWindow(
          title: 'My Position',
        ),
        onDragEnd: ((newPosition) {
          print(newPosition.latitude);
          print(newPosition.longitude);
        })),
  ];
  late GoogleMapController googleMapController;
  @override
  void dispose() {
    // TODO: implement dispose
    googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AddClinicController(this);
    controller.getClinicType();
    controller.getCountries();

    if (widget.clinic == null) {
      getUserCurrentLocation().then((value) async {
        _markers.add(Marker(
            markerId: MarkerId("$latitude"),
            position: LatLng(value.latitude, value.longitude),
            draggable: true,
            infoWindow: const InfoWindow(
              title: 'My Current Location',
            ),
            onDragEnd: ((newPosition) {
              setState(() {
                latitude = newPosition.latitude;
                longitude = newPosition.longitude;
              });
            })));
        CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 14,
        );
        final GoogleMapController controller = await _controller.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        setState(() {});
      });
    } else {
      getUserCurrentLocation().then((value) async {
        _markers.add(Marker(
            markerId: MarkerId("$latitude"),
            position: LatLng(latitude, longitude),
            draggable: true,
            infoWindow: const InfoWindow(
              title: 'My Current Location',
            ),
            onDragEnd: ((newPosition) {
              setState(() {
                latitude = newPosition.latitude;
                longitude = newPosition.longitude;
              });
            })));
        CameraPosition cameraPosition = CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 14,
        );
        final GoogleMapController controller = await _controller.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(63.h),
        child: CustomAppBar(title: widget.title ?? 'اضافة عيادة جديدة'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsetsDirectional.only(
              top: 37.h, start: 38.w, end: 38.w, bottom: 32.h),
          children: [
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: MyColors.whiteColor),
              width: 103.w,
              height: 103.h,
              child: IconButton(
                  onPressed: () {
                    showImagePicker(
                        context: context,
                        onResult: (xfile) {
                          setState(() {
                            clinicLogo = xfile?.path ?? "";
                          });
                        });
                  },
                  icon: widget.clinic != null
                      ? CustomNetworkImage(
                          image: clinicLogo,
                          height: 103.h,
                          width: 103.w,
                          fit: BoxFit.cover)
                      : CircleAvatar(
                          backgroundColor: Colors.transparent,
                          //borderRadius: BorderRadius.circular(50.r),
                          radius: 40.r,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: CustomNetworkImage(
                                  image: clinicLogo,
                                  height: 103.h,
                                  width: 103.w,
                                  fit: BoxFit.cover)))),
            ),
            SizedBox(
              height: 28.h,
            ),
            CustomText('اسم العيادة',
                color: MyColors.textColor,
                size: 12,
                padding: EdgeInsetsDirectional.only(start: 17.w)),
            SizedBox(
              height: 5.h,
            ),
            CustomTextField(
              controller: clinicNameController,
              hintText: 'ادخل اسم العيادة',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 18.h,
            ),
            CustomText('اسم الطبيب',
                color: MyColors.textColor,
                size: 12,
                padding: EdgeInsetsDirectional.only(start: 17.w)),
            SizedBox(
              height: 5.h,
            ),
            CustomTextField(
                controller: doctorNameController,
                hintText: 'ادخل اسم الطبيب',
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text),
            SizedBox(
              height: 18.h,
            ),
            CustomText('رقم الجوال',
                color: MyColors.textColor,
                size: 12,
                padding: EdgeInsetsDirectional.only(start: 17.w)),
            SizedBox(
              height: 5.h,
            ),
            CustomTextField(
                controller: mobileNumController,
                hintText: 'ادخل رقم الجوال',
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.phone),
            SizedBox(
              height: 18.h,
            ),
            CustomText('رقم الهاتف',
                color: MyColors.textColor,
                size: 12,
                padding: EdgeInsetsDirectional.only(start: 17.w)),
            SizedBox(
              height: 5.h,
            ),
            CustomTextField(
                controller: phoneNumController,
                hintText: 'رقم الهاتف',
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.phone),
            SizedBox(
              height: 18.h,
            ),
            CustomText('رقم واتس اب',
                color: MyColors.textColor,
                size: 12,
                padding: EdgeInsetsDirectional.only(start: 17.w)),
            SizedBox(
              height: 5.h,
            ),
            CustomTextField(
                controller: whatsappController,
                hintText: 'رقم واتس اب للعيادة',
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.phone),
            SizedBox(
              height: 18.h,
            ),
            CustomText('البريد الإلكتروني',
                color: MyColors.textColor,
                size: 12,
                padding: EdgeInsetsDirectional.only(start: 17.w)),
            SizedBox(
              height: 5.h,
            ),
            CustomTextField(
                controller: emailController,
                hintText: 'البريد الإلكتروني',
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.emailAddress),
            SizedBox(
              height: 18.h,
            ),
            CustomText('صورة كرت العيادة',
                color: MyColors.textColor,
                size: 12,
                padding: EdgeInsetsDirectional.only(start: 17.w)),
            SizedBox(
              height: 5.h,
            ),
            Material(
              elevation: 5,
              shadowColor: MyColors.grey6Color,
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                height: 185.h,
                width: 352.w,
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          showImagePicker(
                              context: context,
                              onResult: (xfile) {
                                setState(() {
                                  clinicCard = xfile?.path ?? "";
                                });
                              });
                        },
                        child: CustomNetworkImage(
                            image: clinicCard,
                            height: 100,
                            width: 200,
                            fit: BoxFit.cover)),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomText('حمل صورة كرت العيادة هنا',
                        color: MyColors.hintColor, size: 12)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            CustomText('أيام الدوام',
                color: MyColors.textColor,
                size: 12,
                padding: EdgeInsetsDirectional.only(start: 17.w)),
            SizedBox(
              height: 5.h,
            ),
            Material(
              elevation: 5,
              shadowColor: MyColors.grey6Color,
              borderRadius: BorderRadius.circular(10.r),
              child: MultiSelectDialogField(
                  items: days.map((e) => MultiSelectItem(e, e)).toList(),
                  initialValue: workDays,
                  title: const Text("أيام الدوام"),
                  backgroundColor: MyColors.whiteColor,
                  buttonIcon: Icon(
                    Icons.add,
                    size: 18.sp,
                    color: MyColors.hintColor,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: MyColors.whiteColor),
                  dialogHeight: 400.h,
                  buttonText: Text(
                    'أيام الدوام',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: MyColors.hintColor,
                        fontFamily: 'regular'),
                  ),
                  validator: (values) {
                    if (values == null || values.isEmpty) {
                      return "مطلوب";
                    }
                  },
                  // initialValue: days,
                  onConfirm: (arr) {
                    for (int i = 0; i < arr.length; i++) {
                      String hh = arr[i] as String;
                      workDays.add(hh);
                      //print('workdays $workDays');
                      // setState((){
                      //   workDays?.add(days[i]);
                      // });
                    }
                    print("objectzzz>> ${workDays.length}");
                  }),
            ),
            SizedBox(
              height: 18.h,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText('من:',
                        color: MyColors.textColor,
                        size: 12,
                        padding: EdgeInsetsDirectional.only(start: 17.w)),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      controller: from,
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          from.text =
                              Helpers.formatTimeOfDay(value!, DateFormat.Hm());
                        });
                      },
                    ),
                  ],
                )),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText('إلى:',
                        color: MyColors.textColor,
                        size: 12,
                        padding: EdgeInsetsDirectional.only(start: 17.w)),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      controller: to,
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          to.text =
                              Helpers.formatTimeOfDay(value!, DateFormat.Hm());
                        });
                      },
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 18.h,
            ),
            CustomText('تخصص العيادة',
                color: MyColors.textColor,
                size: 12,
                padding: EdgeInsetsDirectional.only(start: 17.w)),
            SizedBox(
              height: 5.h,
            ),
            Material(
              elevation: 5,
              shadowColor: MyColors.grey6Color,
              borderRadius: BorderRadius.circular(10.r),
              child: CustomDropdown(
                  items: controller.clinicTypes,
                  controller: clinicSpecialty,
                  inColor: MyColors.whiteColor,
                  outLineBorder: true,
                  hintText: 'تخصص العيادة',
                  borderRadius: BorderRadius.circular(10.r),
                  onChanged: (val) {
                    if (val == 'اسنان') {
                      setState(() {
                        numOfChairsVisibility = true;
                      });
                    } else {
                      setState(() {
                        numOfChairsVisibility = false;
                      });
                    }
                  },
                  myVoidCallback: (result) {
                    clinicTypeId = result.id;
                  }),
            ),
            Visibility(
                visible: numOfChairsVisibility,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18.h,
                    ),
                    CustomText('عدد الكراسي',
                        color: MyColors.textColor,
                        size: 12,
                        padding: EdgeInsetsDirectional.only(start: 17.w)),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                        controller: numOfChairs,
                        hintText: 'عدد الكراسي',
                        textInputType: TextInputType.number),
                  ],
                )),
            SizedBox(
              height: 18.h,
            ),
            CustomText('الضفة/غزة',
                color: MyColors.textColor,
                size: 12,
                padding: EdgeInsetsDirectional.only(start: 17.w)),
            SizedBox(
              height: 5.h,
            ),
            Material(
              elevation: 5,
              shadowColor: MyColors.grey6Color,
              borderRadius: BorderRadius.circular(10.r),
              child: CustomDropdown(
                items: controller.countries,
                controller: cityController,
                myVoidCallback: (result) {
                  setState(() {
                    countryId = result.id;
                    if (countryId != null) {
                      controller.getCites(countryId);
                    }
                  });
                },
                inColor: MyColors.whiteColor,
                outLineBorder: true,
                hintText: 'الضفة/غزة',
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            CustomText('المحافظة',
                color: MyColors.textColor,
                size: 12,
                padding: EdgeInsetsDirectional.only(start: 17.w)),
            SizedBox(
              height: 5.h,
            ),
            Material(
              elevation: 5,
              shadowColor: MyColors.grey6Color,
              borderRadius: BorderRadius.circular(10.r),
              child: CustomDropdown(
                items: controller.cites,
                controller: governorateController,
                myVoidCallback: (result) {
                  cityId = result.id;
                },
                inColor: MyColors.whiteColor,
                outLineBorder: true,
                hintText: 'المحافظة',
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            CustomText('عنوان العيادة',
                color: MyColors.textColor,
                size: 12,
                padding: EdgeInsetsDirectional.only(start: 17.w)),
            SizedBox(
              height: 5.h,
            ),
            CustomTextField(
                controller: clinicAddress,
                hintText: 'اكتب عنوان العيادة',
                textInputType: TextInputType.text),
            SizedBox(
              height: 18.h,
            ),
            CustomText('موقع العيادة',
                color: MyColors.textColor,
                size: 12,
                padding: EdgeInsetsDirectional.only(start: 17.w)),
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: 217.h,
              width: 352.w,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
              child: GoogleMap(
                initialCameraPosition: _kGoogle,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                markers: Set<Marker>.of(_markers),
                trafficEnabled: true,
                gestureRecognizers: Set()
                  ..add(Factory<EagerGestureRecognizer>(
                      () => EagerGestureRecognizer())),
                onMapCreated: (GoogleMapController controller) {
                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                  }
                },
              ),
            ),
            SizedBox(
              height: 46.h,
            ),
            CustomButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (widget.clinic?.id != null) {
                    controller.updateClinic({
                      "name": clinicNameController.text,
                      "doctor_name": doctorNameController.text,
                      "mobile_number": mobileNumController.text,
                      "telephone_number": phoneNumController.text,
                      "email": emailController.text,
                      "whatsapp_number": whatsappController.text,
                      "address": clinicAddress.text,
                      "clinic_type_id": clinicTypeId,
                      "clinic_chairs": numOfChairs.text,
                      "time_start": from.text,
                      "time_end": to.text,
                      "workdays[]": workDays,
                      "city_id": cityId,
                      "longitude": longitude,
                      "latitude": latitude
                    }, widget.clinic?.id ?? 0,
                        cardImage: !(clinicCard.startsWith("http://") ||
                                clinicCard.startsWith("https://"))
                            ? File(clinicCard)
                            : null,
                        logoImage: !(clinicLogo.startsWith("http://") ||
                                clinicLogo.startsWith("https://"))
                            ? File(clinicLogo)
                            : null);
                  } else {
                    controller.addClinic({
                      "name": clinicNameController.text,
                      "doctor_name": doctorNameController.text,
                      "mobile_number": mobileNumController.text,
                      "telephone_number": phoneNumController.text,
                      "email": emailController.text,
                      "whatsapp_number": whatsappController.text,
                      "address": clinicAddress.text,
                      "clinic_type_id": clinicTypeId,
                      "clinic_chairs": numOfChairs.text,
                      "time_start": from.text,
                      "time_end": to.text,
                      "workdays[]": workDays,
                      "city_id": cityId,
                      "longitude": longitude,
                      "latitude": latitude
                    },
                        cardImage: File(clinicCard),
                        logoImage: File(clinicLogo));
                  }
                  print("sssss$clinicLogo");
                }
              },
              text: widget.clinic != null ? 'تعديل ' : 'اضافة عيادة',
              color: MyColors.greenColor,
              radius: 10,
            )
          ],
        ),
      ),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void onSuccess(dynamic) {
    // TODO: implement onSuccess
    if (widget.clinic != null) {
      ResponseClinic2 responseClinic2 = dynamic as ResponseClinic2;
      if (widget.onUpdate != null) widget.onUpdate!(responseClinic2.clinic);
    } else {
      Clinic clinic = dynamic as Clinic;
      if (widget.onUpdate != null) widget.onUpdate!(clinic);
    }
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0.r))),
              content: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                padding: EdgeInsetsDirectional.only(start: 39.w, end: 39.w),
                height: 292.h,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Image.asset(
                      'assets/images/clinic_added_successfully.png',
                      height: 100.h,
                      width: 100.w,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    CustomText(
                        widget.clinic != null
                            ? 'تم التعديل بنجاح'
                            : 'تم اضافة العيادة بنجاح',
                        size: 20.sp,
                        fontFamily: 'bold',
                        color: MyColors.mainColor,
                        fontWeight: FontWeight.w700),
                    SizedBox(
                      height: 45.h,
                    ),
                    CustomButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: MyColors.greenColor,
                      text: 'موافق',
                      height: 40.h,
                      radius: 10,
                      fontSize: 13,
                      fontFamily: 'regular',
                    ),
                  ],
                ),
              ));
        });
  }
}
