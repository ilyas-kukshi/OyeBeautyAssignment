import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({Key? key}) : super(key: key);

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  int selectedIndex = 0;
  bool addressSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffE4E4E4),
        centerTitle: true,
        title: Text(
          'Select date & time',
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/addAddress'),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xff0069CA))),
                      child: const Icon(
                        Icons.add,
                        color: Color(0xff0069CA),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('Add New Address',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 18, color: const Color(0xff0069CA)))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("Addresses")
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Text('Loading data');
                  } else {
                    if (snapshot.data.size > 0) {
                   
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.size,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  selectedIndex = index;
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: selectedIndex == index
                                          ? const Color(0xff00A3FF)
                                          : Colors.white,
                                      border: Border.all(
                                          color: const Color(0xffEAEAEA))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data.docs[index]['type'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            snapshot.data.docs[index]['name'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(
                                                    fontSize: 16,
                                                    color: const Color(
                                                        0xff585858)),
                                          ),
                                          Text(
                                            snapshot.data.docs[index]
                                                ['flat_building_street'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(
                                                    fontSize: 16,
                                                    color: const Color(
                                                        0xff585858)),
                                          ),
                                          Text(
                                            snapshot.data.docs[index]
                                                ['locationAddress'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(
                                                    fontSize: 16,
                                                    color: const Color(
                                                        0xff585858)),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Text(
                        'Please add an address first',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 18),
                      );
                    }
                  }
                },
              ),
               Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xff00A3FF),
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 50),
                          ),
                          onPressed: () =>
                              Navigator.pushNamed(context, '/checkout'),
                          child: Text(
                            'Next',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                          )),
                    )
                  
            ],
          ),
        ),
      ),
    );
  }
}
