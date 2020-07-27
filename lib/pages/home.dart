
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String result = "";
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  void _reset(){
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      result = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
    
  }

  void calc(){
    setState(() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text)/100;
    double imc = peso / (altura * altura);
    if(imc < 18.6){
      result = "seu IMC é ${imc.toStringAsPrecision(3)} - você está abaixo do peso";
    }else if(imc >=18.6 && imc < 24.9){
       result = "seu IMC é ${imc.toStringAsPrecision(3)} - você está no peso ideal";
    }else if(imc >= 24.9 && imc < 29.9){
       result = "seu IMC é ${imc.toStringAsPrecision(3)} - você está levemente acima do peso";
    }else if(imc >=29.9 && imc < 34.9){
       result = "seu IMC é ${imc.toStringAsPrecision(3)} - você está com obesidade grau I";
    }else if(imc >=34.9 && imc < 39.9){
      result = "seu IMC é ${imc.toStringAsPrecision(3)} - você está com obesidade grau II";
    }else {
      result = "seu IMC é ${imc.toStringAsPrecision(3)} - você está com obesidade grau III";
    }

    });
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reset,
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 111, color: Colors.yellow[300]),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.yellow[300], fontSize: 23)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.yellow[300], fontSize: 19),
                controller: pesoController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira seu Peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.yellow[300], fontSize: 23)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.yellow[300], fontSize: 19),
                controller: alturaController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira sua Altura!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 17, bottom: 17),
                child: Container(
                  height: 46,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        calc();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    color: Colors.yellow[300],
                  ),
                ),
              ),
              Text(
                result,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.yellow[300], fontSize: 17),
              )
            ],
          ),
        ),
      ),
    );






  }
}