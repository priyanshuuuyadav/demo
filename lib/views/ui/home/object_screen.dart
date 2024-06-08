import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:untitled1/controllers/getx_services.dart';
import 'package:untitled1/models/items_model.dart';
import 'package:get/get.dart';

class RazorPayScreen extends StatefulWidget {
  const RazorPayScreen({super.key});

  @override
  State<RazorPayScreen> createState() => _RazorPayScreenState();
}

class _RazorPayScreenState extends State<RazorPayScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController des = TextEditingController();

  final ItemsProvider controller = Get.put(ItemsProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Obx(() {
          return ListView.builder(
            itemBuilder: (context, index) {
              Item? data = controller.items[index];
              return ListTile(
                title: Text(data.name ?? ""),
                leading: CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person),
                ),
                subtitle: Text(data.description ?? ""),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return showUpdateDialog(
                                  item: data ?? Item(), context: context);
                            },
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.removeItem(data.id ?? "");
                          // setState(() {});
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: controller.items.length,
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return showAddDialog(context: context);
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  showUpdateDialog({required Item item, required BuildContext context}) {
    name.text = item.name!;
    des.text = item.description!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AlertDialog(
          content: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(
                      label: Text("Enter your name"),
                      icon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: des,
                    decoration: const InputDecoration(
                      label: Text("Enter your email"),
                      icon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      Item data = Item(
                        id: item.id ?? "",
                        name: name.text,
                        description: des.text,
                      );
                      await controller.updateItem(data);
                      print(data.id);
                      // setState(() {});
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  showAddDialog({required BuildContext context}) {
    name.clear();
    des.clear();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AlertDialog(
          content: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(
                      label: Text("Enter your name"),
                      icon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: des,
                    decoration: const InputDecoration(
                      label: Text("Enter your email"),
                      icon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      Item data = Item(
                          name: name.text,
                          description: des.text,
                          amount: 892,
                          currency: "INR");
                      await controller.createItem(data);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
