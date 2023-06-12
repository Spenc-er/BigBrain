import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController edu = TextEditingController();
  TextEditingController countryName = TextEditingController();
  @override
  void initState() {
    email.text = "";
    gender.text = "";
    age.text = "";
    height.text = "";
    weight.text = "";
    edu.text = "";
    countryName.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<Gender>> genderEntries =
        <DropdownMenuEntry<Gender>>[];
    for (final Gender color in Gender.values) {
      genderEntries.add(
        DropdownMenuEntry<Gender>(
          value: color,
          label: color.label,
        ),
      );
    }
    final List<DropdownMenuEntry<Education>> educationEntries =
        <DropdownMenuEntry<Education>>[];
    for (final Education color in Education.values) {
      educationEntries.add(
        DropdownMenuEntry<Education>(
          value: color,
          label: color.label,
        ),
      );
    }

    Gender? selectedGender;
    Education? selectedEducation;
    // String countryName;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TextField(
                //   controller: password,
                //   cursorColor: Colors.purple,
                //   decoration: InputDecoration(
                //       labelStyle: TextStyle(color: Colors.white),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(width: 3, color: Colors.purple),
                //       ), //
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(width: 3, color: Colors.purple),
                //       ), // ,
                //       border: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.purple)),
                //       hintText: 'Tell us about yourself',
                //       helperText: 'Keep it short, this is just a demo.',
                //       labelText: 'Life story',
                //       prefixIcon: const Icon(
                //         Icons.person,
                //         color: Colors.white,
                //       ),
                //       prefixText: ' ',
                //       suffixText: 'USD',
                //       suffixStyle: const TextStyle(color: Colors.green)),
                // ),
                TextField(
                  controller: email,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.purple),
                    ), //
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.purple),
                    ), // ,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)),
                    hintText: 'Enter Email',
                    labelText: 'Email',
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                ),
                DropdownMenu<Gender>(
                  width: 353,
                  textStyle: TextStyle(color: Colors.white),
                  leadingIcon: const Icon(
                    Icons.wc,
                    color: Colors.white,
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.purple),
                    ), //
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.purple),
                    ), // ,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)),
                  ),
                  controller: gender,
                  label: const Text('Gender'),
                  dropdownMenuEntries: genderEntries,
                  onSelected: (Gender? gender) {
                    setState(() {
                      selectedGender = gender;
                    });
                  },
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  controller: age,
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.purple),
                    ), //
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.purple),
                    ), // ,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)),
                    labelText: 'Age',
                    prefixIcon: const Icon(
                      Icons.equalizer,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  controller: height,
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), //
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), // ,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      labelText: 'Height',
                      prefixIcon: const Icon(
                        Icons.height,
                        color: Colors.white,
                      ),
                      prefixText: ' ',
                      suffixText: 'cm',
                      suffixStyle: const TextStyle(color: Colors.purple)),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  controller: weight,
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), //
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), // ,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      labelText: 'Weight',
                      prefixIcon: const Icon(
                        Icons.monitor_weight,
                        color: Colors.white,
                      ),
                      prefixText: ' ',
                      suffixText: 'Kg',
                      suffixStyle: const TextStyle(color: Colors.purple)),
                ),
                DropdownMenu<Education>(
                  width: 353,
                  textStyle: TextStyle(color: Colors.white),
                  leadingIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.purple),
                    ), //
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.purple),
                    ), // ,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)),
                  ),
                  controller: edu,
                  label: const Text('Education'),
                  dropdownMenuEntries: educationEntries,
                  onSelected: (Education? education) {
                    setState(() {
                      selectedEducation = education;
                    });
                  },
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  readOnly: true,
                  controller: countryName,
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.purple),
                    ), //
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.purple),
                    ), // ,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)),
                    labelText: 'Country',
                    prefixIcon: const Icon(
                      Icons.public,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.purple)),
                  onPressed: () {
                    showCountryPicker(
                      context: context,
                      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                      favorite: <String>['MY'],
                      //Optional. Shows phone code before the country name.
                      onSelect: (Country country) {
                        print('Select country: ${country.name}');
                        countryName.text = country.name;
                      },
                      // Optional. Sets the theme for the country list picker.
                      countryListTheme: CountryListThemeData(
                        // Optional. Sets the border radius for the bottomsheet.
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                        // Optional. Styles the search field.
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                        // Optional. Styles the text in the search field
                        searchTextStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  child: const Text('Select Your Country',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ));
  }
}

enum Gender {
  female('Female', 'female'),
  male('Male', 'male');

  const Gender(this.label, this.gender);
  final String label;
  final String gender;
}

enum Education {
  e1('No Formal Education', '1'),
  e2('Primary School', '2'),
  e3('Professional Certificate/Diploma', '3'),
  e4("Bachelor's Degree", '4'),
  e5("Master's Degree", '5'),
  e6('Doctorate (PhD) or Higher', '6');

  const Education(this.label, this.education);
  final String label;
  final String education;
}
