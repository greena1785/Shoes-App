import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/controllers/product_provider.dart';
import 'package:shoes_app/model/Sneaker_model.dart';
import 'package:shoes_app/shared/appstyle.dart';
import 'package:shoes_app/shared/new_shoes.dart';
import 'package:shoes_app/shared/product_cart.dart';
import 'package:shoes_app/ui/product_by_cart.dart';
import 'package:shoes_app/ui/product_page.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key, required Future<List<Sneakers>> male, required this.tabIndex,}) :_male= male;

  final Future<List<Sneakers>> _male;
  final int tabIndex;
  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductProvider>(context);
    return  Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height*0.400,
            child: FutureBuilder<List<Sneakers>>(
                future: _male,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else {
                    final male = snapshot.data;
                    return ListView.builder(
                        itemCount: male!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final shoe = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              productNotifier.shoesSizes = shoe.sizes;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                          id: shoe.id,
                                          category: shoe.category)));
                            },
                            child: ProductCard(
                              price: "\$${shoe.price}",
                              category: shoe.category,
                              id: shoe.id,
                              name: shoe.name,
                              image: shoe.imageUrl[0],
                            ),
                          );
                        });
                  }
                })),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12,20,12,20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Latest Shoes',style:  appstyle(20, Colors.black, FontWeight.bold),),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductByCart(
                              tabIndex: tabIndex,
                            )
                        )
                      );
                    },
                    child: Row(
                      children: [
                        Text('Show All', style: appstyle(20, Colors.black, FontWeight.w500),),
                        Icon(AntDesign.caretright, size: 20,)
                      ],
                    ),
                  )
                ],
              ),
            )

          ],
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height*0.13,
            child: FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return CircularProgressIndicator();
                }else if(snapshot.hasError){
                  return Text('Error ${snapshot.error}');
                }else{
                  final male = snapshot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        final shoe = snapshot.data![index];

                        return  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NewShoes(
                            imageUrl: shoe.imageUrl[1],
                          ),
                        );
                      }
                  );
                }
              },
            )
        )
      ],
    );
  }
}
