import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AgreementPage extends StatefulWidget {
  @override
  _AgreementPageState createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  // 获取项目中的html文件
  Future<String> _getFile() async {
    return await rootBundle.loadString('assets/user_agreement.html');
  }

  var kHtml = """
<table>
            <tr>
              <td width="50%" valign="top">
                本用户协议（下称“本协议”）由您与AIM海创小目标(下称“本平台”)的拥有及经营者AIM TECHNOLOGY GROUP LIMITED (下称“公司”)共同缔结，具有合同效力。 <br/>
                一、 协议的组成 <br/>
                1.  本协议内容包括协议正文及所有公司已经发布的或将来可能发布的各类规则（下称“有关规则”）。所有有关规则为本协议不可分割的 组成部分，与协议正文具有同等法律效力。除另行明确声明外，任何注册用户就本平台本平台提供的服务（下称“服务”）均受本协议约束。<br/>
                2. 您应当在使用服务之前认真阅读全部协议内容。如您对协议有任何疑问的，应向公司咨询。但无论您事实上是否在使用服务之前认真阅读了本协议内容，只要您使用服务，则本协议即对您产生约束，届时您不应以未阅读本协议的内容或者未获得公司对您问询的解答等理由，主张本协议无效，或要求撤销本协议。<br/>

                3. 您承诺接受并遵守本协议及所有有关规则的约定。如果您不同意本协议或任何有关规则的约定，您应立即停止注册/激活程序或停止使用服务。<br/>

                4. 公司有权根据需要不时地制订、修改本协议及/或任何有关规则，并以本平台公示的方式进行公告，不再单独通知您。变更后的协议和有关规则一经在本平台公布后，立即自动生效。如您不同意相关变更，应当立即停止使用服务。您继续使用服务的，即表示您接受经修订的协议和有关规则。<br/>
                二、 注册与账户 <br/>
                1.注册者资格<br/>
                您确认，在以公司允许的方式实际使用服务时，您应当是年满18岁并具备完全民事权利能力和完全民事行为能力的自然人、法人或其他组织。若您不具备前述主体资格，则您及您的监护人应承担因此而导致的一切后果，且公司有权注销或永久冻结您的账户，并向您索偿。<br/>

                2. 注册和账户<br/>
                a） 在您第一次进入本平台时按页面提示而阅读并同意本协议的条文后，或您以其他公司允许的方式实际使用服务时，您即受本协议及所有有关规则的约束。<br/>

                b） 除非有法律规定或司法裁定，或者符合公司公布的条件，否则您的登录名和密码不得以任何方式转让、赠与或继承，并且转让、赠与或继承需提供公司要求的合格的文件材料并根据公司制定的操作流程办理。<br/>

                3．用户信息<br/>
                a）在使用服务时，您应不时更新您的用户资料，以使之真实、及时、完整和准确。如有合理理由怀疑您提供的资料错误、不实、过时或不完整的，公司有权向您发出询问及/或要求改正的通知，并有权直接做出删除相应资料的处理，直至中止、终止对您提供部分或全部服务。公司对此不承担任何责任，您将承担因此产生的任何直接或间接损失及不利后果。<br/>

                b）您应当准确填写并及时更新您提供的电子邮件地址、联系电话、微信账号等联系方式信息，以便公司或其他用户与您进行有效联系，因通过这些联系方式无法与您取得联系，导致您在使用服务过程中产生任何损失或增加费用的，应由您完全独自承担。您了解并同意，您有义务保持你提供的联系方式的有效性，如有变更或需要并同意更新的，您应按公司的要求进行操作。<br/>

                4．账户安全<br/>
                您须自行负责对您的登录名和密码保密，且须对您在该登录名和密码下发生的所有活动（包括但不限于信息披露、发布信息、网上点击同意或提交任何有关规则的协议、网上续签协议或购买服务等）承担责任。您同意：<br/>

                (a) 如发现任何人未经授权使用您的登录名和密码，或发生违反您与公司的任何保密规定的任何其他情况，您会立即通知公司；<br/>

                (b) 确保您在每个上网时段结束时，以正确步骤离开本平台/服务。公司不能也不会对因您未能遵守本款规定而发生的任何损失负责。您理解公司对您的请求采取行动需要合理时间，公司对在采取行动前已经产生的后果（包括但不限于您的任何损失）不承担任何责任。<br/>

                5．登录名注销<br/>
                a）如您连续两年未登录过本平台，您的登录名可能被注销，不能再登录本平台，所有服务被终止。<br/>
                b）您同意，您如在本平台有欺诈、发布或销售假冒伪劣/侵权商品、侵犯他人合法权益或其他违反法律法规或的任何英国规则等行为，公司在本平台的范围内对此有权披露，您的登录名可能被注销，不能再登录本平台，所有服务同时终止。 <br/>


                三、 服务<br/>
                1. 通过公司及（或）其关联公司提供的服务和其它服务，您可在本平台上发布交易信息、查询商品和服务信息、达成交易意向并进行交易、、参加本平台组织的活动以及使用其它信息服务及技术服务。<br/>

                2．您在使用服务过程中，所产生的一切费用及应纳税赋均由您独自承担。<br/>

                3．您不可撤销地授权公司或公司授权的第三方或您与公司一致同意的第三方(任一，下称“裁判员”)根据本协议及有关规则的规定，处理您在本平台上发生的所有交易及可能产生的交易纠纷。您同意接受裁判员的决定并同意该决定将对您具有法律约束力。<br/>
                您理解并同意，裁判员并非司法机构，仅能以合理人的标准对证据进行鉴别。您同意裁判员的决定可能不符合您的期望并同意不向裁判员就其决定进行任何索偿。<br/>
                四、 服务使用规范<br/>
                1．在本平台上使用服务过程中，您承诺遵守以下约定：<br/>

                a)在使用服务过程中实施的所有行为均遵守所有国家的相关法律、法规的规定和要求，不违背社会公共利益或公共道德，不损害他人的合法权益，不违反本协议及有关规则。您如果违反前述承诺，产生任何法律后果的，您应以自己的名义独立承担所有的法律责任，并确保公司及其关联公司免于因此产生任何损失。<br/>

                b)在与其他会员交易过程中，遵守诚实信用原则，不采取不正当竞争行为，不扰乱网上交易的正常秩序，不从事与网上交易无关的行为。<br/>

                c) 不发布任何适用国家法律所禁止销售的或限制销售的商品或服务信息（除非取得合法且有效的政府许可），不发布涉嫌侵犯他人知识产权或其它合法权益的商品或服务信息，不发布违背社会公共利益或公共道德或公司认为不适合在本平台上销售的商品或服务信息，不发布其它涉嫌违法或违反本协议及有关规则的信息。<br/>

                d)不以虚构或歪曲事实的方式不当评价其他会员，不采取不正当方式制造或提高自身的信用度，不采取不正当方式制造或提高（降低）其他会员的信用度。<br/>

                e) 不对本平台上的任何数据作商业性利用，包括但不限于在未经公司事先书面同意的情况下，以复制、传播等任何方式使用本平台上展示的资料。<br/>

                f)不使用任何装置、软件或例行程序干预或试图干预本平台的正常运作或正在本平台上进行的任何交易、活动。您不得采取任何将导致庞大数据负载加诸本平台网络设备的行动。<br/>

                2．您了解并同意：<br/>
                a)公司有权对您是否违反上述承诺做出单方认定，并根据单方认定结果的适用有关规则予以处理或终止向您提供服务，且无须征得您的同意或提前通知予您。<br/>

                b）基于维护本平台交易秩序及交易安全的需要，公司有权在发生恶意购买等扰乱市场正常交易秩序的情形下，关闭相应交易订单及/或移除有关扰乱市场行为等操作。<br/>

                c) 经任何国家的行政或司法机关生效的法律文书确认您存在违法或侵权行为的，或者公司根据自身的判断，认为您的行为涉嫌违反本协议和/或有关规则的条款或涉嫌违反任何适用法律法规的规定的，则公司有权在本平台上公示您的该等涉嫌违法或违约行为及公司已对您采取的措施。<br/>

                d) 对于您在本平台上发布的涉嫌违法或涉嫌侵犯他人合法权利或违反本协议和/或有关规则的信息，公司有权不经通知您即予以删除，且按照有关规则的规定进行处罚。<br/>

                e) 对于您涉嫌违反本协议的行为对任何第三方造成损害的，您均应当承担所有的法律责任，并赔偿公司因您违反本协议而产生的一切损失。<br/>

                f)如您涉嫌违反适用法律、本协议或任何有关规则之规定，使公司遭受任何损失，或受到任何第三方的索赔，或受到任何政府部门的处罚，您应当赔偿公司因此造成的损失及（或）发生的费用，包括合理的律师费用。<br/>

                五、责任限制<br/>
                1．公司负责按"现状"和"可得到"的状态向您提供服务。但公司对服务不作任何明示或暗示的保证，包括但不限于服务的适用性、没有错误或疏漏、持续性、准确性、可靠性、适用于某一特定用途。同时，公司也不对服务所涉及的技术及信息的有效性、准确性、正确性、可靠性、质量、稳定、完整和及时性作出任何承诺和保证。<br/>

                2．您了解本平台上的信息系用户自行发布，且可能存在风险和瑕疵。本平台仅作为交易地点。本平台仅作为您获取物品或服务信息、物色交易对象、就物品和/或服务的交易进行协商及开展交易的场所，但公司无法控制交易所涉及的物品的质量、安全或合法性，商贸信息的真实性或准确性，以及交易各方履行其在贸易协议中各项义务的能力。您应自行谨慎判断确定相关物品及／或信息及／或交易的真实性、合法性和有效性，并自行承担因此产生的责任与损失。<br/>

                3．除非法律法规明确要求，否则公司没有义务对所有用户的信息数据、商品（服务）信息、交易行为以及与在本平台上进行任何交易有关的其它事项进行事先审查。但公司可在其认为合适时审查该等数据、信息、行为及/或事项。<br/>

                4．您了解并同意，公司不对因下述任一情况而导致您的任何损害赔偿承担责任，包括但不限于利润、商誉、使用、数据等方面的损失或其它无形损失的损害赔偿(无论公司是否已被告知该等损害赔偿的可能性)：<br/>

                a) 使用或未能使用服务；<br/>
                b) 第三方未经批准的使用您的账户或更改您的数据；<br/>
                c) 通过服务购买或获取任何商品、样品、数据、信息或进行交易等行为或替代行为产生的费用及损失;<br/>
                d) 您对服务的误解；<br/>
                e) 任何非因公司的原因而引起的与服务有关的其它损失。<br/>

                5．公司均不对由于本平台信息网络正常的设备维护，信息网络连接故障，电脑、通讯或其他系统的故障，不可抗力因素（包括电力故障，罢工，劳动争议，暴乱，起义，骚乱，火灾，洪水，风暴，爆炸，战争，政府行为，司法行政机关的命令等）或第三方的作为或不作为而造成的不能服务或延迟服务向你或任何其他人或实体承担责任。<br/>

                六、知识产权<br/>
                1． 本平台及本平台所使用、呈现的任何内容和材料（包括但不限于软件、技术、程序、网页、文字、图片、图像、商标、标识、音频、视频、图表、版面设计、电子文档等）均由本平台或其他权利人拥有其知识产权，包括但不限于著作权、专利权、商标权、商业秘密等。未经公司书面许可，您不得以任何方式擅自使用、修改、全部或部分复制、转载、引用、链接、抓取或以其他方式使用本平台的内容或材料，亦不得在任何国家和地区注册与上述内容或材料相关、相同或相似的商标、著作权、专利等知识产权。如有违反，您同意承担由此给本平台或其他权利人造成的一切损失。<br/>
                2． 您保证您拥有您以任何形式在本平台上发布的任何内容的所有知识产权并无任何负担。<br/>
                对于您提供的数据信息，您授予公司及其关联公司独家的、全球通用的、永久的、免费的许可使用权利(并有权在多个层面对该权利进行再授权)。 此外，公司及其关联公司有权(全部或部份地)使用、复制、修订、改写、发布、翻译、分发、执行和展示您的全部资料数据（包括但不限于注册资料、交易行为数据及全部展示于本平台的各类信息）或制作其衍生作品，并以现在已知或日后开发的任何形式、媒体或技术，将上述信息纳入其它作品内。<br/>
                就公司在本平台使用该内容而遭任何第三方就其任何权利被侵犯而作出的潜在和实际的法律索赔，您须向公司负责并赔偿公司因此类索赔而蒙受的损失。<br/>
                七、 协议终止<br/>
                1．您同意，公司有权自行全权决定以任何理由不经事先通知的中止、终止向您提供部分或全部服务，暂时冻结或永久冻结（注销）您的账户在本平台的权限，且无须为此向您或任何第三方承担任何责任。<br/>

                2．在不影响以上第一段为前提，在出现以下任何情况时，公司有权直接终止本协议，并有权永久冻结（注销）您的账户在本平台的权限:<br/>
                a) 公司终止向您提供服务后，您涉嫌再一次直接或间接或以他人名义注册使用服务的；<br/>

                b) 公司长期无法以您提供的联系方式与您联系；<br/>

                c) 您提供的用户信息中的主要内容不真实或不准确或不及时或不完整；<br/>

                d) 本协议（含有关规则）变更时，您明示并通知公司不愿接受经修改的协议或有关规则的。<br/>

                3．您的账户被终止或者账户在本平台的权限被永久冻结（注销）后，公司没有义务为您保留或向您披露您账户中的任何信息，也没有义务向您或第三方转发任何您未曾阅读或发送过的信息。<br/>

                4．您同意，您与公司的合同关系终止后，公司仍享有下列权利：<br/>

                a) 继续保存您的用户信息及您使用服务期间的所有交易信息；<br/>

                b) 您在使用服务期间存在违法行为或违反本协议和/或有关规则的行为的，公司仍可依据本协议向您主张权利。<br/>

                5．公司中止或终止向您提供服务后，对于您在服务中止或终止之前的交易行为依下列原则处理，您应独力处理并完全承担进行以下处理所产生的任何争议、损失或增加的任何费用，并应确保公司及其关联公司免于因此产生任何损失或承担任何费用:<br/>

                a) 您在服务中止或终止之前已经上传至本平台的商品信息而该商品尚未交易的，公司有权在中止或终止服务的同时删除此项商品的相关信息；<br/>

                b) 您在服务中止或终止之前已经与其他会员达成买卖合同，但合同尚未实际履行的，公司有权删除该买卖合同及其交易物品的相关信息；<br/>

                c) 您在服务中止或终止之前已经与其他会员达成买卖合同且已部分履行的，公司可以不删除该项交易，但公司有权在中止或终止服务的同时将相关情形通知您的交易对方。<br/>

                八、隐私权政策<br/>
                1．公司将在本平台公布并不时修订隐私权政策，隐私权政策构成本协议的有效组成部分。<br/>

                2．尽管以上第一段所术的，您了解并同意，公司有权应任何司法机关或政府部门的要求，向其提供您在本平台提供的用户信息和交易记录等信息。如您涉嫌侵犯他人知识产权等合法权益，则公司亦有权在初步判断涉嫌侵权行为存在的情况下，向权利人提供您的身份或其他信息。<br/>

                九、法律适用、争议处理<br/>
                本协议之效力、解释、变更、执行与争议解决均适用香港法律，任何香港的法律冲突规则或原则不适用于本协议。凡因本协议引起的或与之相关的争议、纠纷或索赔、包括违约、协议的效力和终止，均应根据提交仲裁通知时有效的《香港国际仲裁中心机构仲裁规则》，在香港仲裁解决。仲裁员人数人三（3）名，仲裁语言为英文。<br/>

                如中英文版本间存在任何歧义的，以英文版为准。<br/>

                </td>
                <td width="50%" valign="top">
                    This User Agreement (“this Agreement”) is made between you and AIM TECHNOLOGY GROUP LIMITED (the “Company”) the owner and operator of AIM海创小目标 (“this Platform”), and is binding. <br/>

                A. Agreement Composition<br/>
                1. This Agreement includes the main text and all rules already or will be published by the Company (hereinafter referred to as the “Relevant Rules”). All Relevant Rules are an integral part of this Agreement and have the same legal effect as the main text of this Agreement. Except otherwise expressly stated, any registered users who use the services provided by this Platform (hereinafter referred to as "Services") will be bound by this Agreement.<br/>
                2. You must carefully read the full content of this Agreement before using the Services. If you have any questions regarding the Agreement, you should consult the Company. However, regardless of whether you have actually read this Agreement carefully before using the Services, as long as you use the Services, you will be deemed to be bound by this Agreement. You may not use the reasons of not having read the Agreement or not having received answers to inquiries from the Company as a basis to invalidate or cancel the Agreement. <br/>
                3. You undertake to accept and comply with this Agreement and all Relevant Rules. If you do not agree with this Agreement or any of the Relevant Rules, you must immediately cease the registration / activation process or cease use of the Services.<br/>
                4. The Company has the right to amend this Agreement and/or any Relevant Rules at any time according to its needs. The amended and restated terms will be posted at the official website, and you will not be notified individually. The amended and restated Agreement and/or Relevant Rules will automatically take effect once it is posted at this Platform. If you do not agree with the changes, you must cease use of the Services immediately. Your continued use of the Services shall be deemed as your acceptance of the amended Agreement and/or Relevant Rules.<br/>
                B. Registration and Accounts<br/>
                1. Eligibility of the Registrant<br/>
                By using the Services in a manner allowed by the Company, you acknowledge that you are a natural person of at least 18 years of age who has full legal capacity, a legal person, or other organization. If you do not meet these eligibility requirements, you and your guardian must bear all resulting consequences, and the Company has the right to cancel or permanently freeze your account, and make claims against you. <br/>
                2. Registration and Account<br/>
                a) From your first use of this Platform, clicking on the page tips, and have read and agreed to the provisions of this Agreement, or when you use the Services via other methods allowed by other companies, you will be bound to the terms of this Agreement and all Relevant Rules. <br/>
                b) Unless there are legal provisions or judicial decisions, or in compliance with the Company’s conditions, your login name and password may not be transferred, gifted or inherited by any means. Transfers, gifts or inheritances may only be processed after providing necessary documents as requested by the Company, and will be handled in accordance with the Company’s operating procedures.<br/>
                3. User Information <br/>
                a) When using the Services, you should update your user information from time to time in order to ensure it remains true, updated, complete and accurate. If there are reasonable grounds to doubt that the information you provided is incorrect, false, outdated or incomplete, the Company has the right to make an inquiry and/or request changes, and also has the right to directly delete any corresponding information, until the suspension or termination of the Services (in full or in part) provided to you. The Company does not assume any responsibility in this respect, and you are liable for any resulting direct or indirect losses and adverse consequences. <br/>
                b) You must accurately fill in and update the contact information you provide to the Company such as email address, contact number, WeChat account name etc., in order for the Company or other users to effectively contact you. If you cannot be contacted by such contact information, you are solely responsible for any resulting losses or costs incurred while using the Services. You understand and agree that you must maintain the validity of the contact information you provide, and that any changes or updates must be carried out in accordance with the Company’s requirements. <br/>
                4. Account Safety<br/>
                You are solely responsible for the confidentiality of your login name and password, and all activities that occur under your login name and password (including, but not limited to, disclosure or release of information, clicking “agree” or “submit” to accept any Relevant Rules online, renewing agreements or purchasing services online etc.).  You agree:<br/>
                (a) to immediately inform the Company in the event that you discover any unauthorized usage of your login name and password or any other situation that violates the confidentiality provisions between you and the Company;  <br/>
                (b) to correctly exit / log-out of this Platform / Services at the end of each online session. The Company cannot and will not take responsibility for any losses or damages that are incurred as a result of your failure to comply with this provision. You understand that a reasonable amount of time is required for the Company to take action in response to your request, and the Company will not assume any responsibility for any consequences incurred before any action is taken by the Company (including, but not limited to any losses incurred by you). <br/>
                5. Cancellation of Login Name<br/>
                a) If you do not login to this Platform for two (2) consecutive years, your login name may be cancelled. If your login name is cancelled, you will no longer be able to use it to login to this Platform and all related Services will be terminated. <br/>
                b) Where you carry out any act of deceiving, posting or selling of fake / inferior / counterfeit goods, that infringes upon the legal rights of others, or that violates other laws and regulations or any Relevant Rules, the Company shall have the right to disclose such acts to this Platform. Your login name may be cancelled, and you will no longer be able to login to this Platform, and all Services will be terminated simultaneously. <br/>
                C. Services<br/>
                1. Through the Services and other services provided by the Company and (or) its affiliated companies, you may post trade information, inquire about product and services, agree to and complete transactions, participate in activities organized by this Platform, and use other information and technical services at this Platform. <br/>
                2. During your use of the Services, you are solely responsibility for any fees or taxes in relation thereto.  <br/>
                3. You irrevocably authorize the Company, a third party authorized by the Company, or a third party agreed between you and the Company (any of them, the “Referee”) to handle all actual and potential trade disputes that occur on this Platform in accordance with this Agreement and Relevant Rules. You agree to accept and be legally bound by the judgment of the Referee. <br/>
                You understand and agree that the Referees are non-judicial bodies and can only analyse any evidence by a reasonable man’s standard. You agree that the judgment may not meet your expectations, and that you will not make any claims against any Referees in relation to their judgments.<br/>
                D. Guidelines on the Use of Services<br/>
                1. During your use of the Services of this Platform, you undertake to comply with the following provisions: <br/>
                a) All acts conducting during use of the Services must comply with all national laws, regulations, rules and requirements, must not violate social public interest or public morals, must not adversely affect the legitimate rights and interests of others, and must not violate this Agreement and the Relevant Rules. If you violate any of the above undertakings, and the violation results in any legal consequences, you must individually bear all legal responsibilities, and ensure that the Company and its affiliated companies are exempt from any resulting losses.  <br/>
                b) To act in good faith, not to undertake any behaviour of unfair competition, not to disturb the normal order of online transactions, and not to engage in actions unrelated to online transactions during any transaction with other members.<br/>
                c) Not to post information of any goods or services prohibited or restricted to be sold by applicable laws (except with a valid and effective government permit); that may infringe upon the intellectual property rights or other legal rights and interests of others; that violates social public interests, public morals or that the Company considers unsuitable for sale on this Platform and not to post other information that may violate the law or this Agreement and Relevant Rules. <br/>
                d) Not to post inappropriate reviews of other members by making fictitious statements or distorting facts, not to use inappropriate means to make up or increase your own credit rating or make up or increase (lower) the credit rating of other members. <br/>
                e) Not to commercially use any data of this Platform, including but not limited to, to not copy or disseminate etc. and use information displayed on this Platform without the prior written consent of the Company. <br/>
                f) Not to use any devices, software or routine procedures to interfere or attempt to interfere with the normal operation of this Platform, or any transaction or activity carried out on this Platform. You must not carry out any action that will cause a large data load to the network system of this Platform.  <br/>
                2. You understand and agree that:<br/>
                a) The Company has the right to unilaterally decide whether you have violated any of the aforementioned undertakings, and to carry out any measures or terminate the Services provided to you in accordance with the Relevant Rules without your consent or prior notice to you.<br/>
                b) In order to maintain the order and safety of transactions at this Platform, where there are disruptions to the normal market transaction order, such as malicious purchases etc., the Company has the right to stop the relevant  orders and to take other measures to remove such disruptions. <br/>
                c) Where any legal document made effective by the administrative or judicial authorities of any country confirms that you have performed an illegal or infringing act, or where the Company unilaterally determines that your actions may violate the provisions of this Agreement and/or the Relevant Rules or may violate any applicable laws and regulations, the Company has the right to publicize such illegal acts or violations of contract and the measures that the Company has taken against you on this Platform. <br/>
                d) Regarding the information you have posted at this Platform that may have violated the law, infringed upon the legal rights and interests of others, or violated the provisions of this Agreement and/or the Relevant Rules, the Company has the right to delete such information without notifying you, and to carry out corresponding enforcement actions in accordance with the Relevant Rules. <br/>
                e) You must be responsible for all legal liabilities arising from the damages caused to any third party resulting from possible breach of this Agreement, and shall indemnity the Company any losses suffered as a result of your breach. <br/>
                f) If the Company suffers from any loss, is subject to any third party claims, or is penalized by any government department as a result of your violations of any applicable laws, this Agreement or any Relevant Rules, you must compensate the Company for the losses and/or costs incurred, including reasonable legal fees.  <br/>
                E. Limitation of Liability <br/>
                1. The Company will provide the Services to you on an “as is" and "as available" basis. However, the Company does not make any express or implied warranties in relation to the Services, including but not limited to, the suitability of the Services, the Services contain no errors or omissions, and durability, accuracy, reliability, and fitness for a particular purpose of the Services. The Company does not make any undertakings or guarantees regarding the validity, accuracy, correctness, reliability, quality, stability, completeness and timeliness of the technology and information related to the Services. <br/>
                2. You understand that information on this Platform is posted by users individually, and that such information may contain risks and flaws. Tmall Global is merely a platform where you can obtain goods or services information, find trade partners, carry out negotiations regarding goods and/or services transactions, and carry out transactions, and cannot control the quality, safety or legality of the goods and services involved in such transactions, the truthfulness and accuracy of the merchant’s information, or the capabilities of various transaction parties in fulfilling various obligations stipulated in transaction agreements. You should carefully consider the authenticity, legality and validity of relevant goods, services, information and/or transactions, and must bear sole responsibility for the resulting liabilities and losses. <br/>
                3. Unless expressly required by laws and regulations, otherwise the Company has no obligation to conduct an initial review of all user data, goods (services) information, trading behaviour and other matters related to any transactions in this Platform. However, the Company may review such data, information, behaviours or matters as it thinks appropriate. <br/>
                4. You understand and agree that the Company is not responsible for any compensation for damages incurred by you due to any of the following circumstances, including but not limited to, damages for the loss of profits, goodwill, use, data, etc. or other intangible losses (regardless of whether the Company was notified of the possibility of such damages):<br/>
                a) Your use or inability to use the Services;<br/>
                b) A third party used your account or changes your data without authorization;<br/>
                c) You incurred costs and losses through using the Services to purchase or obtain any goods, samples, data, information or trade etc. or any other behaviour;<br/>
                d) You misunderstood the Services;<br/>
                e) Any other losses relating to the Services arisen due to reasons not relating to the Company.<br/>
                5. The Company will not be liable to you or any individuals or entities for the inability to provide Services or the delay in providing Services caused by normal system maintenance of this Platform network, network connection failure, computer, communications or other system failure, force majeure (including power failure, strikes, labour disputes, riots, protests, disturbances, fire, floods, storms, explosions, wars, government behaviour, and judicial or executive orders, etc.), or any third party action or inaction.  <br/>
                F. Intellectual Property<br/>
                1. The intellectual property rights (including but not limited to copyrights, patents, trademarks and trade secrets, etc.) in relation to any content and materials used by or appeared on this Platform (including but not limited to software, technology, programs, web pages, text, pictures, images, trademarks, logos, audio, video, graphics, layouts and electronic documents, etc.) shall belong to the Company or the other owners of such rights. You shall not use, modify, partly or wholly reproduce, forward, quote, link, crawl or otherwise use the content or materials of this Platform in any way without the written permission of the Company, or in any countries and regions register such intellectual property rights as trademarks, copyrights and patents that are related, identical or similar to the above content or materials If you breach this provision, you agree to be liable for all losses suffered by this Platform or other rights holders as a result of your breach.<br/>
                2． You warrant that you own all the intellectual property rights free from any incumbrances of any content in whatever form you posted on this Platform.  <br/>
                You hereby grant the Company and its affiliated companies an exclusive, worldwide, perpetual, sub-licensable and free right to use any information or data you have provided. In addition, the Company and its affiliated companies have the right (fully or partially) to use, copy, revise, edit, publish, translate, disseminate, execute and display all of your information and data (including but not limited to, registration information, transaction data, and various types of information displayed on this Platform), or create derivative works, and use any form, media or technology currently known or developed in the future to incorporate such data or information in other works.  <br/>
                You shall be responsible for: all potential and actual legal claims relating to any breach of any rights of any third party in connection with the Company’s use of such content; and indemnify the Company its loss suffered as a result of such claims   <br/>
                G. Termination of Agreement <br/>
                1. You agree that the Company has the right and full discretion and for any reason without prior notice to suspend or terminate part of or all of the Services provided to you, to temporarily freeze or permanently freeze (cancel) your account’s rights and access on this Platform, and will not be liable to you or any third party. <br/>

                2. Without prejudice to paragraph 1 above, the Company has the right to terminate this Agreement and permanently freeze (cancel) your account’s rights and access on this Platform in any of the following circumstances:<br/>
                a) After the Company has terminated the provision of Services to you, you are suspected of registering and using the Services directly, indirectly or in the name of another person again;<br/>
                b) The Company was persistently unable to contact you through the contact information you provided;<br/>
                c) Core user information you have provided is untrue, inaccurate, outdated or incomplete; and<br/>
                d) This Agreement (including the Relevant Rules) has been revised, and you express and notify the Company that you are not willing to accept the revised Agreement or the Relevant Rules.<br/>
                3. The Company has no obligation to retain or disclose to you any information in your account, or forward to you or any third party any information you have not read or have been sent after your account has been terminated or your account’s rights and access to this Platform have been permanently frozen (cancelled)..<br/>

                4. You agree that after the contractual relationship between you and the Company has been terminated, the Company still enjoys the following rights:<br/>
                a) To save your user information and all transaction information generated during your use of the Services;<br/>

                b) If you have committed an illegal act or a breach of the Agreement and/or the Relevant Rules during your use of the Services, the Company may still make claims against you in accordance with this Agreement. <br/>
                5. After the Company suspends or terminates the Services provided to you, the transactions before the suspension or termination of Services must be processed in accordance with the following principles. You must independently handle any disputes, and fully bear any losses or any extra costs incurred that arise as a result of the following processes, and must ensure that the Company and its affiliated companies do not incur any resulting losses or bear any costs:<br/>
                a) Before the suspension and termination of the Services, you had already uploaded information of goods on this Platform but such goods are not part of any transaction, the Company has the right to delete the relevant information of these goods at the same time it suspends or terminates the Services;<br/>
                b) Before the suspension and termination of the Services, you had already entered into a sale and purchase contract with another member but the contract has not been performed yet, the Company has the right to delete such sales and purchase contract and the relevant information of the traded goods; <br/>
                c) Before the suspension and termination of the Services, you had already entered into a sale and purchase contract with another member and the contract has been partially performed, the Company may choose to not delete such transaction, but the Company has the right to notify the other party of the situation when it suspends or terminates the Services. <br/>
                H. Privacy Policy<br/>
                1.The Company will publish its privacy policy on this Platform, and may revise it from time to time. The privacy policy constitutes an effective part of this Agreement.<br/>
                2. Notwithstanding paragraph 1 above, you understand and agree that upon the orders or requests from any judicial or government authorities, the Company has the right to provide your user information, transaction records and other information you have provided to this Platform to such authorities. Where you are suspected of infringing upon another’s intellectual property rights or other legal rights and interests, if the Company’s initial judgment is that there exists an allegedly infringing act, it also has the right to provide the rightsholder with your identification or other information.<br/>
                I. Governing Law and Dispute Resolution<br/>
                 The effectiveness, interpretation, revisions, implementation and dispute resolution of this Agreement will be subject to the laws of the Hong Kong and any conflicting legal rules or principles of Hong Kong will not be applicable to this Agreement. All disputes, issues or claims arising from this Agreement, including breach of contract and the validity and termination of this Agreement, will be arbitrated in Hong Kong using the effective Hong Kong International Arbitration Centre (“HKIAC”) Administered Arbitration Rules valid at the time of submission of the arbitration notice. There will be three (3) arbitrators, and the arbitration proceedings will be English. <br/>

                IN CASE OF ANY INCONSISTENCY BETWEEN THE TWO LANGUAGE VERSIONS, THE ENGLISH VERSION SHALL PREVAIL.<br/>
                </td>
            </tr>
          </table>
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('用户协议')),
      body: SingleChildScrollView(
        child: HtmlWidget(
          kHtml,
          webView: true,
        ),
      ),
    );
  }
}
