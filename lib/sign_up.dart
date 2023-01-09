import 'package:app_test/auth.dart';
import 'package:app_test/bank_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool checkedValue = false;
  bool checkBoxValue = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/image.jpg'),
              colorFilter: ColorFilter.mode(
                  Colors.purple.withOpacity(0.8), BlendMode.modulate),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / Sizes.height250,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height:
                          MediaQuery.of(context).size.height / Sizes.height80,
                      width: MediaQuery.of(context).size.width / Sizes.width80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / Sizes.width10,
                    ),
                    Text(
                      'SanaLira',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / Sizes.height500,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Color(0xFF252536).withOpacity(0.5),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / Sizes.height25,
                      left: MediaQuery.of(context).size.width / Sizes.width10,
                      right: MediaQuery.of(context).size.width / Sizes.width10),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "SanaLira'ya",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  Sizes.width5,
                            ),
                            Text(
                              'Yeni Üyelik',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height /
                              Sizes.height5,
                        ),
                        Text(
                          'Bilgilerinizi girip sözleşmeyi onaylayın.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height /
                              Sizes.height25,
                        ),
                        TextField(
                            controller: _nameController,
                            style: TextStyle(color: Colors.white54),
                            decoration: InputDecoration(
                              labelText: "Ad",
                              labelStyle: TextStyle(color: Colors.white54),
                              border: OutlineInputBorder(
                                  //Outline border type for TextFeild
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.white54,
                                    width: 1,
                                  )),
                              //normal border
                              enabledBorder: OutlineInputBorder(
                                  //Outline border type for TextFeild
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.white54,
                                    width: 1,
                                  )),
                              //enabled border
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                    color: Colors.white54,
                                    width: 1,
                                  )), //focused border
                              // set more border style like disabledBorder
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height /
                              Sizes.height15,
                        ),
                        TextField(
                          controller: _surnameController,
                          style: TextStyle(color: Colors.white54),
                          decoration: InputDecoration(
                            labelText: "Soyad",
                            labelStyle: TextStyle(color: Colors.white54),
                            enabledBorder: OutlineInputBorder(
                                //Outline border type for TextFeild
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                  width: 1,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                  width: 1,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height /
                              Sizes.height15,
                        ),
                        TextField(
                          controller: _emailController,
                          style: TextStyle(color: Colors.white54),
                          decoration: InputDecoration(
                            labelText: "E-posta",
                            labelStyle: TextStyle(color: Colors.white54),
                            enabledBorder: OutlineInputBorder(
                                //Outline border type for TextFeild
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                  width: 1,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                  width: 1,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height /
                              Sizes.height15,
                        ),
                        IntlPhoneField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Cep Telefonu Numaranız',
                            labelStyle: TextStyle(color: Colors.white54),
                            enabledBorder: OutlineInputBorder(
                              //Outline border type for TextFeild
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.white54,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                  width: 1,
                                )),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.white54,
                                width: 1,
                              ),
                            ),
                          ),
                          initialCountryCode: 'TR',
                          dropdownTextStyle: TextStyle(color: Colors.white54),
                          style: TextStyle(color: Colors.white54),
                          onChanged: (phone) {},
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    tristate: false,
                                    checkColor: Colors.green,
                                    activeColor: Colors.white,
                                    value: checkedValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        checkedValue = newValue!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Hesabınızı oluştururken',
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'sözleşme ve koşulları',
                                      style: TextStyle(
                                          color: Colors.green,
                                          overflow: TextOverflow.fade),
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                    'kabul etmeniz gerekir.',
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  final snackBar = SnackBar(
                                    content: const Text(
                                        'Alanı doldururken eksik ya da yanlış işlem yaptınız.'),
                                    backgroundColor: (Colors.black12),
                                    action: SnackBarAction(
                                      label: 'Kapat',
                                      onPressed: () {},
                                    ),
                                  );
                                  if (_nameController.value.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (_surnameController
                                      .value.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (_emailController.value.text ==
                                          null ||
                                      _emailController.value.text.isEmpty ||
                                      !_emailController.value.text
                                          .contains('@') ||
                                      !_emailController.value.text
                                          .contains('.')) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    // errorMailText(_emailController.value.text,true);

                                    //showAlertDg(context);

                                  } else if (checkedValue == false) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    try {
                                      _authService.register(
                                          _nameController.value.text,
                                          _surnameController.value.text,
                                          _emailController.value.text,
                                          _phoneController.value.text);
                                    } catch (e) {
                                    } finally {
                                      _authService
                                          .signIn(_emailController.value.text,
                                              _phoneController.value.text)
                                          .then((value) async {
                                        SharedPreferences pref =
                                            await SharedPreferences
                                                .getInstance();
                                        pref.setString("email",
                                            _emailController.value.text);
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (_) {
                                          return bankPage();
                                        }));
                                      });
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height /
                                          Sizes.height40),
                                  alignment: Alignment.center,
                                  backgroundColor: Colors.green,
                                ),
                                child: Text(
                                  'Giriş Yap',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
