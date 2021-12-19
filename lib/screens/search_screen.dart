import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/search_cubit/cubit.dart';
import 'package:shop_app/cubit/search_cubit/states.dart';
import 'package:shop_app/cubit/shop_cubit/cubit.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:shop_app/widgets/shared/components/shared_component.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var forKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: forKey,
              child: Padding(
                padding: const EdgeInsets.all(10.4),
                child: Column(
                  children: [
                    defaultFormText(
                      label: 'Search',
                      type: TextInputType.text,
                      // onChange: (s){},
                      // onTapUp: (s){},
                      control: searchController,
                      // controller: searchController,
                      onSubmit: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      prefix: Icons.search,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Search must not be empty';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    const SizedBox(
                      height: 15,
                    ),
                    if (state is SearchSuccessgState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListItem(
                              SearchCubit.get(context)
                                  .searchModels!
                                  .data!
                                  .data[index],
                              context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) => Container(
                            height: 1,
                            width: 1,
                            color: Colors.grey,
                          ),
                          itemCount: SearchCubit.get(context)
                              .searchModels!
                              .data!
                              .data
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildListItem(models, context, {bool isOldPrice = true}) => Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 150,
                child: Stack(
                  children: [
                    Image(
                      image: NetworkImage('${models.image}'),
                      width: 120,
                      height: 120,
                    ),
                    if (models.discount != 0 && isOldPrice)
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
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 215,
                      child: Text(
                        '${models.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          height: 1.35,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 220,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${models.price}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: defaultColor,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (models.discount != 0 && isOldPrice)
                            Text(
                              '${models.oldPrice}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          //SizedBox(width: 90,),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavorites(models.id!);
                            },
                            icon: CircleAvatar(
                              child: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 18,
                              ),
                              backgroundColor:
                                  ShopCubit.get(context).inFavourite[models.id]!
                                      ? defaultColor
                                      : Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
