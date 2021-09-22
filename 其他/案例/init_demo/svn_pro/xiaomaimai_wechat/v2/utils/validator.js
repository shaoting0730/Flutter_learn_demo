
const aCity = {
    11: "北京",
    12: "天津",
    13: "河北",
    14: "山西",
    15: "内蒙古",
    21: "辽宁",
    22: "吉林",
    23: "黑龙江",
    31: "上海",
    32: "江苏",
    33: "浙江",
    34: "安徽",
    35: "福建",
    36: "江西",
    37: "山东",
    41: "河南",
    42: "湖北",
    43: "湖南",
    44: "广东",
    45: "广西",
    46: "海南",
    50: "重庆",
    51: "四川",
    52: "贵州",
    53: "云南",
    54: "西藏",
    61: "陕西",
    62: "甘肃",
    63: "青海",
    64: "宁夏",
    65: "新疆",
    71: "台湾",
    81: "香港",
    82: "澳门",
    91: "国外"
};

var regexs = {
    // 匹配 max_length(12) => ["max_length",12]
    rule: /^(.+?)\((.+)\)$/,
    // 数字
    numericRegex: /^[0-9]+$/,
    /**
     * @descrition:邮箱规则
     * 1.邮箱以a-z、A-Z、0-9开头，最小长度为1.
     * 2.如果左侧部分包含-、_、.则这些特殊符号的前面必须包一位数字或字母。
     * 3.@符号是必填项
     * 4.右则部分可分为两部分，第一部分为邮件提供商域名地址，第二部分为域名后缀，现已知的最短为2位。最长的为6为。
     * 5.邮件提供商域可以包含特殊字符-、_、.
     */
    email: /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/,
    /**
     * [ip ipv4、ipv6]
     * "192.168.0.0"
     * "192.168.2.3.1.1"
     * "235.168.2.1"
     * "192.168.254.10"
     * "192.168.254.10.1.1"
     */
    ip: /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])((\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])){3}|(\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])){5})$/,
    /**
     * @descrition:判断输入的参数是否是个合格的固定电话号码。
     * 待验证的固定电话号码。
     * 国家代码(2到3位)-区号(2到3位)-电话号码(7到8位)-分机号(3位)
     **/
    fax: /^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/,
    /**
     *@descrition:手机号码段规则
     * 13段：130、131、132、133、134、135、136、137、138、139
     * 14段：145、147
     * 15段：150、151、152、153、155、156、157、158、159
     * 17段：170、176、177、178
     * 18段：180、181、182、183、184、185、186、187、188、189
     * 国际码 如：中国(+86)
     */
    phone: /^((\+?[0-9]{1,4})|(\(\+86\)))?(13[0-9]|14[57]|15[012356789]|17[0678]|18[0-9])\d{8}$/,
    /**
     * @descrition 匹配 URL
     */
    url: /[a-zA-z]+:\/\/[^\s]/,
    /**
     ** 匹配中文
     */
    chineseName:/^([\u4E00-\u9FA5]|[\uFE30-\uFFA0]|[.]){2,8}$/,
    /**
     *  匹配特定称谓
     */
    lady:/(小姐|女士|先生|老师|太太)/,
    nameLastWord:/(某)$/,
    /**
     *  匹配都为数字
     */
    notAllnumber:/[^0-9]/,
    englishName:/^([_a-zA-Z0-9]|[\s]){4,48}/,
    zhZip:/^(0[1-9]|[1-9][0-9])\d{4}$/,

};
// 检验都为数字
export function isAllNumber(value){
    return !regexs.notAllnumber.test(value);
}
// 验证合法邮箱
export function isEmail(value){
    return regexs.email.test(value);
}
// 验证合法 ip 地址
export function isIp(value) {
    return regexs.ip.test(value);
}
// 验证传真
export function isFax(value) {
    return regexs.fax.test(value);
}
// 验证座机
export function isTel(value) {
    return regexs.fax.test(value);
}
// 验证手机
export function isPhone(value) {
    return regexs.phone.test(value);
}
// 验证URL
export function isUrl(value) {
    return regexs.url.test(value);
}
// 是否为必填
export function required(value) {
    return value !== null && value !== "";
}
// 最大长度
export function maxLength(value, length) {
    return value.length <= parseInt(length, 10);
}
// 最小长度
export function minLength(value, length) {
    return value.length >= parseInt(length, 10);
}
// 检测中文
export function isChineseName(value){
    return regexs.chineseName.test(value);
}
// 检测英文
export function isEnglishName(value){
    return regexs.englishName.test(value);
}
// 检测是否含有小姐女士
export function hasLadyWords(value){
    return regexs.lady.test(value);
}

// 检测名称最后为某
export function hasNameLastWord(value){
    return regexs.nameLastWord.test(value);
}



// 检测是否为中国邮编
export function isChineseZip(value){
    return regexs.zhZip.test(value);
}

// 检测是否为身份证
export function isIDCard(value){
    var isValidat = true;
    if (!/^\d{17}(\d|x)$/i.test(value)) {
        isValidat = false;
    } else {
        var txtIDCARD = value.replace(/x$/i, 'a');
        if (aCity[parseInt(txtIDCARD.substr(0, 2))] == null) {
            isValidat = false;
        } else {
            var iSum = 0;
            for (var i = 17; i >= 0; i--) {
                iSum += (Math.pow(2, i) % 11) * parseInt(txtIDCARD.charAt(17 - i), 11)
            }
            if (iSum % 11 != 1) {
                isValidat = false;
            }
        }
    }
    return isValidat;
}


export default {
    isIDCard,
    isChineseName,
    isChineseZip,
    isEnglishName,
    hasLadyWords,
    hasNameLastWord,
    required,
    isUrl,
    isFax,
    isEmail,
    isIp,
    isPhone,
    isAllNumber,
    isTel,
    minLength,
    maxLength,
}
