import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateCalculator();
  }
}

class StateCalculator extends State<FirstPage> {
  var _keyForm = GlobalKey<FormState>();

  // static members initialize here
  double minMargin = 16.0;
  double labelMargin = 7.0;
  var _currencies = ["Rupees", "Dollars", "Pounds"];

  // not allowed because only static member initialize here
  var _selectedCurrencies = "";

  @override
  void initState() {
    super.initState();
    _selectedCurrencies = _currencies[0];
  }

  var displayTotal = "";
  TextEditingController principalAmount = TextEditingController();
  TextEditingController rateOfIntrest = TextEditingController();
  TextEditingController term = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator",
        ),
      ),
      body: Form(
        key: _keyForm,
        child: Padding(
            padding: EdgeInsets.all(minMargin),
            child: ListView(
              children: <Widget>[
                getImage(),
                Padding(
                    padding:
                        EdgeInsets.only(top: labelMargin, bottom: labelMargin),
                    child: TextFormField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: principalAmount,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Field cann't be empty !! Please enter number";
                        } else if (!isNumeric(value)) {
                          return "Please enter valid number";
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Enter principal amount",
                          labelText: "Amount",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(top: labelMargin, bottom: labelMargin),
                    child: TextFormField(
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      controller: rateOfIntrest,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Field cann't be empty !! Please enter number";
                        } else if (!isNumeric(value)) {
                          return "Please enter valid number";
                        }
                      },
                      decoration: InputDecoration(
                          labelStyle: textStyle,
                          hintText: "Enter rate of interest(In percent)",
                          labelText: "Rate of interest",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    )),
                Padding(
                  padding:
                      EdgeInsets.only(top: labelMargin, bottom: labelMargin),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        controller: term,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Field cann't be empty !! Please enter number";
                          } else if (!isNumeric(value)) {
                            return "Please enter valid number";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Time in year",
                            labelText: "Term",
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                      )),
                      Container(
                        width: minMargin,
                      ),
                      Expanded(
                          child: DropdownButton<String>(
                        style: textStyle,
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _selectedCurrencies,
                        onChanged: (String newValue) {
                          _selectedCurr(newValue);
                        },
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: labelMargin, bottom: labelMargin),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text("Calculate", textScaleFactor: 1.2),
                          onPressed: () {
                            setState(() {
                              if (_keyForm.currentState.validate()) {
                                this.displayTotal = _calculateSI();
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorLight,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text("Reset", textScaleFactor: 1.2),
                          onPressed: () {
                            setState(() {
                              _clearFields();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: labelMargin, bottom: labelMargin),
                  child: Text(
                    this.displayTotal,
                    style: textStyle,
                    textScaleFactor: 1,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  // set image
  Widget getImage() {
    AssetImage imageA = AssetImage("images/calc.png");
    Image image = Image(
      image: imageA,
      width: 120.0,
      height: 120.0,
    );
    return Container(
      child: image,
    );
  }

  void _selectedCurr(String newVal) {
    setState(() {
      this._selectedCurrencies = newVal;
    });
  }

  String _calculateSI() {
    double p = double.parse(principalAmount.text);
    double t = double.parse(rateOfIntrest.text);
    double r = double.parse(term.text);
    double amount = p + (p * t * r / 100);
    String str =
        "After $t @ rate of $r your amount $p will be worth of $amount $_selectedCurrencies";
    this.displayTotal = str;
    return str;
  }

  void _clearFields() {
    principalAmount.text = "";
    rateOfIntrest.text = "";
    term.text = "";
    _selectedCurrencies = _currencies[0];
    this.displayTotal = "";
  }

  bool isNumeric(String value) {
    bool isNumber = false;
    try {
      double d = double.parse(value);
      isNumber = true;
    } on FormatException {
      isNumber = false;
    }
    return isNumber;
  }
}
