import 'package:flutter/material.dart';

class ElectricianServices extends StatefulWidget {
  const ElectricianServices({Key? key}) : super(key: key);

  @override
  State<ElectricianServices> createState() => _ElectricianServicesState();
}

class ElectricianServicesModel {
  String imageUri;
  String serviceName;
  String description;

  ElectricianServicesModel(this.imageUri, this.serviceName, this.description);
}

class _ElectricianServicesState extends State<ElectricianServices> {
  List<ElectricianServicesModel> electricianServicesData = [
    ElectricianServicesModel('assets/images/electricianservices/mcb___fuse.png',
        'MCB & Fuse', 'Repairing & Installation'),
    ElectricianServicesModel(
        'assets/images/electricianservices/switches___sockets.png',
        'Switch & Socket',
        'Shower, Faucets & Holder Installation & Repair'),
    ElectricianServicesModel('assets/images/electricianservices/wiring.png',
        'Wiring', 'Toilet pot, Sink, Bathroom, Balcony pipe'),
    ElectricianServicesModel('assets/images/electricianservices/mcb___fuse.png',
        'MCB & Fuse', 'Repairing & Installation'),
    ElectricianServicesModel(
        'assets/images/electricianservices/switches___sockets.png',
        'Switch & Socket',
        'Shower, Faucets & Holder Installation & Repair'),
    ElectricianServicesModel('assets/images/electricianservices/wiring.png',
        'Wiring', 'Toilet pot, Sink, Bathroom, Balcony pipe'),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        itemCount: electricianServicesData.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      height: 150.0,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Column(
                            children: [
                              Text(
                                electricianServicesData[index].serviceName,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                electricianServicesData[index].description,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.asset(
                      electricianServicesData[index].imageUri,
                      width: MediaQuery.of(context).size.width * 0.3,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
                // Padding(
                //   padding: const EdgeInsets.only(top: 300),
                //   child: Align(
                //     alignment: Alignment.bottomCenter,
                //     child: SizedBox(
                //       height: 250,
                //       child: Card(
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(12)),
                //         elevation: 10,
                //       ),
                //     ),
                //   ),
                // ),
                // Image.asset(
                //   homeServiceData[index].imageUri,
                //   width: MediaQuery.of(context).size.width * 0.4,
                //   fit: BoxFit.fill,
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
