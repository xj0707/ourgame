<?php

/**
 *  
 * @file   Index.php  
 * @date   2016-8-23 16:03:10 
 * @author Zhenxun Du<5552123@qq.com>  
 * @version    SVN:$Id:$ 
 */  

namespace application\admin\controller;

use think\Db;
class IndexController extends CommonController{
    /**
     * 后台首页
     */
    public function index(){
        $role=session('user_role');
        $msg=getIDCardInfo($role);
        $this->assign('msg',$msg);
        return $this->fetch();
    }
    
    
}