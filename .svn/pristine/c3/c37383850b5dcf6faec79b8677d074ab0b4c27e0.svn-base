<?php
header("content-type:text/html;charset=utf-8");
$code=array(
    "username"=>array("A20","张三adfb12"),
    "pass"=>array("A10","asdf*#1"),
    "age"=>array("C","23"),
    "birthday"=>array("I","19900101"),
    "email"=>array("A50","zhangsan@163.com"));
var_dump(parkByArr($code)) ;
$stream=join("\0",parkByArr($code));
echo $stream,strlen($stream);
function parkByArr($arr)
{
    $atArr=array();
    foreach ($arr as $k=>$v)
    {
        $atArr[]=pack($v[0],$v[1]);
    }
    return $atArr;
}
function getAscill($str)
{
    $arr=str_split($str);
    foreach ($arr as $v)
    {
        echo $v,"=",ord($v),"\n";
    }
}
$code=array(
    "username"=>array("A20"),
    "pass"=>array("A10"),
    "age"=>array("C"),
    "birthday"=>array("I"),
    "email"=>array("A50"));

//$stream=file_get_contents("c:/1.txt");
var_dump(parkByArr1($stream,$code));
function parkByArr1($str,$code)
{
    $Arr=explode("\0",$str);
    $atArr=array();
    $i=0;
    foreach ($code as $k=>$v)
    {
        $atArr[$k]=unpack($v[0],$Arr[$i]);
        $i++;
    }
    return $atArr;
}