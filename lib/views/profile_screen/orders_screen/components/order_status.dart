import 'package:srss_app/consts/consts.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    )
        .box
        .border(color: darkFontGrey)
        .roundedSM
        .padding(const EdgeInsets.all(2))
        .make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "$title".text.color(color).make(),
          showDone
              ? Icon(
                  Icons.done,
                  color: color,
                )
              : Container()
        ],
      ),
    ),
  );
}
