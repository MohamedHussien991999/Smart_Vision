import 'package:flutter/material.dart';
import 'package:smart_farm/shared/components/constants.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  ImageProvider changeImage() {
    if (loginModelFinal!.imageProfile == null) {
      return const AssetImage('assets/images/Default_prf.png');
    } else {
      return FileImage(loginModelFinal!.imageProfile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: "gillsans",
          ),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.navigate_before,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
        child: ListView(children: [
          Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: changeImage(),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 5.0,
                          )),
                      height: 200,
                      width: 200,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "${loginModelFinal!.userName}",
                    style:
                        const TextStyle(fontSize: 30, fontFamily: "gillsans"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          const ListTile(
                            tileColor: Color(0xFF34D399),
                            title: Text(
                                "\t \t  General Information\t \t \t\t \t \t\t \t 1/3"), //1-firstName
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: const Icon(Icons.person),
                            title: const Text('First name'),
                            subtitle: Text(
                                "${loginModelFinal!.firstName}"), //1-firstName
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: const Icon(Icons.person),
                            title: const Text('Last name'),
                            subtitle: Text("${loginModelFinal!.lastName}"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.email),
                            title: const Text("Email"),
                            subtitle: Text("${loginModelFinal!.email}"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.phone),
                            title: const Text("Phone"),
                            subtitle: Text("${loginModelFinal!.phoneNumber}"),
                          ),
                          const ListTile(
                            tileColor: Color(0xFF34D399),
                            title: Text(
                                "\t \t  Location Information\t \t \t\t \t \t\t \t 2/3"), //1-firstName
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          ListTile(
                            leading: const Icon(Icons.add_road),
                            title: const Text('Street Name'),
                            subtitle: Text("${loginModelFinal!.streetName}"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.location_city),
                            title: const Text('City'),
                            subtitle: Text("${loginModelFinal!.city}"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.location_on_outlined),
                            title: const Text('State'),
                            subtitle: Text("${loginModelFinal!.state}"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.flag),
                            title: const Text('Country'),
                            subtitle: Text("${loginModelFinal!.country}"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.local_post_office_sharp),
                            title: const Text('Post Code'),
                            subtitle: Text("${loginModelFinal!.postCode}"),
                          ),
                          const ListTile(
                            tileColor: Color(0xFF34D399),
                            title: Text(
                                "\t \t Specific Information\t \t \t\t \t \t\t \t 3/3"), //1-firstName
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: const Icon(
                              Icons.engineering_outlined,
                            ),
                            title: const Text(' Role'),
                            subtitle: Text("${loginModelFinal!.role}"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.business_center),
                            title: const Text('Work Field'),
                            subtitle: Text("${loginModelFinal!.workField}"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.business_center),
                            title: const Text('Usage Target'),
                            subtitle: Text("${loginModelFinal!.usageTarget}"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.lightbulb),
                            title: const Text("About My features"),
                            subtitle: Text(
                                "My Feature is :${loginModelFinal!.features}."),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
