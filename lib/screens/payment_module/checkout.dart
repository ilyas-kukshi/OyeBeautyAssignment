import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oye_beauty_assignment/shared/app_theme_shared.dart';

import '../../shared/utility.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int radioValue = 0;
  bool rememberPaytmNumber = false;

  TextEditingController phoneNumberController = TextEditingController();

  InputBorder underlineBorder = const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F6),
      appBar: AppThemeShared.appBar(
        title: "Checkout",
        context: context,
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
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'OyeBusy',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'Pay ₹269.10',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ExpansionTile(
                    initiallyExpanded: true,
                    trailing: const SizedBox(),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    onExpansionChanged: (value) {
                      if (value) {
                        setState(() {
                          radioValue = 0;
                        });
                      }
                    },
                    title: Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        'assets/images/paytm_logo.png',
                        height: 20,
                      ),
                    ),
                    subtitle: Text(
                      'Pay easily using your saved payment method',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 12,
                            color: const Color(0xff585858),
                          ),
                    ),
                    leading: Radio(
                        value: 0,
                        groupValue: radioValue,
                        onChanged: (value) {
                          setState(() {
                            radioValue = 0;
                          });
                        }),
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile number registered with Paytm',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    fontSize: 12,
                                    color: const Color(0xff585858),
                                  ),
                            ),
                            Center(
                              child: SizedBox(
                                child: TextFormField(
                                  controller: phoneNumberController,
                                  validator: Utility.phoneNumberValidator,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10)
                                  ],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: 'Phone Number',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            color: const Color(0xff7D7D7D),
                                            fontSize: 13),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Text(
                                        '+91',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    border: underlineBorder,
                                    enabledBorder: underlineBorder,
                                    focusedBorder: underlineBorder,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    fillColor: MaterialStateProperty.all(
                                        const Color(0xff00A3FF)),
                                    value: rememberPaytmNumber,
                                    onChanged: (value) {
                                      setState(() {
                                        rememberPaytmNumber = value!;
                                      });
                                    }),
                                Text(
                                  'Remember this number for future login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                        fontSize: 12,
                                        color: const Color(0xff585858),
                                      ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff00A3FF),
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width, 50),
                                  ),
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/paymentSuccessful'),
                                  child: Text(
                                    'Proceed',
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
                      )
                    ],
                  ),
                  ExpansionTile(
                    trailing: const SizedBox(),
                    onExpansionChanged: (value) {
                      if (value) {
                        setState(() {
                          radioValue = 1;
                        });
                      }
                    },
                    title: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Debit Card',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                    leading: Radio(
                        value: 1,
                        groupValue: radioValue,
                        onChanged: (value) {
                          setState(() {
                            radioValue = 1;
                          });
                        }),
                  ),
                  ExpansionTile(
                    trailing: const SizedBox(),
                    onExpansionChanged: (value) {
                      if (value) {
                        setState(() {
                          radioValue = 2;
                        });
                      }
                    },
                    title: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Credit Card',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                    leading: Radio(
                        value: 2,
                        groupValue: radioValue,
                        onChanged: (value) {
                          setState(() {
                            radioValue = 2;
                          });
                        }),
                  ),
                  ExpansionTile(
                    trailing: const SizedBox(),
                    onExpansionChanged: (value) {
                      if (value) {
                        setState(() {
                          radioValue = 3;
                        });
                      }
                    },
                    title: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'UPI',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                    leading: Radio(
                        value: 3,
                        groupValue: radioValue,
                        onChanged: (value) {
                          setState(() {
                            radioValue = 3;
                          });
                        }),
                  ),
                  ExpansionTile(
                    trailing: const SizedBox(),
                    iconColor: Colors.transparent,
                    onExpansionChanged: (value) {
                      if (value) {
                        setState(() {
                          radioValue = 4;
                        });
                      }
                    },
                    title: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Net Banking',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                    leading: Radio(
                        value: 4,
                        groupValue: radioValue,
                        onChanged: (value) {
                          setState(() {
                            radioValue = 4;
                          });
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
