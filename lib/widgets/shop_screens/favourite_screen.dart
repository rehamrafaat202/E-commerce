import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/cubit.dart';
import 'package:shop_app/cubit/shop_cubit/states.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/styles/colors.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          var shopCubit = ShopCubit.get(context);
          return ConditionalBuilder(
            condition: state is! GetFavoritesLoadingShopState,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildFav(
                      shopCubit.favoriteModel!.data!.data![index].product,
                      context);
                },
                itemCount: shopCubit.favoriteModel!.data!.data!.length),
          );
        },
        listener: (context, state) {});
  }

  Widget buildFav(Product? p, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 350,
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200.0,
                  // color: Colors.blue,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: CachedNetworkImageProvider('${p!.image}'),
                        //  NetworkImage('${p!.image}'),
                        // "https://student.valuxapps.com/storage/uploads/products/1615450256e0bZk.item_XXL_7582156_7501823.jpeg",
                        width: double.infinity,
                        // height: 200.0,
                        fit: BoxFit.cover,
                      ),
                      if (p.discount != 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          color: Colors.red,
                          child: const Text(
                            "DISCOUNT",
                            style: TextStyle(
                                color: defaultBackGroundColor, fontSize: 15),
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  '${p.name}',
                  style: const TextStyle(fontSize: 17.0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(p.price.toString(),
                        style: const TextStyle(
                            fontSize: 20.0, color: defaultColor)),
                    const SizedBox(
                      width: 15,
                    ),
                    if (p.discount != 0)
                      Text(p.oldPrice.toString(),
                          style: const TextStyle(
                              fontSize: 17.0,
                              color: greyColor,
                              decoration: TextDecoration.lineThrough)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(p.id);
                        },
                        icon: CircleAvatar(
                            radius: 25.0,
                            backgroundColor:
                                ShopCubit.get(context).inFavourite[p.id]!
                                    ? defaultColor
                                    : Colors.grey,
                            child: const Icon(
                              Icons.favorite_border_outlined,
                              size: 18.0,
                              color: Colors.white,
                            ))),
                  ],
                )
                // const Divider(
                //   height: 2,
                // ),
              ],
            ),
          ),
        ),
      );
}
