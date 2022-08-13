import 'package:flutter/material.dart';
import '../custom/CustomButton.dart';
import '../custom/CustomScaffold.dart';
import '../custom/CustomTextField.dart';

class AdduserDetails extends StatefulWidget {
  const AdduserDetails({Key? key}) : super(key: key);

  @override
  State<AdduserDetails> createState() => _AdduserDetailsState();
}

class _AdduserDetailsState extends State<AdduserDetails> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            CustomTextField(
              hintText: "eg. Harsh",
              hintTextSize: 16,
              initialValue: '',
              onChanged: () {},
              onSaved: () {},
              validator: () {},
              labelText: 'Enter Name',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: "1234-5678-1234-5678",
              hintTextSize: 16,
              initialValue: '',
              onChanged: () {},
              onSaved: () {},
              validator: () {},
              labelText: 'Enter Aadhar Number',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: "Email",
              hintTextSize: 16,
              initialValue: '',
              onChanged: () {},
              onSaved: () {},
              validator: () {},
              labelText: 'Enter Email-ID',
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: CustomButton(
                  postIcon: Icons.arrow_forward_ios,
                  visiblepostIcon: true,
                  labelText: "Submit ",
                  onTap: () {
                    //_routeToSplashPage()
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
