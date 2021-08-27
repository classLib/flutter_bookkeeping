import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// FileName: 8.privacy_page
/// Author: hjy
/// Date: 2021/8/10 22:23
/// Description:隐私政策

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key key}) : super(key: key);

  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  //
  var str =
      "随手记账严格遵守法律法规，遵循以下隐私保护原则，为您提供更加安全、可靠的服务：\n1、安全可靠：\n我们竭尽全力通过合理有效的信息安全技术及管理流程，防止您的信息泄露、损毁、丢失。\n2、自主选择：\n我们为您提供便利的信息管理选项，以便您做出合适的选择，管理您的 个人信息 。\n3、保护通信秘密：\n我们严格遵照法律法规，保护您的通信秘密，为您提供安全的通信服务。\n4、合理必要：\n为了向您和其他用户提供更好的服务，我们仅收集必要的信息。\n5、清晰透明：\n我们努力使用简明易懂的表述，向您介绍隐私政策，以便您清晰地了解我们的信息处理方式。\n6、将隐私保护融入产品设计：\n我们在产品和服务研发、运营的各个环节，融入隐私保护的理念。.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("隐私政策"),
      ),
      body: Column(
        children: [
          Text(
            "隐私政策",
            style: TextStyle(fontSize: 20),
          ),
          Text(str)
        ],
      ),
    );
  }
}
