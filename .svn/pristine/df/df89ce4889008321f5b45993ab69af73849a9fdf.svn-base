<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/6/15
 * Time: 10:48
 */
//jPGraph绘制图形、折线、饼状，圆形
//下载地址http://jpgraph.net/
//画xy坐标折线图
require_once 'jpgraph-4.0.2/src/jpgraph.php';
require_once 'jpgraph-4.0.2/src/jpgraph_line.php';
//1.创建画布
$graph=new Graph(600,400);
//设置横 纵坐标刻度样式
//lin直线  text文本  int 整数  log对数
//ex： 设置横坐标为文本纵坐标为整数 就可以设置成textint
$aAxisType='textint';
$graph->SetScale($aAxisType);
//绘制统计图标题
$graph->title->SetFont(FF_CHINESE);
$graph->title->Set('推锅统计图');
//获得数据（）
//注：建名从0开始
$data=array(0=>20,1=>25,2=>43,3=>25,4=>45,5=>43,6=>38,7=>28,8=>65,9=>34,10=>38,11=>40);
//绘制线图,得到对象
$linePlot=new LinePlot($data);
//设置图例
$linePlot->SetLegend('推锅');
//将统计图添加到画布上
$graph->Add($linePlot);
//设置统计图的颜色，一定要在添加画布之后设置
$linePlot->SetColor('red');
//输出到浏览器上
$graph->Stroke();
//保存在本地
//$graph->Stroke(./test.png);

//支持中文需要配置如下：
//支持标题中文
//打开src 下面的 jpgraph_ttf.inc.php
//找到 define('CHINESE_TTF_FONT','bkai00mp.ttf');---》修改成 msyhbd.ttf
//$graph->title->SetFont(FF_CHINES);
//支持图例中文
//打开src 下面的jpgraph_legend.inc.php
//修改这个 public $font_family=FF_CHINESE,$font_style=FS_NORMAL,$font_size=8;

