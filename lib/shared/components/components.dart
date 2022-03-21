import 'package:flutter/material.dart';

Widget buildArticleItem(article) {
  var image=article['urlToImage'];
  if(image==null)
    image='https://bitsofco.de/content/images/2018/12/Screenshot-2018-12-16-at-21.06.29.png';
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: NetworkImage('$image'),
                  fit: BoxFit.cover)),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child:  Container(
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
  );
}
Widget articleBuilder(list){
  if (list.isNotEmpty) {
    return  ListView.separated(
        itemBuilder: (context, index) => buildArticleItem(list[index]),
        separatorBuilder: (context, index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          height: 1.0,
          color: Colors.grey,
        ),
        itemCount: list.length);
  } else {
    return const Center(child: CircularProgressIndicator());}
}
