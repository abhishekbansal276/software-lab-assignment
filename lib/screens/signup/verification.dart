import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:software_lab_assignment/models/verification_model.dart';
import 'package:software_lab_assignment/models/signup_model.dart';
import 'package:software_lab_assignment/models/farm_info_model.dart';
import 'package:software_lab_assignment/screens/signup/hours.dart';

class Verification extends StatefulWidget {
  final SignUpModel signUpData;
  final FarmInfoModel farmInfo;

  const Verification(
      {super.key, required this.signUpData, required this.farmInfo});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  File? _selectedFile;
  VerificationModel verificationModel = VerificationModel();

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        verificationModel.fileName = result.files.single.name;
      });
    }
  }

  void _showFilePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Browse'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFile();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(width / 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            const Text(
              'FarmerEats',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: height / 25),
            Text(
              'Signup 3 of 4',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
            SizedBox(height: height / 25),
            const Text(
              'Verification',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: height / 40),
            const Text(
              'Attach proof of Department of Agriculture registrations i.e. Florida Fresh, USDA Approved, USDA Organic',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: height / 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Attach proof registration',
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFD5715B),
                      borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                      onPressed: _showFilePickerOptions,
                      color: Colors.white,
                      icon: const Icon(Icons.camera_alt_outlined)),
                )
              ],
            ),
            if (_selectedFile != null) ...[
              SizedBox(height: height / 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _selectedFile!.path.split('/').last,
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear, color: Colors.black54),
                      onPressed: () {
                        setState(() {
                          _selectedFile = null;
                          verificationModel.fileName = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back)),
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: width / 30, horizontal: width / 5),
                      backgroundColor: const Color(0xFFD5715B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      if (_selectedFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please select a file.')),
                        );
                        return;
                      }

                      // Handle the `verificationModel`, `signUpData`, and `farmInfo` here
                      print('SignUp Data: ${widget.signUpData.toJson()}');
                      print('Farm Info: ${widget.farmInfo.toJson()}');
                      print('Verification Data: ${verificationModel.toJson()}');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Hours(
                            signUpData: widget.signUpData,
                            farmInfo: widget.farmInfo,
                            verificationData: verificationModel,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}