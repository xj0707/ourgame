<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/6/15
 * Time: 15:09
 */

//画3d圆饼图d
require_once 'jpgraph-4.0.2/src/jpgraph.php';
require_once 'jpgraph-4.0.2/src/jpgraph_pie.php';
require_once 'jpgraph-4.0.2/src/jpgraph_pie3d.php';
$data=array(0=>3.5,1=>4.6,2=>9.1,3=>21.9,4=>42.3,5=>90.7,6=>183.5,7=>127.5,8=>61.4,9=>33.5,10=>11.5,11=>4.4);
//创建画布
$graph=new pieGraph(500,500);
//设置图像边界范围
$graph->img->SetMargin(30,30,80,30);
//设置标题
$graph->title->Set("piePlot3d Test");
//得到3D饼图对象
$piePlot3d=new piePlot3d($data);
//设置图例
$piePlot3d->SetLegends(array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"));
//设置图例位置
$graph->legend->Pos(0.1,0.15,"left","center");
//将绘制好的3D饼图加入到画布中
$graph->Add($piePlot3d);
//输出
$graph->Stroke();