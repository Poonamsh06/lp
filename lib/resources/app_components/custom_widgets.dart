import 'package:flutter/material.dart';
import '../../app/modules/content_entry/puja_section/controller/puja_add_controller.dart';
import '../app_exports.dart';

class GodCheckBox extends GetView {
  final String text;

  GodCheckBox({required this.text});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (HomeController controller) {
      return Obx(() => Column(
        children: [
          Text(text),
         const SizedBox(height: 5,),
          ListView.builder(
              itemCount: controller.god.value.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Checkbox(
                      value: controller.god.value[index]['value'],
                      onChanged: (value) {
                        controller.god.update((val) {
                          val![index]['value'] = value;
                        });
                      }),
                  title: Text(
                    "${controller.god.value[index]['type']}",
                  ),
                );
              }),
        ],
      ));
    });
  }
}
class BenefitCheckBox extends GetView {
  final String text;

  BenefitCheckBox({required this.text});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (HomeController controller) {
      return Obx(() => Column(
        children: [
           Text(text),
         const SizedBox(height: 5,),
          ListView.builder(
              itemCount: controller.benefit.value.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Checkbox(
                      value: controller.benefit.value[index]['value'],
                      onChanged: (value) {
                        controller.benefit.update((val) {
                          val![index]['value'] = value;
                        });
                      }),
                  title: Text(
                    "${controller.benefit.value[index]['type']}",
                  ),
                );
              }),
        ],
      ));
    });
  }
}


//______________________ CustomTextField_______________________//

 Widget addCustomTextField(TextEditingController controller, hintText) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.grey,

            hintText: hintText,

            //make hint text
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),

            //create lable
            labelText: hintText,
            //lable style
            labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }


//___________________ Red Button ___________//

  Container redButton(String text) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red, width: 2.0)),
      child: Text(text),
    );
  }
