<?php

/**
 *  布居
 * @file   menu.php  
 * @date   2016-9-2 16:18:45 
 * @author Zhenxun Du<5552123@qq.com>  
 * @version    SVN:$Id:$ 
 */

namespace application\admin\widget;

class Menu {

    public $user_id;

    public function __construct() {
        if (!session('qipai_id')) {
            return false;
        }
        $this->user_id = session('qipai_id');
    }

    public function index() {
        $menu = model('Menu')->getMyMenu($this->user_id, 1);

        $menuTree = list_to_tree($menu);
        $html = '<ul class="nav nav-list">';
        $html .=$this->menu_tree($menuTree);
        $html .= "
                </ul>";
        //echo $html;exit;
        return $html;
    }

    public function menu_tree($tree) {

        $html = '';

        if (is_array($tree)) {


            foreach ($tree as $val) {

                if (isset($val["name"])) {
                    $title = $val["name"];

                    if (!empty($val["a"])) {
                    	$c=$val['c'];
                    	$a=$val['a'];
                        $url = url("admin/$c/$a");//模块名变了这里的admin也要变
                        $val['data'] ? $url.='?' . $val['data'] : '';//这里有点问题
                    }


                    if (empty($val["id"])) {
                        $id = $val["name"];
                    } else {
                        $id = $val["id"];
                    }

                    if (empty($val['icon'])) {
                        $icon = "fa-caret-right";
                    } else {
                        $icon = $val['icon'];
                    }


                    if ($val['c'] == request()->controller() && $val['a'] == request()->action()) {
                        $active = 'active';
                    } else {
                        $active = '';
                    }

                    //echo $active;exit;

                    if (isset($val['_child'])) {

                        $html.=' 
                                <li class="" style="border-color: #324157;">
                            <a href="' . $url . '" class="dropdown-toggle"
                               style="font-size: 14px;line-height: 33px;height: 56px;padding-left: 20px">
                               
                                <span class="menu-text" style="color: #bfcbd9"> ' . $title . ' </span>
                                <b class="arrow fa fa-angle-down" style="height: 0;line-height: 33px;    color: #fff;"></b>
                            </a>
                          
                            <ul class="submenu">
                            ';

                        $html.=$this->menu_tree($val['_child']);

                        $html.='              
                            </ul>
                        </li>
                        ';
                    } else {

                        $html.='
                    <li class = "' . $active . '  l-2" style="border-color: #324157!important;">
                    <a href = "' . $url . '" onclick="clean()"  style="    height: 50px;line-height: 37px;color:#bfcbd9;padding-left:20px">
                   
                    <span class = "menu-text"> ' . $title . ' </span>
                   	
                    </a>
                    <b class = "arrow"></b>
                    </li>
                    ';
                    }
                }
            }
        }

        return $html;
    }

}
