import 'package:flutter/material.dart';
// import ''


import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:house_rental/widgets/common_image.dart';const List<String> defaultImages=[
  'http://ww4.sinaimg.cn/large/006uZZy8jw1faic21363tj30ci08ct96.jpg',
  'http://ww4.sinaimg.cn/large/006uZZy8jw1faic259ohaj30ci08c74r.jpg',
  'http://ww4.sinaimg.cn/large/006uZZy8jw1faic2b16zuj30ci08cwf4.jpg'];

var imageWidth = 750.0;
var imageHeight = 424.0;

class CommonSwiper extends StatelessWidget {

  final List<String> images;

  const CommonSwiper({Key key, this.images=defaultImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //calculate the height of contain for swiper
    var height = MediaQuery.of(context).size.width/imageWidth*imageHeight;
    return new Container(
      height: height,
      child:  new Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context,int index){
          return CommonImage(images[index],fit: BoxFit.fill,);
        },
        itemCount: images.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
}