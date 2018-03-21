<?php

function servername($int){
    switch ($int){
        case 10001:
            $msg='推锅';
            break;
        case 10002:
            $msg='推筒子';
            break;
        case 20001:
            $msg='四川麻将';
            break;
        case 20002:
            $msg='山西麻将';
            break;
        case 40001:
            $msg='塔罗之谜';
            break;
        case 40002:
            $msg='小厨娘';
            break;
    }
    return $msg;
}

function format3($int){
    return sprintf("%03d",$int);
}

function getFloat2($float){
    return round($float,1);
}

function getIDCardInfo($role){
    switch ($role){
        case 1:
            $msg='角色：管理员';
            break;
        case 10:
            $msg='角色：线路商';
            break;
        case 100:
            $msg='角色：商户';
            break;
        case 1000:
            $msg='角色：代理商';
            break;
        case 10000:
            $msg='角色：超管';
            break;
    }
    return $msg;
}

//推锅牌型判断万 10  筒20 条30 白板 47 红中45  北风44
function checkTuiguo($a,$m){
    $sum=$a+$m;
    $ji=$a*$m;
    if($sum==76 && $ji==1363){
        $a=$a==47?'白板':'九饼';
        $m=$m==29?'九饼':'白板';
        return '天九皇(16道):('.$a.'+'.$m.')';
    }
    if($sum==29 && $ji==208){
        $a=$a==13?'三万':'六万';
        $m=$m==16?'六万':'三万';
        return '皇上(15道):('.$a.'+'.$m.')';
    }
    if($sum==94 && $ji==2209){
        return '天对(14道):(白板+白板)';
    }
    if($sum==44 && $ji==484){
        return '地对(13道):(二饼+二饼)';
    }
    if($sum==56 && $ji==784){
        return '人对(12道):(八饼+八饼)';
    }
    if($sum==48 && $ji==576){
        return '鹅对(11道):(四饼+四饼)';
    }
    if($sum==52 && $ji==676){
        return '长对(10道):(六饼+六饼)';
    }
    if($sum==68 && $ji==1156){
        return '长对(10道):(四条+四条)';
    }
    if($sum==88 && $ji==1936){
        return '长对(10道):(北风+北风)';
    }
    if($sum==54 && $ji==729){
        return '短对(9道):(七饼+七饼)';
    }
    if($sum==72 && $ji==1296){
        return '短对(9道):(六条+六条)';
    }
    if($sum==42 && $ji==441){
        return '短对(9道):(一饼+一饼)';
    }
    if($sum==90 && $ji==2025){
        return '短对(9道):(红中+红中)';
    }
    if($sum==58 && $ji==841){
        return '杂对(8道):(九饼+九饼)';
    }
    if($sum==76 && $ji==1444){
        return '杂对(8道):(八条+八条)';
    }
    if($sum==74 && $ji==1369){
        return '杂对(8道):(七条+七条)';
    }
    if($sum==32 && $ji==256){
        return '杂对(8道):(六万+六万)';
    }
    if($sum==50 && $ji==625){
        return '杂对(8道):(五饼+五饼)';
    }
    if($sum==26 && $ji==169){
        return '杂对(8道):(三万+三万)';
    }
    if($sum==75 && $ji==1316){
        $a=$a==47?'白板':'八饼';
        $m=$m=='28'?'八饼':'白板';
        return '天杠(7道):('.$a.'+'.$m.')';
    }
    if($sum==50 && $ji==616){
        $a=$a==22?'二饼':'八饼';
        $m=$m==28?'八饼':'二饼';
       return '地杠(6道):('.$a.'+'.$m.')';
    }
    if($a<40 && $m<40){//不是特殊的牌型
        $num=$sum%10;
        return $num.'点:('.getPaixin($a).'+'.getPaixin($m).')';
    }
    if($a==44 && $m<40){//北风配其他的
        $num=$m%10;
        return $num.'点:('.'北风+'.getPaixin($m).')';
    }
    if($a<40 && $m==44){//北风配其他的
        $num=$a%10;
        return $num.'点:('.getPaixin($a).'+北风)';
    }
    if($a==45 && $m<40){//红中配其他的
        $num=$m%10;
        return $num.'点:('.'红中+'.getPaixin($m).')';
    }
    if($a<40 && $m==45){//红中配其他的
        $num=$a%10;
        return $num.'点:('.getPaixin($a).'+红中)';
    }
    if($a==47 && $m<40){//白板配其他的
        $num=$m%10;
        return $num.'点:('.'白板+'.getPaixin($m).')';
    }
    if($a<40 && $m==47){//白板配其他的
        $num=$a%10;
        return $num.'点:('.getPaixin($a).'+白板)';
    }
    if($a==47 && $m==45){//白板配红中
        return '2点:(白板+红中)';
    }
    if($a==45 && $m==47){//白板配红中
        return '2点:(红中+白板)';
    }
    if($a==47 && $m==44){//白板配北风
        return '2点:(白板+北风)';
    }
    if($a==44 && $m==47){//白板配北风
        return '2点:(北风+白板)';
    }
    if($a==44 && $m==45){//北风配红中
        return '0点:(北风+红中)';
    }
    if($a==45 && $m==44){//北风配红中
        return '0点:(红中+北风)';
    }
}
//输出牌型
function getPaixin($int){
    $array=array('一','二','三','四','五','六','七','八','九');
    if($int>10&&$int<20){
        $num=($int%10)-1;
        return $array[$num].'万';
    }
    if($int>20&&$int<30){
        $num=($int%10)-1;
        return $array[$num].'饼';
    }
    if($int>30&&$int<40){
        $num=($int%10)-1;
        return $array[$num].'条';
    }
    if($int==47){
        return '白板';
    }
}

