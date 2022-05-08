
import 'package:flutter/material.dart';

class CleaningService extends StatefulWidget {
  const CleaningService({Key? key}) : super(key: key);

  @override
  State<CleaningService> createState() => _CleaningServiceState();
}

class CleaningServiceModel {
  String imageUri;
  String serviceName;
  int discount;

  CleaningServiceModel(this.imageUri, this.serviceName, this.discount);
}

class _CleaningServiceState extends State<CleaningService> {
  List<CleaningServiceModel> cleaningServiceData = [
    CleaningServiceModel(
        'assets/images/Rectangle 1588.png', 'Home Deep Cleaning', 40),
    CleaningServiceModel(
        'assets/images/Rectangle 1588.png', 'Sofa Cleaning', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        itemCount: cleaningServiceData.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        cleaningServiceData[index].imageUri,
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              Text(
                cleaningServiceData[index].serviceName,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "UPTO ${cleaningServiceData[index].discount.toString()}% OFF",
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: 12,
                      color: Colors.black,
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}
