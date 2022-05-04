import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oye_beauty_assignment/dashboard/CarouselSlider.dart';
import 'package:oye_beauty_assignment/dashboard/premium_home_service.dart';
import 'package:oye_beauty_assignment/dashboard/same_day_service.dart';
import 'package:oye_beauty_assignment/shared/app_theme_shared.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({Key? key}) : super(key: key);

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  late Position currentPosition;
  String locationAddress = "Your Location";

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
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 15,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.add_location,
                  color: Color(0xff025B5D),
                ),
                Text(
                  locationAddress,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Color(0xff415859),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
                Icon(
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
                Carousel(imageData: imageData),
                const SizedBox(height: 20),
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
                .map((homeServiceDataCard) => PremiumHomeService(
                    homeServiceDataCard: homeServiceDataCard))
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
                .map((sameDayServiceDataCard) => SameDaySrevice(
                    sameDayServiceDataCard: sameDayServiceDataCard))
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
              ],
            ),
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
