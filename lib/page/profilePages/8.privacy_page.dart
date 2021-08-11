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
      "为了更好的保护您的个人信息，建议您仔细阅读更新后的《哔哩哔哩隐私政策》，尤其是以黑色加粗的条款。如您对本隐私政策条款有任何异议或疑问，您可通过本《哔哩哔哩隐私政策》第十条“联系我们”中公布的联系方式与我们沟通。\n特别提醒：由于哔哩哔哩的产品和服务较多，为您提供的产品和服务内容也有所不同，本隐私政策为哔哩哔哩统一适用的一般性隐私政策条款。\n针对哔哩哔哩的某些特定产品/服务，哔哩哔哩还将制定特定隐私政策，您应在充分阅读并同意特定隐私政策的全部内容后再使用该特定产品/服务。\n2.请您在使用哔哩哔哩各项产品和/或服务前，仔细阅读并充分理解本隐私政策的全部内容。一旦您使用或继续使用哔哩哔哩的产品/服务，即表示您同意我们按照本隐私政策使用和处理您的相关信息。\n3.我们可能会不时依据法律法规或业务调整对本隐私政策进行修订。当本隐私政策发生变更后，我们会在版本更新后通过在显著位置提示或推送通知、消息等形式向您展示变更后的内容。\n4.您需理解，只有在您确认并同意变更后的《哔哩哔哩隐私政策》，我们才会依据变更后的隐私政策收集、使用、处理和存储您的个人信息；您有权拒绝同意变更后的隐私政策，但请您知悉，一旦您拒绝同意变更后的隐私政策，可能导致您不能或不能继续完整使用哔哩哔哩的相关服务和功能，或者无法达到我们拟达到的服务效果。";
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
