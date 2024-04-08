import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoes_app/shared/appstyle.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile({super.key, required this.imageUrl, required this.name, required this.price});
  final String imageUrl;
  final String name;
  final String price;
  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> with TickerProviderStateMixin {
  
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration:const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageUrl,fit: BoxFit.fill,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: appstyleWithHt(16, Colors.black, FontWeight.w700,1),),
                Text(widget.price, style: appstyle(14, Colors.black, FontWeight.w500),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
