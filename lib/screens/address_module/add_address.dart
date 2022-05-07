import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oye_beauty_assignment/shared/app_theme_shared.dart';
import 'package:oye_beauty_assignment/shared/utility.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController typeController = TextEditingController();
  TextEditingController youLocationController = TextEditingController();
  TextEditingController flatBuildingStreetController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  late Position currentPosition;
  String locationAddress = 'You current location';

  InputBorder underlineBorder = const UnderlineInputBorder(
    borderSide: BorderSide(color: Color(0xffDDDDDD)),
  );

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(
          title: 'Add Location',
          context: context,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          )),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 12),
                TextFormField(
                  controller: typeController,
                  validator: Utility.nameValidator,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 13, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Type eg.(Home)',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: const Color(0xff7D7D7D), fontSize: 13),
                    border: underlineBorder,
                    enabledBorder: underlineBorder,
                    focusedBorder: underlineBorder,
                  ),
                ),
                TextFormField(
                  controller: youLocationController,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 13, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Your Location',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: const Color(0xff7D7D7D), fontSize: 13),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: Text(
                        'CHANGE',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: const Color(0xff007EC5),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    border: underlineBorder,
                    enabledBorder: underlineBorder,
                    focusedBorder: underlineBorder,
                  ),
                ),
                TextFormField(
                  controller: flatBuildingStreetController,
                  validator: Utility.shopAddressValidator,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 13, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Flat/Building/Street',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: const Color(0xff7D7D7D), fontSize: 13),
                    border: underlineBorder,
                    enabledBorder: underlineBorder,
                    focusedBorder: underlineBorder,
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  validator: Utility.nameValidator,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 13, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: const Color(0xff7D7D7D), fontSize: 13),
                    border: underlineBorder,
                    enabledBorder: underlineBorder,
                    focusedBorder: underlineBorder,
                  ),
                ),
                TextFormField(
                  controller: phoneNumberController,
                  validator: Utility.phoneNumberValidator,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 13, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: const Color(0xff7D7D7D), fontSize: 13),
                    border: underlineBorder,
                    enabledBorder: underlineBorder,
                    focusedBorder: underlineBorder,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xffFCB001).withOpacity(0.8),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.9, 50)),
                  child: Text(
                    'Add Address',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () {
                    var valid = formKey.currentState!.validate();
                    if (valid) {
                      addAddress();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addAddress() async {
    GeoPoint geoPoint =
        GeoPoint(currentPosition.latitude, currentPosition.longitude);

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Addresses")
          .add({
        'type': typeController.text,
        'flat_building_street': flatBuildingStreetController.text,
        'location': geoPoint,
        'locationAddress': youLocationController.text,
        'name': nameController.text,
        'phoneNumber': phoneNumberController.text
      }).then((value) => Navigator.pop(context));
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  void getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "QGD needs to know your location");
      LocationPermission permissionAsked = await Geolocator.requestPermission();
      if (permissionAsked == LocationPermission.always ||
          permissionAsked == LocationPermission.whileInUse) {
        getCurrentLocation();
      }
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      getAddressFromLatLong(
          currentPosition.latitude, currentPosition.longitude);
    }
  }

  Future<void> getAddressFromLatLong(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    Placemark place = placemarks[0];
    setState(() {
      youLocationController.text =
          '${place.street} ${place.subLocality} ${place.locality} ';
    });
    // print(Address);
  }
}
