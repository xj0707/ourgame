<?php

/**
 *  
 * @file   LogController.php  
 * @date   2016-10-9 18:23:24 
 * @author Zhenxun Du<5552123@qq.com>  
 * @version    SVN:$Id:$ 
 */

namespace application\admin\controller;

class LogController extends CommonController {

    public function index() {
        $where = array();
        $lists = db("adminlog")->where($where)->order('id desc')->paginate(20);
        $this->assign('lists', $lists);
        return $this->fetch();
    }

}
