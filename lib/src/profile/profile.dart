import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Gender selectedGender = Gender.male;
  Education selectedEducation = Education.e1;
  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email.text);
    prefs.setString('gender', selectedGender.gender);
    prefs.setString('age', age.text);
    prefs.setString('height', height.text);
    prefs.setString('weight', weight.text);
    prefs.setString('education', selectedEducation.education);
    prefs.setString('country', countryName.text);
  }

  Future<void> loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email.text = prefs.getString('email') ?? '';
      String genderValue = prefs.getString('gender') ?? '';
      selectedGender = Gender.values.firstWhere(
          (gender) => gender.gender == genderValue,
          orElse: () => Gender.male);
      age.text = prefs.getString('age') ?? '';
      height.text = prefs.getString('height') ?? '';
      weight.text = prefs.getString('weight') ?? '';
      String educationValue = prefs.getString('education') ?? '';
      selectedEducation = Education.values.firstWhere(
          (education) => education.education == educationValue,
          orElse: () => Education.e1);
      countryName.text = prefs.getString('country') ?? '';
      gender.text = selectedGender.label;
      edu.text =
          selectedEducation.label; // Set the initial value for the gender field
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<Gender?>> genderEntries =
        <DropdownMenuEntry<Gender?>>[];
    for (final Gender color in Gender.values) {
      genderEntries.add(
        DropdownMenuEntry<Gender?>(
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

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'YOUR PROFILE',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.purple,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ] //BoxShadow
                      ),
                  child: TextField(
                    controller: email,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 235, 170, 255),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), //
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), // ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.purple)),
                      hintText: 'Enter Email',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                      labelText: 'Email',
                      prefixIcon: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.purple,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 19),
                        child: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.purple,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ] //BoxShadow
                      ),
                  child: DropdownMenu<Gender?>(
                    width: 353,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    leadingIcon: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.purple,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 19),
                      child: const Icon(
                        Icons.wc,
                        color: Colors.white,
                      ),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      fillColor: Color.fromARGB(255, 235, 170, 255),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), //
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), // ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    controller: gender,
                    label: const Text('Gender'),
                    dropdownMenuEntries: genderEntries,
                    onSelected: (Gender? gender) {
                      setState(() {
                        selectedGender = gender!;
                      });
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      )
                    ],
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    controller: age,
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 235, 170, 255),
                      filled: true,
                      hintText: 'Enter Age',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), //
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), // ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.purple)),
                      labelText: 'Age',
                      prefixIcon: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.purple,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 19),
                        child: const Icon(
                          Icons.elderly,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.purple,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ] //BoxShadow
                      ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    controller: height,
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 235, 170, 255),
                        filled: true,
                        hintText: 'Enter Height',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(width: 3, color: Colors.purple),
                        ), //
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(width: 3, color: Colors.purple),
                        ), // ,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.purple)),
                        labelText: 'Height',
                        prefixIcon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.purple,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 19),
                          child: const Icon(
                            Icons.height,
                            color: Colors.white,
                          ),
                        ),
                        prefixText: ' ',
                        suffixText: 'cm',
                        suffixStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.purple,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ] //BoxShadow
                      ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    controller: weight,
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                        fillColor: Color.fromARGB(255, 235, 170, 255),
                        filled: true,
                        hintText: 'Enter Weight',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(width: 3, color: Colors.purple),
                        ), //
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(width: 3, color: Colors.purple),
                        ), // ,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.purple)),
                        labelText: 'Weight',
                        prefixIcon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.purple,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 19),
                          child: const Icon(
                            Icons.monitor_weight,
                            color: Colors.white,
                          ),
                        ),
                        prefixText: ' ',
                        suffixText: 'Kg',
                        suffixStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.purple,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ] //BoxShadow
                      ),
                  child: DropdownMenu<Education>(
                    width: 353,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    leadingIcon: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.purple,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 19),
                      child: const Icon(
                        Icons.book,
                        color: Colors.white,
                      ),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      fillColor: Color.fromARGB(255, 235, 170, 255),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), //
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), // ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.purple)),
                    ),
                    controller: edu,
                    label: const Text('Education'),
                    dropdownMenuEntries: educationEntries,
                    onSelected: (Education? education) {
                      setState(() {
                        selectedEducation = education!;
                      });
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.purple,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ] //BoxShadow
                      ),
                  child: TextField(
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    readOnly: true,
                    controller: countryName,
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 235, 170, 255),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), //
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(width: 3, color: Colors.purple),
                      ), // ,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.purple)),
                      labelText: 'Country',
                      prefixIcon: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.purple,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 19),
                        child: const Icon(
                          Icons.public,
                          color: Colors.white,
                        ),
                      ),
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
                          fillColor: Color.fromARGB(255, 235, 170, 255),
                          filled: true,
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
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                  ),
                  onPressed: () {
                    saveProfileData();
                    final snackBar = SnackBar(
                      content: const Text('Profile is saved successfully!'),
                      backgroundColor: (Colors.black12),
                      action: SnackBarAction(
                        label: 'dismiss',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text('Save Profile',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
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
