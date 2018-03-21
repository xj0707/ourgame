<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/6/15
 * Time: 15:05
 */
//画圆饼图
require_once 'jpgraph-4.0.2/src/jpgraph.php';
require_once 'jpgraph-4.0.2/src/jpgraph_pie.php';
//模拟数据
$data=array(0=>3.5,1=>4.6,2=>9.1,3=>21.9,4=>42.3,5=>90.7,6=>183.5,7=>127.5,8=>61.4,9=>33.5,10=>11.5,11=>4.4);
//创建画布
$graph=new PieGraph(800,500);
//设置图像边界范围
$graph->img->SetMargin(30,30,80,30);
//设置标题
$graph->title->Set("PiePlot Test");
//得到饼图对象
$piePlot=new PiePlot($data);
//设置图例
$piePlot->SetLegends(array('1hehe',2,3,4,5,6,7,8,9,10,11,12));
//设置图例位置
$graph->legend->Pos(0.01,0.45,"left","top");
//添加到画布中
$graph->Add($piePlot);
//输出
$graph->Stroke();