//推筒子牌型判断
function checkTuitongzi($a,$m){
    if($a==$m){
        switch($a){
            case 47:
                return '对白板';
            break;
            case 29:
                return '对九筒';
            break;
            case 28:
                return '对八筒';
                break;
            case 27:
                return '对七筒';
                break;
            case 26:
                return '对六筒';
                break;
            case 25:
                return '对五筒';
                break;
            case 24:
                return '对四筒';
                break;
            case 23:
                return '对三筒';
                break;
            case 22:
                return '对二筒';
                break;
            case 21:
                return '对一筒';
                break;
        }
    }else{
        $sum=$a+$m;
        if($sum>58){
            if($a==47){
                $num=$m%10;
            }else{
                $num=$a%10;
            }
        }else{
            $num=$sum%10;
        }
        return $num.'点:('.getPaixin($a).'+'.getPaixin($m).'）';
    }

}


//剩余时间
function timecheck($int){
    if($int<=0){
        $int=0;
    }else{
        $hour=floor($int/3600);
        $minute=floor(($int-$hour*3600)/60);
        $sencond=$int-$hour*3600-$minute*60;
        $int=$hour.":".$minute.":".$sencond;
    }
    return $int;
}
//喝水不？
function isheshui($int){
    $id=intval($int);
    $arr=array(
        0=>'未知',
        1=>'喝水',
        2=>'不喝水'
    );
    return $arr[$id];
}
//去前缀
function delprefix($str){
    if(strstr($str,'_%_')){
        $false_name=explode('_%_',$str);
        if($false_name){
            return $false_name[1];
        }
    }
   return $str;
}

// 应用公共文件
function p($str) {
    echo '<pre>';
    print_r($str);
}
//中文字符串长度截取
function chsubstr($str,$start,$length){
	$len=mb_strlen($str,'utf-8');
	if($len>$length){
		$str=mb_substr($str,$start,$length,'utf-8').'...';
	}
	return $str;
}
//是否在线
function isnow($id){
	$id=intval($id);
	$arr=array(
		0=>'<span style="color:red;">未在线</span>',
		1=>'<span style="color:green;">在线</span>'
	);
	return $arr[$id];
}
//玩家类别
function iscate($id){
	$id=intval($id);
	$arr=array(
			0=>'无',
			1=>'普通玩家'
	);
	return $arr[$id];
}
//时间戳转化为小时
function datehour($id){
	$id=intval($id);
	$a=$id/3600;
	if($a<1){
		return '30min';
	}else{
		return $a.'小时';
	}
}
//是否禁止聊天
function ifChat($id){
	$id=intval($id);
	$arr=array(
			0=>'不禁止',
			1=>'旁观者',
			2=>'所有人'
	);
	return $arr[$id];
}
//什么群体
function istype($id){
	$id=intval($id);
	$arr=array(
			0=>'广场',
			1=>'推锅',
	);
	return $arr[$id];
}
//性别
function isSex($id){
	$id=intval($id);
	$arr=array(
			0=>'未设置',
			1=>'男',
            2=>'女'
	);
	return $arr[$id];
}
//角色
function isrule($id){
	$id=intval($id);
	$arr=array(
			0=>'未知',
			1=>'庄',
			2=>'闲',
			3=>'旁'
	);
	return $arr[$id];
}
//添加一个等级level
function nodeTree($arr, $id = 0, $level = 0) {
    static $array = array();
    foreach ($arr as $v) {
        if ($v['parentid'] == $id) {
            $v['level'] = $level;
            $array[] = $v;
            nodeTree($arr, $v['id'], $level + 1);
        }
    }
    return $array;
}

/**
 * 数组转树
 * @param type $list
 * @param type $root
 * @param type $pk
 * @param type $pid
 * @param type $child
 * @return type
 */
function list_to_tree($list, $root = 0, $pk = 'id', $pid = 'parentid', $child = '_child') {
    // 创建Tree
    $tree = array();
    if (is_array($list)) {
        // 创建基于主键的数组引用
        $refer = array();
        foreach ($list as $key => $data) {
            $refer[$data[$pk]] = &$list[$key];
        }
        foreach ($list as $key => $data) {
            // 判断是否存在parent
            $parentId = 0;
            if (isset($data[$pid])) {
                $parentId = $data[$pid];
            }
            if ((string) $root == $parentId) {
                $tree[] = &$list[$key];
            } else {
                if (isset($refer[$parentId])) {
                    $parent = &$refer[$parentId];
                    $parent[$child][] = &$list[$key];
                }
            }
        }
    }
    return $tree;
}

