<?php

/**
 *  
 * @file   GroupController.php  
 * @date   2016-9-1 15:11:41 
 * @author Zhenxun Du<5552123@qq.com>  
 * @version    SVN:$Id:$ 
 */

namespace application\admin\controller;

class GroupController extends CommonController {

    public function index() {
        $res = db('Admingroup')->select();
        $this->assign('lists', $res);
        return $this->fetch();
    }

    /*
     * 查看
     */

    public function info() {
        $id = input('id');
        if ($id) {
            //当前用户信息
            $info = db('admingroup')->find($id);
            $this->assign('info', $info);
        }

        return $this->fetch();
    }

    /*
     * 添加
     */

    public function add() {
        $data = input();
        $res = model('Admingroup')->allowField(true)->save($data);
        if ($res) {
            $this->success('操作成功', url('index'),'',1);
        } else {
            $this->error('操作失败');
        }
    }

    /*
     * 修改
     */

    public function edit() {
        $data = input();
        $data['updatetime'] = time();
        $res = model('Admingroup')->allowField(true)->save($data, ['id' => $data['id']]);
        if ($res) {
            $this->success('操作成功', url('index'),'',1);
        } else {
            $this->error('操作失败');
        }
    }

    /*
     * 删除
     */

    public function del() {
        $id = input('id');
        $res = db('admingroup')->where(['id' => $id])->delete();
        if ($res) {
            db('admingroupaccess')->where(['group_id'=>$id])->delete();
            $this->success('操作成功', url('index'),'',1);
        } else {
            $this->error('操作失败');
        }
    }

    /**
     * 权限
     */
    public function rule() {

        //echo APP_PATH;exit;
        if (input('gid')) {
            $gid = input('gid');
            $rules = db('admingroup')->where('id',$gid)->value('rules');
            $this->assign('rules',$rules);
            
            $menu = db('menu')->order('listorder asc')->select();
            $this->assign('menu', list_to_tree($menu));
            return $this->fetch();
        }
    }

    public function editRule() {
        $post = input();
        if ($post['id']) {
            $where = ['id' => $post['id']];

            $rules = implode(',', $post['rules']);
            $data = array();
            $data['updatetime'] = time();
            $data['rules'] = $rules;

            $res = model('admingroup')->save($data, $where);

            if ($res) {
                $this->success('操作成功',Url('index'),'',1);
            } else {
                $this->error('操作失败');
            }
        }
    }

}
