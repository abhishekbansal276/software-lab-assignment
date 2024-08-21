import 'package:flutter/material.dart';
import 'package:software_lab_assignment/screens/signup/done.dart';
import 'package:software_lab_assignment/models/signup_model.dart';
import 'package:software_lab_assignment/models/farm_info_model.dart';
import 'package:software_lab_assignment/models/verification_model.dart';
import 'package:software_lab_assignment/services/api_service.dart';

class Hours extends StatefulWidget {
  final SignUpModel signUpData;
  final FarmInfoModel farmInfo;
  final VerificationModel verificationData;

  const Hours({
    super.key,
    required this.signUpData,
    required this.farmInfo,
    required this.verificationData,
  });

  @override
  State<Hours> createState() => _HoursState();
}

class _HoursState extends State<Hours> {
  int _selectedDayIndex = 0;
  final Map<String, Set<String>> _businessHours = {
    "mon": {},
    "tue": {},
    "wed": {},
    "thu": {},
    "fri": {},
    "sat": {},
    "sun": {},
  };

  final List<String> _days = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];
  final List<String> _timeSlots = [
    "8:00am - 10:00am",
    "10:00am - 1:00pm",
    "1:00pm - 4:00pm",
    "4:00pm - 7:00pm",
    "7:00pm - 10:00pm"
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(width / 18),
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
                    'Signup 4 of 4',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  ),
                  SizedBox(height: height / 60),
                  const Text(
                    'Business Hours',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height / 40),
                  const Text(
                    'Choose the hours your farm is open for pickups. This will allow customers to order deliveries.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: height / 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_selectedDayIndex != -1) {
                              _saveSelectedHours();
                            }
                            _selectedDayIndex = index;
                          });
                        },
                        child: _buildDayButton(
                          day: _getDayName(index),
                          isSelected: index == _selectedDayIndex,
                          hasSelectedTimeSlots: _businessHours[_days[index]]!.isNotEmpty,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: height / 35),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: _timeSlots.map((slot) {
                      return _buildTimeSlot(slot, width);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(width / 18),
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
                      onPressed: () async {
                        if (_selectedDayIndex != -1) {
                          _saveSelectedHours();

                          final businessHours = _businessHours.map(
                            (key, value) => MapEntry(key, value.toList()),
                          );

                          final apiService = ApiService();

                          try {
                            await apiService.registerUserThroughMail(
                              fullName: widget.signUpData.fullName,
                              email: widget.signUpData.email,
                              phone: widget.signUpData.phone,
                              password: widget.signUpData.password,
                              businessName: widget.farmInfo.businessName,
                              informalName: widget.farmInfo.informalName,
                              address: widget.farmInfo.streetAddress,
                              city: widget.farmInfo.city,
                              state: widget.farmInfo.state,
                              zipCode: widget.farmInfo.zipCode,
                              registrationProofFileName: widget.verificationData.fileName ?? '',
                              businessHours: businessHours,
                              deviceToken: '0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx',
                              socialId: '0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx',
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpDone(),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please select at least one day.',
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
          ),
        ],
      ),
    );
  }

  Widget _buildDayButton({
    required String day,
    required bool isSelected,
    required bool hasSelectedTimeSlots,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.grey
            : hasSelectedTimeSlots
                ? const Color(0xFFD5715B)
                : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey[300]!,
        ),
      ),
      child: Text(
        day,
        style: TextStyle(
          fontSize: 16,
          color: isSelected || hasSelectedTimeSlots ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTimeSlot(String time, double width) {
    final selectedDay = _days[_selectedDayIndex];
    final timeSlotsForDay = _businessHours[selectedDay] ?? {};
    bool isSelected = timeSlotsForDay.contains(time);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            timeSlotsForDay.remove(time);
          } else {
            timeSlotsForDay.add(time);
          }
        });
      },
      child: Container(
        width: (width - (2 * (width / 18)) - 8.0) / 2,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8C569) : Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          time,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  String _getDayName(int index) {
    List<String> days = ["M", "T", "W", "Th", "F", "S", "Su"];
    return days[index];
  }

  void _saveSelectedHours() {
    final selectedDay = _days[_selectedDayIndex];
    _businessHours[selectedDay] = _businessHours[selectedDay] ?? {};
  }
}
