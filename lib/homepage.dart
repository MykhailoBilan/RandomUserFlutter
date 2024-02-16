import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<User>> fetch() async {
    List<User> users = [];
    var url = Uri.parse('https://randomuser.me/api/?results=15');
    var response = await http.get(url);
    var body = jsonDecode(response.body) as Map<String, dynamic>;
    for (var i = 0; i < 15; i++) {
      User user = User.fromJson(body['results'][i]);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: FutureBuilder(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ElevatedButton(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.network(
                                    snapshot.data![index].picture,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    Text(
                                        "${snapshot.data![index].firstname} ${snapshot.data![index].lastname}"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(snapshot.data![index].email)
                                  ],
                                ),
                              ],
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Center(
                                    child: Text(
                                        "${snapshot.data![index].firstname} ${snapshot.data![index].lastname}"),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image.network(
                                          snapshot.data![index].picture,
                                        ),
                                      ),
                                      Text(
                                          "Gender: ${snapshot.data![index].gender}"),
                                      Text(
                                          "Email : ${snapshot.data![index].email}"),
                                      Text(
                                          "Phone number: ${snapshot.data![index].cell}"),
                                      Text(
                                          "Country: ${snapshot.data![index].country}"),
                                      Text(
                                          "City: ${snapshot.data![index].city}"),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                        child: Text("OK"))
                                  ],
                                ),
                              );
                            },
                          ),
                          Container(
                            color: Colors.grey,
                            height: 1,
                          )
                        ],
                      );
                    }),
              );
            } else
              return Container();
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.refresh,
          color: Colors.blue,
        ),
        onPressed: () {
          setState(() {
            fetch();
          });
        },
      ),
    );
  }
}
