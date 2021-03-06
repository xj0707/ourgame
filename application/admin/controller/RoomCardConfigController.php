<?php

namespace application\admin\controller;


use think\Db;
use think\Request;

class RoomCardConfigController extends CommonController
{
    public function index(){
        $infos=Db::name('roomcardconfig')->paginate(20);
        $this->assign('infos',$infos);
        return $this->fetch();
    }

    public function edit(){
        if(Request::instance()->isPost()){
            $id=input('post.id');
            if($id){
                $data=[
                    'roomcard_time'=>input('post.roomcard_time'),
                    'roomcard_round'=>input('post.roomcard_round'),
                    'rebate'=>input('post.rebate')
                ];
                $res=Db::name('roomcardconfig')->where('id',$id)->update($data);
                if($res){
                    $this->success('操作成功,预计3分钟内生效！','index','',1);
                }else{
                    $this->error('操作失败','index','',1);
                }
            }else{
                $this->error('请合法提交','index','',1);
            }
        }else{
            $id=input('id');
            if($id){
                $info=Db::name('roomcardconfig')->where('id',$id)->find();
                if($info){
                    $this->assign('info',$info);
                    return $this->fetch();
                }else{
                    $this->error('信息丢失请重新进入');
                }

            }else{
                $this->error('异常错误');
            }

        }
    }

}