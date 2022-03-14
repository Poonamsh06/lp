import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  final List<dynamic> galaryImages;
  final AsyncSnapshot<DocumentSnapshot>? query;
  const Gallery({required this.galaryImages, this.query});
  @override
  Widget build(BuildContext context) {
    String? link1 = galaryImages[0];
    String? link2 = galaryImages[1];
    String? link3 = galaryImages[2];
    String? link4 = galaryImages[3];
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 8.0,
            children: [
              gallery(link1),
              gallery(link2),
              gallery(link3),
              gallery(link4),
            ],
            shrinkWrap: true,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.doc('punditUsers/${query!.data!['pandit_uid']}/pandit_credentials/pandit_uidai_details').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.exists == false) {
                  return Center(
                      child: Container(
                    height: 10,
                    width: 10,
                    child: Center(
                      child: Text('Not Given adhar'),
                    ),
                  ));
                }
                String? link1 = snapshot.data!['pandit_uidai_back_pic'];
                String? link2 = snapshot.data!['pandit_uidai_front_pic'];

                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  children: [
                    gallery(link1),
                    gallery(link2),
                  ],
                  shrinkWrap: true,
                );
              }),
        ],
      ),
    );
  }

  Widget gallery(String? link) {
    return Container(
      height: 200,
      width: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: NetworkImage('$link'), fit: BoxFit.fill)),
    );
  }
}
