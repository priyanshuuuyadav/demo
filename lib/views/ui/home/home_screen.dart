import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/user_model.dart';
import '../../../controllers/http_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: HttpServices.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                User? data = snapshot.data?[index];
                return ListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                    child: CachedNetworkImage(
                      imageUrl: data?.image??"",
                      placeholder: (BuildContext context, String url) => const CircularProgressIndicator(),
                      errorWidget: (BuildContext context, String url, dynamic error) => const Icon(Icons.error),
                    ),
                  ),
                  title: Text(data?.firstName ?? ""),
                );
              },
              itemCount: snapshot.data?.length,
            );
          }
        });
  }
}
