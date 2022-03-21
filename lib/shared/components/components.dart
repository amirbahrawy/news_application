import 'package:flutter/material.dart';
import 'package:news_application/modules/web_view.dart';

Widget buildArticleItem(article,context) {
  var image = article['urlToImage'] ??=
      'https://bitsofco.de/content/images/2018/12/Screenshot-2018-12-16-at-21.06.29.png';
  return GestureDetector(
    onTap: (){
      navigateTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: NetworkImage('$image'), fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget articleBuilder(list) {
  if (list.isNotEmpty) {
    return ListView.separated(
        itemBuilder: (context, index) => buildArticleItem(list[index],context),
        separatorBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              height: 1.0,
              color: Colors.grey,
            ),
        itemCount: list.length);
  } else {
    return const Center(child: CircularProgressIndicator());
  }
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onChange,
  GestureTapCallback? onTap,
  ValueChanged? onSubmit,
  required FormFieldValidator<String> validate,
  required String label,
  required IconData prefix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        border: const OutlineInputBorder(),
      ),
    );