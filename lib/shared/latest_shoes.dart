import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoes_app/model/Sneaker_model.dart';
import 'package:shoes_app/shared/stagger_tile.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
        future: _male,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final male = snapshot.data;
            /* GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 16,
                ),
                itemCount: male!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final shoe = snapshot.data![index];
                  return StaggerTile(
                      imageUrl: shoe.imageUrl[1],
                      name: shoe.name,
                      price: "\$${shoe.price}");
                });*/

           return StaggeredGridView.countBuilder(
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 16,
                itemCount: male!.length,
                scrollDirection: Axis.vertical,
                staggeredTileBuilder: (index) =>
                    StaggeredTile.extent(
                        (index % 2 == 0) ? 1 : 1,
                        (index % 4 == 1 || index % 4 == 3)
                            ? MediaQuery.of(context).size.height *
                            0.35
                            : MediaQuery.of(context).size.height *
                            0.3),
                itemBuilder: (context, index) {
                  final shoe = snapshot.data![index];
                  return StaggerTile(
                      imageUrl: shoe.imageUrl[1],
                      name: shoe.name,
                      price: "\$${shoe.price}");
                });
          }
        });
  }
}
