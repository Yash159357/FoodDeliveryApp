import 'package:flutter/material.dart';
import 'package:food_app_project/consts/consts.dart';
import 'package:get/get.dart';
import 'package:food_app_project/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Center(
              child: CircleAvatar(
                radius: 150,
                backgroundImage: AssetImage(imgProfile),
              ),
            ),
            const SizedBox(height: 6),
            Divider(
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 6),
            Column(
              children: [
                InfoReader(
                    field: "Name", value: profileController.username.value),
                Divider(),
                InfoReader(
                    field: "E-mail", value: profileController.email.value),
                Divider(),
                InfoReader(
                    field: "Password", value: profileController.pswd.value),
              ],
            ),
            Divider(
              color: Colors.grey.shade600,
            ),
            SizedBox(height: 16),
            // Save Button
            Center(
              child: SizedBox(
                width: screenWidth * 0.275,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    // Add save functionality here
                    print("Profile updated");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(appbarCol1),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        "Edit",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.edit_rounded,
                        size: 24,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoReader extends StatelessWidget {
  const InfoReader({super.key, required this.field, required this.value});
  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(
          height: screenHeight * 0.05,
          width: screenWidth * 0.5,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              field,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.05,
          width: screenWidth * 0.4,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
