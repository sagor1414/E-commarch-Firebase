import 'package:srss_app/consts/consts.dart';
import 'package:srss_app/controllers/product_controller.dart';
import 'package:srss_app/views/Catagory_screen/category_details.dart';
import 'package:srss_app/widzet_common/bg_widget.dart';

class CatagortScreen extends StatelessWidget {
  const CatagortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 200),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      categoryimage[index],
                      height: 120,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    10.heightBox,
                    categorylist[index]
                        .text
                        .color(darkFontGrey)
                        .align(TextAlign.center)
                        .make()
                  ],
                )
                    .box
                    .white
                    .roundedSM
                    .clip(Clip.antiAlias)
                    .outerShadow
                    .make()
                    .onTap(() {
                  controller.getSubCategories(categorylist[index]);
                  Get.to(() => CategoryDetails(title: categorylist[index]));
                });
              })),
    ));
  }
}
