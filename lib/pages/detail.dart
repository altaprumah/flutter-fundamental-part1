import 'package:flutter/material.dart';
import 'package:pml/api/http_helper.dart';

class DetailPizza extends StatelessWidget {
  final String id;

  const DetailPizza({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pizza - Farrel'),
      ),
      body: Center(
        child: FutureBuilder(
          future: HttpHelper().getPizzaByID(id),
          builder: (context, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (data.connectionState == ConnectionState.done &&
                data.data != null) {
              return ListTile(
                title: Text(
                  '${data.data?.pizzaName ?? ''} (${data.data?.category ?? ''})',
                ),
                subtitle: Text(
                  '${data.data?.description ?? ''} - € ${data.data?.price ?? 0}',
                ),
              );
            }

            return Text("Error ${data.error}");
          },
        ),
      ),
    );
  }
}