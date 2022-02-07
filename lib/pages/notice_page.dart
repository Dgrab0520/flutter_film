import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticePage extends StatefulWidget{
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage>{

  String? subject;

  @override
  void initState() {
    super.initState();
    subject = Get.parameters['sub'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text(subject!, style:
        TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            children: <Widget>[
              subject == '이용방법'?
              Image.asset('assets/images/way.png', width: Get.width, fit: BoxFit.fitWidth,)
              :
              subject == '개인정보이용방침'?
              Text('1. 공간인테리어(필름반장)에서는 이용자들의 개인정보보호를 중요시하며, "개인정보보호법", "정보통신망이용촉진 및 정보보호 등에 관합 법률" 등 개인정보와 관련된 법령상의 개인정보보호 규정을 준수하고 있습니다.'
                '\n이용자는 개인정보의 수집, 이용, 제공, 위탁 등과 관련한 아래 사항에 대하여 원하지 않는 경우 동의를 거부할 수 있습니다. 이용자가 동의 거부 시 서비스 일 부 또는 전부 이용할 수 없음을 알려드립니다.'
                '\n\n2. 회사는 이용자 사전 동의 없이는 이용자의 개인 정보를 공개하지 않으며, 당음과 같은 목적을 위하여 개인정보를 수집하고 있습니다.(회원가입, 견적서, 요청서, 정보 제공 및 프로필, sms 알람, 서비스 제공에 관한 계약 체결, 이행, 관리, 개선, 컨텐츠, 서비스 이용, 구매 및 요금결제, 등 회사에서 정한 이용 정보)'
                '\n\n3. 수집하는 개인정보\n(성명, 아이디, 비밀번호, 이메일 주소, 전화번호, 주민번호, 신용카드 정보'
                '\n\n4. 회사는 어떤 경우라도 입력하신 정보를 이용자들에게 회사 당 목적 외 다른 목적으로는 사용하지 않으며 외부로 유출하지 않습니다.'
                '\n\n5. 이용자의 개인정보는 목적이 달성되면 파기하는 것을 워칙으로 합니다.(이용약관해지시 분쟁, 법률분쟁해결 등 이유로 해지일로부터 6개월간 보관합니다.'
                '\n\n6. 이용자 개인정보 이용 전자결제서비스, 본인인증, 구매안전서비스,sms/LMS,이메일, 카카오톡 알림, 메시지 알림 그 외 회사의 위탁사에 제공됩니다.'
                '\n\n7. 현 개인정보처리방침의 내용은 정부의 정책 또는 보안기술상 변경에 따라 내용 추가 삭제 및 수정이 있을시에는 이메일, 문자 등을 통해 개별 고지할 것입니다.'
                '\n\n8. 본 방침은 2021년 9월 15일부터 시행합니다.',
                style: TextStyle(color: Colors.grey)

              ):
              Text('※회사의 의무\n\n1. 회사는 회원의 서비스 제공을 특별한 사정 없는한 서비스 이용할 수 있도록 합니다.\n2.회사는 개인정보를 위해 개인 정보 보호정책을 공시하고 준수합니다.\n회사는 회원들의 불만이나 의견이 정당하다고 판단되면 절차를 통해 즉각 처리 통보합니다.\n\n'
                '\n※회원의 의무\n\n1. 회원은 다음 각호의 행위를 해서는 안됩니다.\n- 회원가입 허위등록\n- 회사 등 제3자의 인격 또는 지적재산권을 침해하거나 업무방해\n- 다른 회원 ID 도용\n- 다른 회원에 대한 개인정보 불법수집, 회사규정위반, 폭력적, 음란설, 사실외곡, 거짓정보\n- 기타관련법령이나 회사에서 정한 규정에 위배되는 행위\n2. 회원은 그 귀책사유로 인하여 회사나 다른 회원이 입은 손해를 배상할 책임이 있습니다.\n3. 회원탈퇴: 회원이 이용계약을 해지하고자할 경우 본인이 메뉴 및 전화 등 이용하여 가입해지를 할 수 있습니다.'
                '\n\n\n※고객의 의무\n\n1. 고객은 제공받는 견적서와 내용 요청서를 작성하여 회사에서 제공하는 전문가 회원에게 전달하는 것에 동의합니다. \n2. 고객은 허위, 과장 내용으로 요청서를 발송함에 있어 용역을 제공 받지 못하거나 법적인 문제가 발생할 경우 이에 대한 책임은 고객에게 있습니다.'
                '\n\n\n※공간인테리어(필름반장) 캐시 사용방법\n\n- (필름반장)캐시는 회사가 제공하는 서비스를 사용할 때 지불수단으로 이용됩니다. \n-견적 발생 비용으로 회원은 고객이 작성한 요청서를 열람하고, 고객에게 견적서를 제공합니다. 고객의 요청서는 48시간 유효하며 그 기간내에 견적서를 발송할 수 있습니다. 전문가의 견적 발송은 해당하는 각각 금액은 유료이며 대금결제는 공간인테리어(필름반장) 캐시로 지급해야 합니다.\n- 전문가 회원은 충전캐시 구매 후 지급받은 날로부터 1년간 미상용된 공간인테리어(필름반장) 캐시에 대해 환불요청할 수 없으며, 1년 미사용 경과 모든 포인트는 소멸됩니다.\n- 회원정보 탈퇴 또는 회원등록정보 허위등록 판명시 강제탈퇴되며 귀책사유로 인한 환불 및 보상이 어려워집니다.\n- 회원 자동탈퇴로 인해 계약이 해지되는 경우 본인이 보유한 아이템은 자동 소멸되며 복구 또는 환불이 불가능 합니다.\n- 회사가 전문가회원에게 무상으로 제공되는 보너스 캐시는 금전으로 환불이 불가능 합니다.(보너스 캐시 유효기간 1년)'
                ,style: TextStyle(color: Colors.grey)
              ),
            ],
          ),
        ),
      )
    );
  }
}