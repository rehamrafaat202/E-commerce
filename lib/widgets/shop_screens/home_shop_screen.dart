import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit/cubit.dart';
import 'package:shop_app/cubit/shop_cubit/states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/shop_home_model.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:shop_app/widgets/shared/components/shared_component.dart';

class HomeShopScreen extends StatelessWidget {
  const HomeShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ChangeFavoritesSuccessShopState) {
        if (!state.model!.status!) {
          showToast(col: state.model!.message);
        }
      }
    }, builder: (context, state) {
      return ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoryModel != null
          ? productBuilder(ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoryModel!, context)
          : const Center(child: CircularProgressIndicator());
    });
  }

  Widget productBuilder(HomeModel model, CategoryModel cate, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners!
                  .map((e) => Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image(
                            image: CachedNetworkImageProvider('${e.image}'),
                            width: double.infinity,

                            //  NetworkImage('${e.image}'),
                            // width: double.infinity,
                          ),
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 0.9,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCat(cate.data!.data![index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 15,
                      ),
                      itemCount: cate.data!.data!.length,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Products',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1 / 1.530,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                crossAxisCount: 2,
                children: List.generate(
                    model.data!.products!.length,
                    (index) =>
                        gridViewBuild(model.data!.products![index], context)),
              ),
            ),
          ],
        ),
      );

  gridViewBuild(ProductsModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: CachedNetworkImageProvider(model.image!),

                  //  NetworkImage(model.image!),
                  width: double.infinity,
                  height: 180,
                ),
                if (model.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    color: Colors.red,
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 13.5),
                  ),
                  const SizedBox(
                    height: 3.5,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.old_price}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[700],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              ShopCubit.get(context).inFavourite[model.id]!
                                  ? defaultColor
                                  : Colors.grey[500],
                          child: const Icon(
                            Icons.favorite_border,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  buildCat(model) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: CachedNetworkImageProvider('${model.image}'),

            // NetworkImage('${model.image}'),
            width: 100,
            height: 100,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            color: Colors.black.withOpacity(.9),
            width: 100,
            height: 25,
            child: Text(
              '${model.name}',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