/**
 * 下拉选择框
 */
function select($array = array(), $id = 0, $str = '', $default_option = '') {
    $string = '<select ' . $str . '>';
    $default_selected = (empty($id) && $default_option) ? 'selected' : '';
    if ($default_option)
        $string .= "<option value='' $default_selected>$default_option</option>";
    if (!is_array($array) || count($array) == 0)
        return false;
    $ids = array();
    if (isset($id))
        $ids = explode(',', $id);
    foreach ($array as $key => $value) {
        $selected = in_array($key, $ids) ? 'selected' : '';
        $string .= '<option value="' . $key . '" ' . $selected . '>' . $value . '</option>';
    }
    $string .= '</select>';
    return $string;
}

/**
 * 复选框
 * 
 * @param $array 选项 二维数组
 * @param $id 默认选中值，多个用 '逗号'分割
 * @param $str 属性
 * @param $defaultvalue 是否增加默认值 默认值为 -99
 * @param $width 宽度
 */
function checkbox($array = array(), $id = '', $str = '', $defaultvalue = '', $width = 0, $field = '') {
    $string = '';
    $id = trim($id);
    if ($id != '')
        $id = strpos($id, ',') ? explode(',', $id) : array($id);
    if ($defaultvalue)
        $string .= '<input type="hidden" ' . $str . ' value="-99">';
    $i = 1;
    foreach ($array as $key => $value) {
        $key = trim($key);
        $checked = ($id && in_array($key, $id)) ? 'checked' : '';
        if ($width)
            $string .= '<label class="ib" style="width:' . $width . 'px">';
        $string .= '<input type="checkbox" ' . $str . ' id="' . $field . '_' . $i . '" ' . $checked . ' value="' . $key . '"> ' . $value;
        if ($width)
            $string .= '</label>';
        $i++;
    }
    return $string;
}

/**
 * 单选框
 * 
 * @param $array 选项 二维数组
 * @param $id 默认选中值
 * @param $str 属性
 */
function radio($array = array(), $id = 0, $str = '', $width = 0, $field = '') {
    $string = '';
    foreach ($array as $key => $value) {
        $checked = trim($id) == trim($key) ? 'checked' : '';
        if ($width)
            $string .= '<label class="ib" style="width:' . $width . 'px">';
        $string .= '<input type="radio" ' . $str . ' id="' . $field . '_' . $key . '" ' . $checked . ' value="' . $key . '"> ' . $value;
        if ($width)
            $string .= '</label>';
    }
    return $string;
}

/**
 * 字符串加密、解密函数
 *
 *
 * @param	string	$txt		字符串
 * @param	string	$operation	ENCODE为加密，DECODE为解密，可选参数，默认为ENCODE，
 * @param	string	$key		密钥：数字、字母、下划线
 * @param	string	$expiry		过期时间
 * @return	string
 */
function encry_code($string, $operation = 'ENCODE', $key = '', $expiry = 0) {
    $ckey_length = 4;
    $key = md5($key != '' ? $key : config('encry_key'));
    $keya = md5(substr($key, 0, 16));
    $keyb = md5(substr($key, 16, 16));
    $keyc = $ckey_length ? ($operation == 'DECODE' ? substr($string, 0, $ckey_length) : substr(md5(microtime()), -$ckey_length)) : '';

    $cryptkey = $keya . md5($keya . $keyc);
    $key_length = strlen($cryptkey);

    $string = $operation == 'DECODE' ? base64_decode(strtr(substr($string, $ckey_length), '-_', '+/')) : sprintf('%010d', $expiry ? $expiry + time() : 0) . substr(md5($string . $keyb), 0, 16) . $string;
    $string_length = strlen($string);

    $result = '';
    $box = range(0, 255);

    $rndkey = array();
    for ($i = 0; $i <= 255; $i++) {
        $rndkey[$i] = ord($cryptkey[$i % $key_length]);
    }

    for ($j = $i = 0; $i < 256; $i++) {
        $j = ($j + $box[$i] + $rndkey[$i]) % 256;
        $tmp = $box[$i];
        $box[$i] = $box[$j];
        $box[$j] = $tmp;
    }

    for ($a = $j = $i = 0; $i < $string_length; $i++) {
        $a = ($a + 1) % 256;
        $j = ($j + $box[$a]) % 256;
        $tmp = $box[$a];
        $box[$a] = $box[$j];
        $box[$j] = $tmp;
        $result .= chr(ord($string[$i]) ^ ($box[($box[$a] + $box[$j]) % 256]));
    }

    if ($operation == 'DECODE') {
        if ((substr($result, 0, 10) == 0 || substr($result, 0, 10) - time() > 0) && substr($result, 10, 16) == substr(md5(substr($result, 26) . $keyb), 0, 16)) {
            return substr($result, 26);
        } else {
            return '';
        }
    } else {
        return $keyc . rtrim(strtr(base64_encode($result), '+/', '-_'), '=');
    }
}
