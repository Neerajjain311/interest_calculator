import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Interest Calculator App",
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
    home: MyForm(),
  ));
}

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyFormState();
  }
}

class MyFormState extends State<MyForm> {
  var _formKey = GlobalKey<FormState>();
  var _mode = ['Simple', 'Compound'];
  final _minpadding = 5.0;
  var _currItemSelected = 'Simple';
  var displayResult = '';

  @override
  void initState() {
    super.initState();
    _currItemSelected = _mode[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 15.0);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Interest Calculator",
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(top: _minpadding, bottom: _minpadding),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                  padding:
                      EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    validator: (String value) {
                      if (value.isEmpty) return "Please Enter the Amount";
                    },
                    controller: principalController,
                    decoration: InputDecoration(
                        labelText: "Principal Amount",
                        labelStyle: textStyle,
                        hintText: "Enter Principal Amount",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  )),
              Padding(
                  padding:
                      EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    validator: (String value) {
                      if (value.isEmpty)
                        return "Please Enter the Interest Rate";
                    },
                    controller: rateController,
                    decoration: InputDecoration(
                        labelText: "Interest Rate",
                        labelStyle: textStyle,
                        hintText: "Enter Interest Percent (%)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  )),
              Padding(
                  padding:
                      EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: timeController,
                        validator: (String value) {
                          if (value.isEmpty) return "Please Enter Time";
                        },
                        decoration: InputDecoration(
                            labelText: "Time Period",
                            labelStyle: textStyle,
                            hintText: "Enter Time (years)",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                      )),
                      Container(
                        width: _minpadding * 3,
                      ),
                      Expanded(
                          child: DropdownButton<String>(
                        items: _mode.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: textStyle,
                            ),
                          );
                        }).toList(),
                        value: _currItemSelected,
                        onChanged: (String newValueSelected) {
                          _dropDownItemSelected(newValueSelected);
                        },
                      ))
                    ],
                  )),
              Padding(
                  padding:
                      EdgeInsets.only(top: _minpadding, bottom: _minpadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                        elevation: 10.0,
                        color: Colors.indigo,
                        child: Text(
                          "Calculate",
                          style: textStyle,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate())
                              this.displayResult = _calInterest();
                          });
                        },
                      )),
                      Container(
                        width: _minpadding * 3,
                      ),
                      Expanded(
                          child: RaisedButton(
                        elevation: 10.0,
                        color: Colors.black,
                        child: Text(
                          "Reset",
                          style: textStyle,
                        ),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      )),
                    ],
                  )),
              Padding(
                padding:
                    EdgeInsets.only(top: _minpadding * 2, bottom: _minpadding),
                child: Center(
                  child: Text(
                    displayResult,
                    style: textStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/bg.jpg');
    Image image = Image(
      image: assetImage,
      width: 100.0,
      height: 100.0,
    );
    return Center(
        child: Container(
      child: image,
      margin: EdgeInsets.only(top: _minpadding * 2, bottom: _minpadding * 2),
    ));
  }

  void _dropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currItemSelected = newValueSelected;
    });
  }

  String _calInterest() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    double time = double.parse(timeController.text);
    double totalAmount;
    String Amount;
    if (_currItemSelected == "Simple")
      totalAmount = principal + (principal * time * rate) / 100;
    else
      totalAmount = principal * pow((1 + (rate / 100)), time);

    Amount = totalAmount.toStringAsFixed(2);
    String result = "Amount with $_currItemSelected Interest = $Amount";
    return result;
  }

  void _reset() {
    principalController.text = '';
    rateController.text = '';
    timeController.text = '';
    displayResult = '';
    _currItemSelected = _mode[0];
  }
}
