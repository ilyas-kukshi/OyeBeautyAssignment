import 'package:flutter/material.dart';
import 'package:oye_beauty_assignment/shared/app_theme_shared.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  InputBorder underlineBorder = const UnderlineInputBorder(
    borderSide: BorderSide(color: Color(0xffDDDDDD)),
  );
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
              color: Colors.white,
            ),
          )),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Your Location',
              hintStyle: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Color(0xff7D7D7D), fontSize: 13),
              suffixText: 'CHANGE',
              suffixStyle: Theme.of(context).textTheme.headline3!.copyWith(
                  color: const Color(0xff007EC5),
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
              border: underlineBorder,
              enabledBorder: underlineBorder,
              focusedBorder: underlineBorder,
            ),
          ),
          TextFormField(
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
                primary: const Color(0xffFCB001).withOpacity(0.8)),
            child: Text(
              'Add Address',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
