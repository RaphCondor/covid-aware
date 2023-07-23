import 'dart:convert';
import 'package:flutter/material.dart';
import 'model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget{
  MyHomePage({Key key, this.title}) : super(key : key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  final String url = "https://api.thevirustracker.com/free-api?global=stats";
  final String url1 = "https://api.thevirustracker.com/free-api?countryTotals=ALL";

  String cases, deaths, recovered;
  String finals = "Loading...";
  String finals1 = "Loading...";
  String finals2 = "Loading...";

  String casesPH, deathsPH, recoveredPH, newPH, newdPH;
  String ph1 = "Loading...";
  String ph2 = "Loading...";
  String ph3 = "Loading...";
  String ph4 = "Loading...";
  String ph5 = "Loading...";

  String string;
  var loading = false;
  
    

  @override
  void initState(){
    super.initState();
    loadData();
    loadPH();
  }

 loadPH() async{
    DateFormat dateFormat = DateFormat("MM-dd-yyyy HH:mm:ss");
    string = dateFormat.format(DateTime.now());
    var response = await http.get(url1,headers: {"Accept":"application/json"});

    if(response.statusCode == 200){
      String responseBody = response.body;
      var jsonBody = json.decode(responseBody);
      Album1 album = new Album1.fromJson(jsonBody);


      setState(() {

      RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      Function mathFunc = (Match match) => '${match[1]},';
      casesPH = album.results[0].data.tc;
      ph1 = casesPH.replaceAllMapped(reg, mathFunc);
      deathsPH = album.results[0].data.td;
      ph2 = deathsPH.replaceAllMapped(reg, mathFunc);
      recoveredPH = album.results[0].data.tr;
      ph3 = recoveredPH.replaceAllMapped(reg, mathFunc);
      newPH = album.results[0].data.nc;
      ph4 = newPH.replaceAllMapped(reg, mathFunc);
      newdPH = album.results[0].data.nd;
      ph5 = newdPH.replaceAllMapped(reg, mathFunc);

      });
    }
    else{
      print("Failed PH");
    }
  }

  loadData() async{
    var response = await http.get(url,headers: {"Accept":"application/json"});

    if(response.statusCode == 200){
      String responseBody = response.body;
      var jsonBody = json.decode(responseBody);
      Album album = new Album.fromJson(jsonBody);


      setState(() {

      RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      Function mathFunc = (Match match) => '${match[1]},';
        cases = album.results[0].data.toString();
        deaths = album.results[0].deaths.toString();
        recovered = album.results[0].recovered.toString();
        finals1 = deaths.replaceAllMapped(reg, mathFunc);
        finals = cases.replaceAllMapped(reg, mathFunc);
        finals2 = recovered.replaceAllMapped(reg, mathFunc);

      });
    }
    else{
      print("Failed Global");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID Aware',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('COVID Aware'),
          // actions: <Widget>[
          //   IconButton(icon: Icon(Icons.refresh), onPressed: (){
          //     loadData();
          //     loadPH();
          //   })
          // ],
        ),
        
        body: RefreshIndicator(
          onRefresh: () async{
          setState(() {
               loadData();
               loadPH();
             });
        },
          child: SingleChildScrollView(
            child:Column(
            children: <Widget>[ 
            Container(
              child: Center(child: Image.asset("assets/logo.png",
              height: 150,),)
            ),
            Card(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
              margin: EdgeInsets.fromLTRB( 20, 20, 20, 20),
               elevation: 12.0,
              child: Column(
                children: <Widget>[
                  ListTile(
                  leading: CircleAvatar(backgroundImage: AssetImage('assets/covid.png'),),
                  title: Text("Global COVID-19 Counter",
                        style: TextStyle(fontSize: 20)),
                  subtitle: Text("As of " + string,
                        style: TextStyle(fontSize: 14),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                    Center(
                      child:Column(
                      children: <Widget>[
            
                            Text("Total Confirmed Cases",
                              style: TextStyle(fontSize: 14),),
                            Text(finals,
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                          ],)
                    ),
                       Center(
                      child:Column(
                      children: <Widget>[
                        Text("Total Confirmed Deaths",
                          style: TextStyle(fontSize: 14),),
                        Text(finals1,
                          style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.bold),)
                      ]
                      ),
                    ),
                  ],
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Text("Total Confirmed Recoveries",
                          style: TextStyle(fontSize: 14)),
                        Text(finals2,
                          style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.bold)),
                      SizedBox(height: 20,),
                      ],
                      
                    ),
                  ),
                ]
              ),
            ),
          Card(
              margin: EdgeInsets.fromLTRB( 20,0, 20, 20),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
               elevation: 12.0,
               child: Column(children: <Widget>[
                ListTile(
                  leading: CircleAvatar(backgroundImage: AssetImage('assets/ph.png'),),
                  title: Text("Philippines COVID-19 Counter",
                        style: TextStyle(fontSize: 20)),
                  subtitle: Text("As of " + string,
                        style: TextStyle(fontSize: 14),),
                  ),
                  SizedBox(height:20),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                    Center(
                      child:Column(
                      children: <Widget>[
                        Text("Total Confirmed Cases",
                          style: TextStyle(fontSize: 14),),
                        Text(ph1,
                          style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.bold),)
                      ]
                      ),
                    ),
                       Center(
                      child:Column(
                      children: <Widget>[
                        Text("Total Confirmed Deaths",
                          style: TextStyle(fontSize: 14),),
                        Text(ph2,
                          style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.bold),)
                      ]
                      ),
                    ),
                  ],
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Text("Total Confirmed Recoveries",
                          style: TextStyle(fontSize: 16)),
                        Text(ph3,
                          style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.bold)),
                    SizedBox(height: 10,),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                          Column(
                            children: <Widget> [
                              Text("New Cases Today",
                                style: TextStyle(fontSize: 16)),
                              Text(ph4,
                                style: TextStyle(fontSize: 16
                                ,fontWeight: FontWeight.bold)),
                            ]
                          ),

                          Column(
                            children: <Widget> [
                              Text("New Deaths Today",
                                style: TextStyle(fontSize: 16)),
                              Text(ph5,
                                style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.bold)),
                              
                            ]
                          ),
                          
                    ],
                   
                  ),
                  SizedBox(height:20),
                 ],
                 ),
                ),
                Container(
                
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: 
                Text("thevirustracker.com",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 12),)
                )
             ],
           ),
          ),
        ),
        // bottomNavigationBar: BottomAppBar(
        //   child: Text("Raphael Condor\nraphaelcondor.com",
        //   style: TextStyle(color: Colors.white,),
        //   textAlign: TextAlign.center,),
        
        //   color: Colors.black),
        ),
  
    );
  }
}
