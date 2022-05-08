import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ColorBlindInstruction extends StatelessWidget {
  // final String? _nameUser;
  // ColorBlindInstruction(this._nameUser);
  // static const routeName = "/colorBlindTest";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.blue.shade100,
          centerTitle: true,
          title: const Text(
            "Өнгөний тест",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
              // color: Colors.red,
              margin: EdgeInsets.only(top: size.height / 11),
              //padding: EdgeInsets.only(top: 200),
              height: size.height / 2,
              width: double.infinity,
              child: Center(child: Image.asset("assets/images/test_01.jpg"))),
          const SizedBox(
            height: 5,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 11),
              child: FittedBox(
                child: Center(
                  child: Text(
                    """""",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              )),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 9,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ColorBlindForm()),
                ),
                child: Container(
                  alignment: Alignment.bottomRight,
                  width: size.width * 0.3,
                  height: size.height * 0.05,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      "Дараах",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.06,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ColorBlindForm extends StatefulWidget {
  static const routeName = "/blindTest";
  @override
  State<ColorBlindForm> createState() => _ColorBlindFormState();
}

class _ColorBlindFormState extends State<ColorBlindForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _textcontroller = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
          child: AppBar(
              title: const Text("Color Blind"),
              automaticallyImplyLeading: true),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Form(
                  key: _formKey,
                  child: user == null
                      ? TextFormField(
                          controller: _textcontroller,
                          decoration: const InputDecoration(
                              hintText: "Нэрээ оруулана уу',
                              labelText: "Нэр",
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Текст оруулана ууу';
                            }
                            return null;
                          },
                        )
                      : TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Нэрээ оруулана уу',
                              labelText: "Нэр",
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Текст оруулана ууу';
                            }
                            return null;
                          },
                          initialValue: user!.displayName,
                        )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // sumbit button
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           ColorBlindInstruction(_textcontroller.text)),
                    // );

                    // update new route
                    if (user != null) {
                      Navigator.pushNamed(context, ColorBlindForm.routeName,
                          arguments: {"_text": user?.displayName});
                    } else {
                      Navigator.pushNamed(context, ColorBlindForm.routeName,
                          arguments: {"_text": _textcontroller.text});
                    }
                  }
                },
                child: const Text('Дараах'),
              ),
            ),
          ],
        ));
  }
}
