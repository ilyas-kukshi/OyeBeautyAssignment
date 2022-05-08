import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:oye_beauty_assignment/screens/dashboard/carousel.dart';
import 'package:oye_beauty_assignment/screens/dashboard/cleaning_service.dart';
import 'package:oye_beauty_assignment/screens/dashboard/electrician_services.dart';
import 'package:oye_beauty_assignment/screens/dashboard/premium_home_service.dart';
import 'package:oye_beauty_assignment/screens/dashboard/primary_services.dart';
import 'package:oye_beauty_assignment/screens/dashboard/same_day_service.dart';
import 'package:oye_beauty_assignment/shared/app_theme_shared.dart';
import 'package:oye_beauty_assignment/shared/dialogs.dart';
import 'package:oye_beauty_assignment/shared/utility.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({Key? key}) : super(key: key);

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  late Position currentPosition;
  String locationAddress = "Your Location";
  String verificationIdLocal = '';
  bool otpSent = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> phnNumberForm = GlobalKey<FormState>();
  GlobalKey<FormState> otpForm = GlobalKey<FormState>();

  List<PrimaryServicesModel> primaryServicesData = [
    PrimaryServicesModel(Icons.cut, 'Salon at Home'),
    PrimaryServicesModel(Icons.electrical_services, 'Electrician'),
    PrimaryServicesModel(Icons.plumbing, 'Plumber'),
    PrimaryServicesModel(Icons.videocam, 'CCTV'),
    PrimaryServicesModel(Icons.handyman, 'AC Service'),
    PrimaryServicesModel(Icons.local_shipping, 'Packers and Movers'),
    PrimaryServicesModel(Icons.cleaning_services, 'Cleaning '),
    PrimaryServicesModel(Icons.palette, 'Painting'),
    PrimaryServicesModel(Icons.blender, 'Home Appliances'),
    PrimaryServicesModel(Icons.sanitizer, 'Disinfection'),
    PrimaryServicesModel(Icons.pest_control, 'Pest Control'),
    PrimaryServicesModel(Icons.hardware, 'Carpenter'),
  ];

  List<String> imageData = [
    'assets/images/oyebeauty1.png',
    'assets/images/oyebeauty1.png'
  ];
  List<PremiumHomeServiceModel> homeServiceData = [
    PremiumHomeServiceModel(
        'assets/images/homeservice1.png', 'Air-Conditioner Services'),
    PremiumHomeServiceModel(
        'assets/images/homeservice2.png', 'AC Installation'),
    PremiumHomeServiceModel(
        'assets/images/homeservice3.png', 'Sofa Cleaning Service'),
    PremiumHomeServiceModel(
        'assets/images/homeservice4.png', 'Home  Deep Cleaning Service')
  ];

  List<SameDayServiceModel> sameDayServiceData = [
    SameDayServiceModel('assets/images/samedayservice/samedayservice1.png',
        'Carpentary\nService'),
    SameDayServiceModel('assets/images/samedayservice/samedayservice2.png',
        'Plumbing\nService'),
    SameDayServiceModel('assets/images/samedayservice/samedayservice3.png',
        'Electrical\nService'),
    SameDayServiceModel('assets/images/samedayservice/samedayservice4.png',
        'Painting\nService'),
    SameDayServiceModel('assets/images/samedayservice/samedayservice5.png',
        'Pest Control\nService'),
    SameDayServiceModel('assets/images/samedayservice/samedayservice5.png',
        'Pest Control\nService'),
  ];

  OutlineInputBorder pinkBorderTFF = const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffD2137B), width: 2));
  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser == null) {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        authBottomSheet();
      });
    }

    // FirebaseAuth.instance.signOut();

    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 15,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.add_location,
                  color: Color(0xff025B5D),
                ),
                Text(
                  locationAddress,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: const Color(0xff415859),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xff415859),
                )
              ],
            ),
            expandedHeight: 120,
            centerTitle: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AppThemeShared.textFormField(
                    context: context,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        color: Color(0xff757575),
                        size: 25,
                      ),
                    ),
                    hintText: "Search for a service",
                    borderRadius: 12,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Carousel(
                  imageData: imageData,
                  viewportFraction: 0.8,
                  showDotIndicator: false,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SliverGrid.extent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.25,
            children: primaryServicesData
                .map((primaryServicesDataCard) => GestureDetector(
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser == null) {
                          authBottomSheet();
                        } else {
                          Navigator.pushNamed(context, '/selectDataTime');
                        }
                      },
                      child: Center(
                        child:
                            primaryServices(context, primaryServicesDataCard),
                      ),
                    ))
                .toList(),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/safety.png',
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                Text(
                  'Trending Services',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 16,
                      color: const Color(0xff025B5D),
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Premium Home Services',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 16,
                      ),
                ),
              ],
            ),
          ),
          SliverGrid.extent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
            children: homeServiceData
                .map((homeServiceDataCard) => GestureDetector(
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser == null) {
                          authBottomSheet();
                        } else {
                          Navigator.pushNamed(context, '/selectDataTime');
                        }
                      },
                      child: PremiumHomeService(
                          homeServiceDataCard: homeServiceDataCard),
                    ))
                .toList(),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Same Day Services',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 16,
                      color: const Color(0xff025B5D),
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Premium Home Services',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 16,
                      ),
                ),
              ],
            ),
          ),
          SliverGrid.extent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.35,
            childAspectRatio: 0.6,
            children: sameDayServiceData
                .map((sameDayServiceDataCard) => GestureDetector(
                      onTap: () {
                        if (FirebaseAuth.instance.currentUser == null) {
                          authBottomSheet();
                        } else {
                          Navigator.pushNamed(context, '/selectDataTime');
                        }
                      },
                      child: SameDaySrevice(
                          sameDayServiceDataCard: sameDayServiceDataCard),
                    ))
                .toList(),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Image.asset('assets/images/100% safe.png',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Text(
                  'Professional Cleaning Services',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 16,
                      color: const Color(0xff025B5D),
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Premium Services',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 16,
                      ),
                ),
                const CleaningService(),
                Text(
                  'Electrician Services',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 16,
                      color: const Color(0xff025B5D),
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Premium Services',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 16,
                      ),
                ),
                const ElectricianServices(),
                const SizedBox(height: 12),
                Text(
                  'Assured Peace of Mind',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff3A3A3A)),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/qualitywork.png'),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'High Quality Work',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          'Only authorized service experts and\ngenuine spare parts and equipments',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/qualitywork.png'),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hassle Free',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          'Sit back and relax.\nWe do all the work',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/cashless.png'),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Totally Cashless',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          'Pay online for Safe & Secure payment.\nMany benefits and offers available with\nonline payment',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void authBottomSheet() {
    List<String> authCarouselImages = [
      'assets/images/auth.png',
      'assets/images/auth.png',
      'assets/images/auth.png'
    ];
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController otpController = TextEditingController();

    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Carousel(
                      imageData: authCarouselImages,
                      viewportFraction: 1.0,
                      showDotIndicator: true,
                    ),
                  ),
                  changeSection(setState, phoneNumberController, otpController)
                ],
              );
            },
          );
        });
  }

  Widget changeSection(
      StateSetter setState,
      TextEditingController phoneNumberController,
      TextEditingController otpController) {
    return AnimatedCrossFade(
        firstChild: phnNumberInput(setState, phoneNumberController),
        secondChild: otpVerification(otpController, phoneNumberController),
        crossFadeState:
            otpSent ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200));
  }

  Widget phnNumberInput(
      StateSetter setter, TextEditingController phoneNumberController) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: phnNumberForm,
        child: Column(
          children: [
            Text(
              'Enter Mobile Number',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextFormField(
                controller: phoneNumberController,
                validator: Utility.phoneNumberValidator,
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 16,
                    ),
                decoration: InputDecoration(
                  hintText: 'Enter 10 digit mobile number',
                  hintStyle: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 16,
                        color: const Color(0xff929292),
                      ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12, top: 12.0),
                    child: Text(
                      '+91',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                  ),
                  border: pinkBorderTFF,
                  enabledBorder: pinkBorderTFF,
                  focusedBorder: pinkBorderTFF,
                  disabledBorder: pinkBorderTFF,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xffd2137b),
                      fixedSize: Size(MediaQuery.of(context).size.width, 50)),
                  onPressed: () {
                    var valid = phnNumberForm.currentState!.validate();
                    if (valid) {
                      sendOtp(setter, phoneNumberController);

                      setter(() {});
                    }
                  },
                  child: Text(
                    'Get Otp',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  )),
            ),
            const SizedBox(height: 12),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        'By creating an account or logging in you agree to YorLook',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  TextSpan(
                    text: ' Terms of Use',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 12, color: const Color(0xffD2137B)),
                  ),
                  TextSpan(
                    text: 'and',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                  TextSpan(
                    text: ' Privacy Policy',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 12, color: const Color(0xffD2137B)),
                  ),
                  TextSpan(
                    text:
                        ' and consent to the collection and use of your personal information/sensitive personal data or information.',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget otpVerification(TextEditingController otpController,
      TextEditingController phoneNumberController) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: otpForm,
        child: Column(
          children: [
            Text(
              'Enter OTP',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                controller: otpController,
                validator: Utility.otpValidator,
                animationType: AnimationType.scale,
                keyboardType: TextInputType.number,
                onChanged: (otp) {
                  // verifyOtp(otp);
                },
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldOuterPadding:
                        const EdgeInsets.symmetric(horizontal: 0),
                    borderWidth: 2,
                    fieldHeight: 45,
                    fieldWidth: 50,
                    borderRadius: BorderRadius.circular(12),
                    activeColor: const Color(0xffd2137b),
                    inactiveColor: const Color(0xffd2137b),
                    selectedColor: const Color(0xffd2137b)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xffd2137b),
                      fixedSize: Size(MediaQuery.of(context).size.width, 50)),
                  onPressed: () {
                    var valid = phnNumberForm.currentState!.validate();
                    if (valid) {
                      verifyOtp(otpController);
                    }
                  },
                  child: Text(
                    'Submit',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  )),
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'We have sent you a 6 digit verification code on',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 12,
                      color: const Color(0xff555555),
                    ),
              ),
              TextSpan(
                text: ' +91 ${phoneNumberController.text}',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
              )
            ])),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void sendOtp(
      StateSetter setter, TextEditingController phoneNumberController) async {
    await FirebaseAuth.instance
        .verifyPhoneNumber(
            phoneNumber: "+91" + phoneNumberController.text,
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
        .onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.toString());
    }).then((value) {
      otpSent = true;
      setter(() {});
    });
  }

  void codeAutoRetrievalTimeout(String verificationId) {}

  void codeSent(String verificationId, [int? smsCode]) async {
    verificationIdLocal = verificationId;

    setState(() {});
  }

  void verificationFailed(FirebaseAuthException exception) {
    Fluttertoast.showToast(msg: exception.message.toString());
    Navigator.pop(context);
  }

  void verificationCompleted(PhoneAuthCredential credential) async {}

  void verifyOtp(TextEditingController otpController) async {
    final valid = otpForm.currentState!.validate();
    if (valid) {
      DialogShared.loadingDialog(context, "Loading...");
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationIdLocal, smsCode: otpController.text);
      try {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .catchError((e) {
          Fluttertoast.showToast(msg: e.toString());
        }).whenComplete(() {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      } on FirebaseException catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  Widget primaryServices(
      BuildContext context, PrimaryServicesModel primaryServicesModel) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      decoration:
          BoxDecoration(border: Border.all(color: const Color(0xffF2F2F2))),
      child: Column(
        children: [
          Icon(
            primaryServicesModel.icon,
            color: const Color(0xff4267B2),
            size: 40,
          ),
          Text(
            primaryServicesModel.serviceName,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.headline1!.copyWith(fontSize: 14),
          )
        ],
      ),
    );
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
      locationAddress =
          '${place.street} ${place.subLocality} ${place.locality} ';
    });
    // print(Address);
  }
}
