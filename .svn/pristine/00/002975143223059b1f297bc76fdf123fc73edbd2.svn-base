<?php

/**
 *  
 * @file   AdminGroup.php  
 * @date   2016-8-30 18:22:31 
 * @author Zhenxun Du<5552123@qq.com>  
 * @version    SVN:$Id:$ 
 */

namespace application\admin\model;

class Admingroup extends \think\Model {
	// 设置数据表（不含前缀）
	//protected $name = 'AdminGroup';
	
    public function getGroups() {

        $res = db('Admingroup')->field('id,name')->select();
        $data = array();
        foreach ($res as $k => $v) {
            $data[$v['id']] = $v['name'];
        }
        return $data;
    }

    public function getGroupName($group_id) {
        return db('admingroup')->where(['id' => $group_id])->value('name');
    }

}
