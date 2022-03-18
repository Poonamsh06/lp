import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../resources/app_components/custom_searchable_dropdown.dart';
import '../modules/management/models/pandit_users_model.dart';

class AllProhit extends StatelessWidget {
  const AllProhit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users_folder/folder/pandit_users")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          List<DropdownMenuItem> list = List<DropdownMenuItem>.generate(
              snapshot.data!.size,
              (index) => DropdownMenuItem(
                  value: Purohit(snapshot.data!.docs[index]).name +
                      Purohit(snapshot.data!.docs[index]).uid +
                      Purohit(snapshot.data!.docs[index]).mobile,
                  child: PurohitTile(
                    documentSnapshot: snapshot.data!.docs[index],
                  )));

          return Scaffold(
            appBar: AppBar(
              title: Text("All purohit profiles"),
              actions: [
                SearchChoices.single(
                  items: list,
                  value: "",
                  onChanged: () {},
                  underline: SizedBox(),
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  displayClearIcon: false,
                ),
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (context, index) =>
                      PurohitTile(documentSnapshot: snapshot.data!.docs[index]),
                  itemCount: snapshot.data!.size,
                )),
          );
        });
  }
}

class PurohitTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const PurohitTile({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
       
      },
      contentPadding: const EdgeInsets.all(10),
      leading: Image.network(Purohit(documentSnapshot).profileUrl),
      title: Row(
        children: [
          Text("${Purohit(documentSnapshot).name} "),
          Purohit(documentSnapshot).verification
              ? const Icon(
                  Icons.verified,
                  color: Colors.blue,
                )
              : SizedBox()
        ],
      ),
      subtitle: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black54, width: 2, style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("UID: ${Purohit(documentSnapshot).uid}"),
            Text("BIO: ${Purohit(documentSnapshot).bio}"),
            Text("AGE: ${Purohit(documentSnapshot).age}"),
            Text("NUMBER: ${Purohit(documentSnapshot).mobile}"),
            Text("EXPERTISE: ${Purohit(documentSnapshot).expertise}"),
            Text("EXPERIENCE: ${Purohit(documentSnapshot).experience}"),
            Text("LANGUAGE: ${Purohit(documentSnapshot).language}"),
            Text("STATE: ${Purohit(documentSnapshot).state}"),
            Text("CITY: ${Purohit(documentSnapshot).city}"),
            Text("QUALIFICATION: ${Purohit(documentSnapshot).qualification}"),
            Text("SWASTIK: ${Purohit(documentSnapshot).swastik}"),
            Text("TYPE: ${Purohit(documentSnapshot).type}"),
            Text("EMAIL: ${Purohit(documentSnapshot).email}"),
            Text(
                "JOINING DATE: ${DateTime.fromMicrosecondsSinceEpoch((Purohit(documentSnapshot).joining).microsecondsSinceEpoch)}"),
          ],
        ),
      ),
    );
  }
}
