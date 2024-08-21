import 'package:flutter/material.dart';
import 'package:software_lab_assignment/models/signup_model.dart';
import 'package:software_lab_assignment/models/farm_info_model.dart';
import 'package:software_lab_assignment/screens/signup/verification.dart';

class FarmInfo extends StatefulWidget {
  final SignUpModel signUpData;

  const FarmInfo({super.key, required this.signUpData});

  @override
  State<FarmInfo> createState() => _FarmInfoState();
}

class _FarmInfoState extends State<FarmInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _informalNameController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  String? selectedState;

  final List<String> indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.all(width / 12),
            child: const Text(
              'FarmerEats',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: height / 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 12),
            child: Text(
              'Signup 2 of 4',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),
          ),
          SizedBox(height: height / 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 12),
            child: const Text(
              'Farm Info',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: height / 25),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: width / 12),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width / 30),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _businessNameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.label_outline,
                            color: Colors.black,
                            size: 20,
                          ),
                          hintText: "Business Name",
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter business name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: height / 40),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width / 30),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _informalNameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.face_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                          hintText: "Informal Name",
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter informal name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: height / 40),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width / 30),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _streetAddressController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.home_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                          hintText: "Street Address",
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter street address';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: height / 40),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width / 30),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _cityController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_city,
                            color: Colors.black,
                            size: 20,
                          ),
                          hintText: "City",
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter city';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: height / 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 30),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonFormField<String>(
                              value: selectedState,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                hintText: 'State',
                                hintStyle:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.black),
                              items: indianStates.map((String state) {
                                return DropdownMenuItem<String>(
                                  value: state,
                                  child: Text(state),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedState = newValue;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a state';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: width / 50),
                        Expanded(
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 30),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFormField(
                              controller: _zipcodeController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.pin_drop_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                hintText: 'Enter Zipcode',
                                hintStyle:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter zipcode';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height / 10),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width / 12, vertical: height / 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
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
                      if (_formKey.currentState?.validate() ?? false) {
                        final farmInfo = FarmInfoModel(
                          businessName: _businessNameController.text,
                          informalName: _informalNameController.text,
                          streetAddress: _streetAddressController.text,
                          city: _cityController.text,
                          state: selectedState ?? '',
                          zipCode: int.tryParse(_zipcodeController.text) ?? 0,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Verification(
                              signUpData: widget.signUpData,
                              farmInfo: farmInfo,
                            ),
                          ),
                        );
                      }
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
          ),
        ],
      ),
    );
  }
}
