import 'package:flutter/material.dart';

class PremiumHomeService extends StatefulWidget {
  PremiumHomeServiceModel homeServiceDataCard;
  PremiumHomeService({Key? key, required this.homeServiceDataCard})
      : super(key: key);

  @override
  State<PremiumHomeService> createState() => _PremiumHomeServiceState();
}

class PremiumHomeServiceModel {
  String imageUri;
  String serviceName;

  PremiumHomeServiceModel(this.imageUri, this.serviceName);
}

class _PremiumHomeServiceState extends State<PremiumHomeService> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                height: 100.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      widget.homeServiceDataCard.serviceName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.asset(
                widget.homeServiceDataCard.imageUri,
                width: MediaQuery.of(context).size.width * 0.4,
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
  }
}
