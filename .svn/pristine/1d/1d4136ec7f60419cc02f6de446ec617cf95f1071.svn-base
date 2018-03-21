<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/6/19
 * Time: 11:55
 */
namespace application\admin\controller;
use think\Db;

class UserBuyFangKaController extends \application\admin\controller\CommonController{
    //购买记录显示
    public function index(){
        $userids = Db::name('gameuser')->where($this->come_where)->count();
        if($userids) {
            $arrId=Db::name('gameuser')->field('un32UserID')->where($this->come_where)->column('un32UserID');
            $info=Db::name('consumelog')->alias('u')->join(config('database.prefix').'gameuser g','u.un32UserID=g.un32UserID')->where("u.un32UserID",'in',$arrId)->order('u.id desc')->paginate(20);
            $this->assign('usergold',$info);
            return $this->fetch();
        }else{
            $this->error('无玩家信息！');
        }
    }
    //时间查询
    public function liketime(){
        $s_time=strtotime(input('post.create_time'));
        $e_time=strtotime(input('post.e_time'));
        $where="u.tLogTime > $s_time";
        if($e_time){
            $where="u.tLogTime> $s_time and u.tLogTime < $e_time ";
        }
        $userids = Db::name('gameuser')->where($this->come_where)->count();
        if($userids) {
            $arrId=Db::name('gameuser')->field('un32UserID')->where($this->come_where)->column('un32UserID');
            $info=Db::name('consumelog')->alias('u')->join(config('database.prefix').'gameuser g','u.un32UserID=g.un32UserID')->where("u.un32UserID",'in',$arrId)->where($where)->order('u.id desc')->paginate(20);
            $this->assign('usergold',$info);
            return $this->fetch('index');
        }else{
            $this->error('无玩家信息！');
        }
    }
    //玩家ID查询
    public function searchid(){
        $un32UserID=input('post.un32UserID');
        $userids = Db::name('gameuser')->where($this->come_where)->count();
        if($userids) {
            $arrId=Db::name('gameuser')->field('un32UserID')->where($this->come_where)->column('un32UserID');
            $info=Db::name('consumelog')->alias('u')->join(config('database.prefix').'gameuser g','u.un32UserID=g.un32UserID')->where("u.un32UserID",'in',$arrId)->where('g.un32UserID',$un32UserID)->order('u.id desc')->paginate(20);
            $this->assign('usergold',$info);
            return $this->fetch('index');
        }else{
            $this->error('无玩家信息!');
        }

    }
    //玩家用户名查询
    public function searchname(){
        $szUserName=input('post.szUserName');
        $userids = Db::name('gameuser')->where($this->come_where)->count();
        if($userids) {
            $arrId=Db::name('gameuser')->field('un32UserID')->where($this->come_where)->column('un32UserID');
            $info=Db::name('consumelog')->alias('u')->join(config('database.prefix').'gameuser g','u.un32UserID=g.un32UserID')->where("u.un32UserID",'in',$arrId)->where('g.szUserName','like',"%$szUserName%")->order('u.id desc')->paginate(20);
            $this->assign('usergold',$info);
            return $this->fetch('index');
        }else{
            $this->error('未找到该玩家');
        }
    }


}