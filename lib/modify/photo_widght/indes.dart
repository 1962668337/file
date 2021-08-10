void main() {
  var list = ['aa', 'bb', 'cc'];

  print(list.isEmpty); //判断是否为空

  print(list.isNotEmpty); //判断是否不为空

  list.add('dd'); //增加一条数据

  list.addAll(['ee', 'ff']); //数组的拼接

  print(list.indexOf('aa')); //查询值得到索引值

  list.remove('aa'); //通过值删除

  list.removeAt(0); //通过索引删除

  list.fillRange(1, 2, 'DD'); //修改值，1--2索引里面的值，'DD'更改后的值

  var str = list.join(','); //list转换成字符串，以逗号进行分隔
  print(str);
  print(str.split(',')); //字符串转换成数组，以逗号进行分割
  print(list);
}
