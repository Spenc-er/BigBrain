import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../numbers_memory/controllers/store_controller.dart';

class Survey extends StatefulWidget {
  const Survey({Key? key}) : super(key: key);

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  int? selectedOption;
  double sleepQualityScore = 50;
  double averageSportHours = 0;
  double averageScreenHours = 0;
  late StoreController controller;
  late String email;
  late String gender;
  late String age;
  late String height;
  late String weight;
  late String education;
  late String country;
  late String game_difficulty;
  late String game_level;
  late String game_time;
  bool _isButtonDisabled = false;
  _initState() {
    controller = Get.find<StoreController>();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? '';
      gender = prefs.getString('gender') ?? '';
      age = prefs.getString('age') ?? '';
      height = prefs.getString('height') ?? '';
      weight = prefs.getString('weight') ?? '';
      education = prefs.getString('education') ?? '';
      country = prefs.getString('country') ?? '';
      game_difficulty = prefs.getString('difficulty') ?? '';
      game_level = prefs.getString('game_lvl') ?? '';
    });
  }

  setJson() {
    return {
      "email": email,
      "age": age,
      "bmi": (double.parse(weight) / pow(double.parse(height) / 100, 2))
          .toStringAsFixed(2),
      "education": education,
      "gender": gender,
      "gameData": {
        "game_level": game_level,
        "mood": selectedOption,
        "name": "Sequence Memory",
        "screen_hour": averageScreenHours,
        "sleep_quality": sleepQualityScore,
        "sport_hour": averageSportHours
      }
    };
  }

  void _handleButtonPress() {
    if (!_isButtonDisabled) {
      setState(() {
        _isButtonDisabled = true;
      });

      // Call your createSurvey() method and show the Snackbar
      controller.createSurvey(setJson()).then((_) {
        // Show success Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Survey has been successfully submitted.'),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'dismiss',
              onPressed: () {},
            ),
          ),
        );
      }).catchError((error) {
        setState(() {
          _isButtonDisabled = false;
        });
        // Show error Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Something went wrong, please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _initState();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Card(
            color: Color.fromARGB(255, 235, 170, 255),
            elevation: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SURVEY',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Spacer(),
                          _backButton(),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        'Your Current Mood',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildOptionRow(Icons.mood_bad, 1, Colors.red),
                        buildOptionRow(Icons.sentiment_very_dissatisfied, 2,
                            Colors.orange),
                        buildOptionRow(Icons.sentiment_neutral, 3,
                            Color.fromARGB(255, 255, 238, 4)),
                        buildOptionRow(Icons.sentiment_satisfied_alt_sharp, 4,
                            Color.fromARGB(255, 139, 246, 148)),
                        buildOptionRow(Icons.sentiment_very_satisfied, 5,
                            const Color.fromARGB(255, 4, 223, 11)),
                      ],
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Sleep Quality Score ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        Tooltip(
                          child: SvgPicture.asset(
                            'assets/images/information-circle-outline.svg',
                            width: 25,
                            height: 25,
                            // ignore: deprecated_member_use
                            color: Colors.white,
                          ),
                          message:
                              'Sleep score 100 means your sleep is excellent: you have slept enough and most of it has been restorative. 80–99 stand for good sleep, 50–79 for moderate and 0–49 for poor sleep. Sleep score is a combination of two variables, amount and quality of sleep.',
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Sleep Quality Score: ${sleepQualityScore.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        valueIndicatorColor: Colors.purple,
                        thumbColor: Colors.purple,
                        activeTrackColor: Colors.purple,
                        trackHeight: 20,
                        showValueIndicator: ShowValueIndicator.always,
                      ),
                      child: Slider(
                        value: sleepQualityScore,
                        min: 0.0,
                        max: 100.0,
                        onChanged: (newValue) {
                          setState(() {
                            sleepQualityScore = newValue.round().toDouble();
                          });
                        },
                        label: sleepQualityScore.round().toString(),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              'Average Sport Hour(s) Per Day',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Hour(s) per day: ${averageSportHours.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        valueIndicatorColor: Colors.purple,
                        thumbColor: Colors.purple,
                        activeTrackColor: Colors.purple,
                        trackHeight: 20,
                        showValueIndicator: ShowValueIndicator.always,
                      ),
                      child: Slider(
                        value: averageSportHours,
                        min: 0.0,
                        max: 16.0,
                        onChanged: (newValue) {
                          setState(() {
                            averageSportHours = newValue.round().toDouble();
                          });
                        },
                        label: averageSportHours.round().toString(),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Average Screen Hour(s) Per Day',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Hour(s) per day: ${averageScreenHours.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        valueIndicatorColor: Colors.purple,
                        thumbColor: Colors.purple,
                        activeTrackColor: Colors.purple,
                        trackHeight: 20,
                        showValueIndicator: ShowValueIndicator.always,
                      ),
                      child: Slider(
                        value: averageScreenHours,
                        min: 0.0,
                        max: 16.0,
                        onChanged: (newValue) {
                          setState(() {
                            averageScreenHours = newValue.round().toDouble();
                          });
                        },
                        label: averageScreenHours.round().toString(),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      _isButtonDisabled ? Colors.grey : Colors.purple,
                    ),
                  ),
                  onPressed: _isButtonDisabled ? null : _handleButtonPress,
                  child: const Text('Submit',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOptionRow(IconData iconData, int optionValue, Color color) {
    final isSelected = selectedOption == optionValue;

    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 3),
          color: isSelected
              ? const Color.fromARGB(255, 178, 100, 192)
              : Colors.white,
          child: IconButton(
            iconSize: 48,
            onPressed: () {
              setState(() {
                selectedOption = isSelected ? null : optionValue;
              });
            },
            icon: Icon(isSelected ? iconData : iconData, color: color),
          ),
        ),
      ],
    );
  }

  Widget _backButton() => Container(
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: Color.fromARGB(255, 235, 170, 255),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          style: ButtonStyle(),
          onPressed: () => {GoRouter.of(context).go('/')},
          icon: Icon(Icons.close, color: Colors.white, size: 20),
        ),
      );
}
