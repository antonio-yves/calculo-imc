import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Calculo de IMC",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightControler = TextEditingController();
  TextEditingController heightControler = TextEditingController();

  String infoText = "Informe seus dados!";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetField(){
    weightControler.text = "";
    heightControler.text = "";
    setState(() {
      infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcIMC(){
    setState(() {
      double peso = double.parse(weightControler.text);
      double altura = double.parse(heightControler.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 17){
        infoText = "Muito abaixo do peso! (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 17 && imc <= 18.49){
        infoText = "Abaixo do peso! (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.5 && imc <= 24.99){
        infoText = "Peso normal! (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25 && imc <= 29.99){
        infoText = "Acima do Peso! (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30 && imc <= 34.99){
        infoText = "Obesidade Nível I! (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 35 && imc <= 39.99){
        infoText = "Obesidade Nível II (severa)! (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40){
        infoText = "Obesidade Nível III (mórbida)! (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetField,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120.0, color: Colors.red,),
              // Peso
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(color: Colors.red)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25.0),
                controller: weightControler,
                validator: (value) {
                  if (value.isEmpty){
                    return "Informe seu peso!";
                  }
                },
              ),
              // Altura
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.red),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25.0),
                controller: heightControler,
                validator: (value) {
                  if (value.isEmpty){
                    return "Informe sua altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                height: 50.0,
                child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()){
                        _calcIMC();
                      }
                    },
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    color: Colors.red,
                  ),
                ),
              ),
              Text(
                "$infoText", 
                style: TextStyle(color: Colors.black, fontSize: 25.0), 
                textAlign: TextAlign.center
              ),
            ],
          ),
        ),
      ),
    );
  }
}