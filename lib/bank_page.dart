import 'package:app_test/banka_api.dart';
import 'package:app_test/banka_bilgi.dart';
import 'package:app_test/navbar_onTap.dart';
import 'package:app_test/sign_up.dart';
import 'package:app_test/sizes.dart';
import 'package:flutter/material.dart';
import 'package:app_test/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class bankPage extends StatefulWidget {
  bankPage({Key? key}) : super(key: key);

  @override
  State<bankPage> createState() => _bankPageState();
}

class _bankPageState extends State<bankPage> {
  bankInfo _service = bankInfo();
  List<BankaApiData?> data = [];
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _service.bankBilgi().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          data = value.data!;
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xfff3f4f6),
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / Sizes.height60),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.width / Sizes.width10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / Sizes.width40,
                      height:
                          MediaQuery.of(context).size.height / Sizes.height40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width /
                                Sizes.width40,
                            height: MediaQuery.of(context).size.height /
                                Sizes.height40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notification_add,
                                color: Colors.black,
                              ),
                            )),
                        SizedBox(
                          width:
                              MediaQuery.of(context).size.width / Sizes.width10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width /
                                Sizes.width40,
                            height: MediaQuery.of(context).size.height /
                                Sizes.height40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _showDialog(context);
                              },
                              icon: Icon(
                                Icons.settings,
                                color: Colors.black,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / Sizes.height10,
                    left: MediaQuery.of(context).size.width / Sizes.width10,
                    right: MediaQuery.of(context).size.width / Sizes.width10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / Sizes.height60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / Sizes.width10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width:
                              MediaQuery.of(context).size.width / Sizes.width40,
                          height: MediaQuery.of(context).size.height /
                              Sizes.height40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage('assets/images/tr-icon.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'TL',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  Sizes.width30,
                            ),
                            Text(
                              '234',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / Sizes.height700,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width /
                                Sizes.width10,
                            vertical: MediaQuery.of(context).size.height /
                                Sizes.height5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ListTile(
                              title: TextButton(
                                child: Text(
                                  data[index]!.bankName!,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: bankChoice(
                                          context,
                                          data[index]!.bankName!,
                                          data[index]!.bankIban!,
                                          data[index]!.descriptionNo!),
                                      backgroundColor: Color(0xfff3f4f6),
                                    ),
                                  );
                                },
                              ),
                              subtitle: Text('Havala / EFT ile para gönderin'),
                              //Todo leading yapılacak
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          print(_currentIndex);
          _currentIndex = value;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DialogExample()));
        },
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
        fixedColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.transform),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.credit_card,
              color: Colors.green,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

_showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Çıkış"),
        actions: <Widget>[
          new ElevatedButton(
            child: new Text("Çıkış Yap"),
            onPressed: () async {
              AuthService _authService = AuthService();
              _authService.signOut();
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove("email");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return SignUp();
              }));
            },
          ),
        ],
      );
    },
  );
}

bankChoice(BuildContext context, data1, data2, data3) {
  return Container(
    alignment: Alignment.bottomCenter,
    height: MediaQuery.of(context).size.height / Sizes.height310,
    width: MediaQuery.of(context).size.width,
    color: Color(0xfff3f4f6),
    child: Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / Sizes.height18,
          left: MediaQuery.of(context).size.width / Sizes.width10,
          right: MediaQuery.of(context).size.width / Sizes.width10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / Sizes.width150,
              height: MediaQuery.of(context).size.height / Sizes.height20,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Center(
                child: Text(
                  'Transfer İşlemi',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / Sizes.height18,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / Sizes.height50,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / Sizes.width10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'BANKA ADI:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        data1,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / Sizes.height18,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / Sizes.height50,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / Sizes.width10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'IBAN:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        data2,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                        onPressed: () {
                          debugPrint('Kopyalama işlemi başarılı');
                        },
                        icon: Icon(
                          Icons.copy,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / Sizes.height18,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / Sizes.height50,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / Sizes.width10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'AÇIKLAMA:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        data3,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / Sizes.height18,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () {},
              child: Text(
                'İşlem Sayfasına Geç',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
