import 'package:flutter/material.dart';

class Product{
  final String title; // 商品名
  final String desc;  // 商品描述
  Product(this.title,this.desc);
}

void main(){
  runApp(MaterialApp(
    title: '传参',
    home: ProductList(
      products:List.generate(20, 
        (i) => Product('商品 $i','商品简介:$i')
      )
    ),
  ));
}

class ProductList extends StatelessWidget {
final List<Product> products;
ProductList({Key key,@required this.products}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品列表')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context,index){
          return ListTile(
            title: Text(products[index].title),
            onTap: (){
              Navigator.push(context, 
               MaterialPageRoute(
                 builder: (context) => ProductDetails(product:products[index])
               )
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetails extends StatelessWidget{
final Product product;
ProductDetails({Key key,@required this.product}):super(key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('${product.title}')),
      body: Center(child: 
        RaisedButton(
          child: Text('${product.desc}'),
          onPressed: (){
            Navigator.pop(context,'新');
          },
        )
      ),
    );
  }
}