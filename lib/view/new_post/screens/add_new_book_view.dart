import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dibook/state/utils/pick_images.dart';
import 'package:dibook/view/auth/components/name_field.dart';
import 'package:dibook/view/components/main_button.dart';
import 'package:dibook/view/new_post/components/category_field.dart';
import 'package:dibook/view/new_post/components/description_box.dart';
import 'package:dibook/view/new_post/components/missing_pages_field.dart';
import 'package:dibook/view/new_post/components/mrp_field.dart';
import 'package:dibook/view/new_post/components/star_rating.dart';
import 'package:dibook/view/new_post/components/stock_field.dart';
import 'package:dibook/view/new_post/strings.dart';
import 'package:dibook/view/components/custom_appbar.dart';
import 'package:dibook/view/components/heading.dart';
import 'package:flutter/material.dart';

class AddNewBookView extends StatefulWidget {
  AddNewBookView({super.key});

  @override
  State<AddNewBookView> createState() => _AddNewBookViewState();
}

class _AddNewBookViewState extends State<AddNewBookView> {
  final nameController = TextEditingController();

  final descController = TextEditingController();

  final categoryController = TextEditingController();

  final mrpController = TextEditingController();

  final stockController = TextEditingController();

  final missingPagesController = TextEditingController();

  double front = 0;

  double back = 0;

  double markings = 0;

  double binding = 0;

  double overall = 0;

  void setFront(double val) => front = val;

  void setBack(double val) => back = val;

  void setMarkings(double val) => markings = val;

  void setBinding(double val) => binding = val;

  void setOverall(double val) => overall = val;

  List<File> images = [];

  void getImages() async {
    final files = await pickImages();
    images = files.map((e) => File(e)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: ListView(
            children: [
              Heading(text: Strings.addANewBook),
              const SizedBox(height: 30),
              NameField(controller: nameController),
              const SizedBox(height: 10),
              DescriptionBox(controller: descController),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: CategoryField(controller: categoryController)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MrpField(controller: mrpController),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: StockField(controller: stockController),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                Strings.rateTheCond,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Strings.howManyPages),
                  SizedBox(
                      width: 50,
                      child: MissingPagesField(
                          controller: missingPagesController)),
                ],
              ),
              const SizedBox(height: 20),
              Text(Strings.rateFrontCover),
              const SizedBox(height: 10),
              StarRating(onUpdate: setFront),
              const SizedBox(height: 20),
              Text(Strings.rateBackCover),
              const SizedBox(height: 10),
              StarRating(onUpdate: setBack),
              const SizedBox(height: 20),
              Text(Strings.isTheText),
              const SizedBox(height: 10),
              StarRating(onUpdate: setMarkings),
              const SizedBox(height: 20),
              Text(Strings.rateTheBinding),
              const SizedBox(height: 10),
              StarRating(onUpdate: setBinding),
              const SizedBox(height: 20),
              Text(Strings.rateTheOverall),
              const SizedBox(height: 10),
              StarRating(onUpdate: setOverall),
              const SizedBox(height: 40),
              Text(
                Strings.selectTheFollowing,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              const SizedBox(height: 10),
              Text("\u2022 ${Strings.frontCover}"),
              Text("\u2022 ${Strings.backCover}"),
              Text("\u2022 ${Strings.index}"),
              Text("\u2022 ${Strings.pageWithMRP}"),
              Text("\u2022 ${Strings.moreImages}"),
              const SizedBox(height: 20),
              if (images.isEmpty)
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.image,
                          color: Colors.grey,
                          size: 50,
                        ),
                        onPressed: getImages,
                      ),
                      Text(Strings.clickToSelect)
                    ],
                  ),
                ),
              if (images.isNotEmpty)
                CarouselSlider.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index, realIndex) {
                    return Image.file(images[index]);
                  },
                  options: CarouselOptions(),
                ),
              const SizedBox(height: 40),
              MainButton(text: Strings.confirm, onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
