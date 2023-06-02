import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    TextEditingController _controllerCEP = TextEditingController();

    String _titulo = "";
    String _img = "";
    String _descricao = "";
    String _autores = "";


  _recupera_cep() async {
    String meu_cep = _controllerCEP.text;
    String url = "https://viacep.com.br/ws/${meu_cep}/json/";
    String url2 = "https://fxbiblioteca300.herokuapp.com/api/obras/${meu_cep}/";
    http.Response response;
    response = await http.get(url2);
    print("resposta: "+ response.body);
    //(response.bodyBytes)
    Map<String, dynamic> retorno = json.decode( response.body );
    print("resposta: 222");


    String titulo = retorno["titulo"];
    print("resposta: 21");

    String img = retorno["img"];
    print("resposta: 22");

    String descricao = retorno["descricao"];
    print("resposta: 23");

    String autores;
   // autores = retorno["autores"]['nome'].toString() ;
    print("resposta: 2");


  setState(() {

   _titulo = "${titulo}";
   _img = "${img}";
   _descricao = "${descricao}";
   //_autores = "${autores}";
   print("resposta: 3333");

  });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title:  Text(
        "Consumo de Obras - Livros"
      ),
      ),
      body: SingleChildScrollView(
      child: ConstrainedBox(
      constraints: BoxConstraints(),
      child: SingleChildScrollView(
      child: ConstrainedBox(
      constraints: BoxConstraints(),
      child: Container(

        padding: EdgeInsets.all(35)
        ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "DIGITE O ID:"
            ),
            style: TextStyle(
              fontSize: 25,
            ),
            controller: _controllerCEP,
          ),
            Padding(padding: EdgeInsets.only(top: 10),
                child:  RaisedButton(
                  onPressed: _recupera_cep,
                  child: Text("Ver Livro!"),
                )
            ),

            Padding(padding: EdgeInsets.only(left: 50,top: 30),
              child: Text("Titulo: "+(_titulo),
                  style: TextStyle(height: 1, fontSize: 20)),
            ),
            Padding(padding: EdgeInsets.only(left: 50,top: 30),
              child: Image( image: NetworkImage(_img),),
            ),
            Padding(padding: EdgeInsets.only(left: 50,top: 30),
              child: Text("Descrição: "+_descricao,
                style: TextStyle(height: 1, fontSize: 20)),
            ),
           // Padding(padding: EdgeInsets.only(left: 100),
            //  child: Text("UF: "+_autores),
           // ),

          ],

        ),

      ),

    ),
    ),
    ),
      ),
      backgroundColor: Colors.blue[200],);
  }
}


