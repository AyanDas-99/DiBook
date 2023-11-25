import 'package:dibook/view/constants/strings.dart';
import 'package:dibook/view/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: Strings.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          child: Container(
            width: 150,
            margin: const EdgeInsets.all(10),
            color: Colors.white,
            child: Center(
                child: Text(
              Strings.categories[index],
              style: TextStyle(
                fontFamily: "JuliusSansOne",
                color: ThemeConstants.darkGreen,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            )),
          ),
        ),
      ),
    );
  }
}
