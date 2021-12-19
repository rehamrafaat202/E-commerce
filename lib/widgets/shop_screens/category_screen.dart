import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/cubit.dart';
import 'package:shop_app/cubit/shop_cubit/states.dart';
import 'package:shop_app/models/category_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return buildCategoryItem(cubit.categoryModel!.data!.data![index]);
            },
            itemCount: cubit.categoryModel!.data!.data!.length,
          );
        },
        listener: (context, state) {});
  }

  Widget buildCategoryItem(DataItemModel model) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                // Image.network(
                //   model.image,
                //   fit: BoxFit.cover,
                //   height: 100.0,
                //   width: 80.0,
                // ),
                Image(
                  image: CachedNetworkImageProvider('${model.image}'),
                  // NetworkImage('${model.image}'),
                  fit: BoxFit.cover,
                  height: 100.0,
                  width: 80.0,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  model.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
            const Divider(
              height: 2,
            )
          ],
        ),
      );
}
