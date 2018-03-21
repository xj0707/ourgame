<?php

/**
 * 后台公共文件 
 * @file   Common.php  
 * @date   2016-8-24 18:28:34 
 * @author Zhenxun Du<5552123@qq.com>  
 * @version    SVN:$Id:$ 
 */

namespace application\admin\controller;

use think\Controller;
use think\Request;
use think\Db;
use think\Session;

class CommonController extends Controller {

    protected $user_id;
    protected $user_name;
    protected $come_where=array();

    public function __construct(\think\Request $request = null) {

        parent::__construct($request);
        if (!session('qipai_id')) {
            $this->error('请登陆', 'login/againLogin', '', 0);
        }

        $this->user_id = session('qipai_id');
        $this->user_name = session('user_name');
        //权限检查
        if (!$this->_checkAuthor($this->user_id)) {
            $this->error('你无权限操作');
        }
        if(session('merch_id')=='supadmin'){
            $this->come_where=[
            ];
        }else{
            $this->come_where=[
                'parentId'=>['in',session('merch_id')]
            ];
        }

        //记录日志
        //$this->_addLog();
    }

    /**
     * 权限检查
     */
    private function _checkAuthor($user_id) {
        
        if (!$user_id) {
            return false;
        }
        if($user_id==1){
            return true;
        }
        $c = strtolower(request()->controller());
        $a = strtolower(request()->action());
		//以public_开头的可以不用检查权限
        if (preg_match('/^public_/', $a)) {
            return true;
        }
        if ($c == 'index' && $a == 'index') {
            return true;
        }
        $menu = model('Menu')->getMyMenu($user_id);
        foreach ($menu as $k => $v) {
            if (strtolower($v['c']) == $c && strtolower($v['a']) == $a) {
                return true;
            }
        }
        return false;
    }

    /**
     * 记录日志
     */
    private function _addLog() {

        $data = array();
        $data['querystring'] = request()->query()?'?'.request()->query():'';
        $data['m'] = request()->module();
        $data['c'] = request()->controller();
        $data['a'] = request()->action();
        $data['userid'] = $this->user_id;
        $data['username'] = $this->user_name;
        $data['ip'] = ip2long(request()->ip());
        $arr = array('Index/index','Log/index','Menu/index');
        if (!in_array($data['c'].'/'.$data['a'], $arr)) {
            db('adminlog')->insert($data);
        } 
    }
    /*
     * 游戏监听
     */
    protected function gameListen($host,$port,$protectId){
        $jintinginfo=',监听成功！';
        $socket=socket_create(AF_INET,SOCK_STREAM,SOL_TCP);
        if($socket==false){
            $jintinginfo=",监听失败！";
        }
        if(@$conn=socket_connect($socket,$host,$port)==false){
            $jintinginfo=",监听失败！";
        }
        $user_id=session('qipai_id');
        $info=Db::name('admin')->where('id',$user_id)->find();
        //$length=strlen($info['username']);
        $sendlen=4+4+4+4+32;
        // 向socket服务器发送消息
        if(!@socket_write($socket, pack("IIIIa32",$sendlen,$protectId,$user_id,32,$info['password']))){
            $jintinginfo=",监听失败！";
        }

        return $jintinginfo;
    }

/**
 * 获取查询条件角色
 */
    public function getSearchWhere($role){
        $data=array();
        switch ($role){
            case 1:
                $data1=Db::name('merchant')->field('mid,username,nickname,suffix')->where('role',10)->select();
                $data2=Db::name('merchant')->field('mid,username,nickname,suffix')->where('role',100)->select();
                $data['xl']=$data1;
                $data['sh']=$data2;
                break;
            case 10:
                $uid=session('user_id');
                $data1=Db::name('merchant')->field('mid,username,nickname,suffix')->where('role',10)->where('levelIndex','like',"%$uid%")->select();
                $data2=Db::name('merchant')->field('mid,username,nickname,suffix')->where('role',100)->where('levelIndex','like',"%$uid%")->select();
                $data['xl']=$data1;
                $data['sh']=$data2;
                break;
            case 1000:
                $uid=session('user_id');
                $agentInfo=Db::name('merchant')->where('mid',$uid)->find();
                if($agentInfo['levelIndex']==0){//超代
                    $data3=Db::name('merchant')->field('mid,username,nickname,suffix')->where('role',1000)->where('levelIndex','<>',0)->select();
                }else{
                    $data3=Db::name('merchant')->field('mid,username,nickname,suffix')->where('role',1000)->where('levelIndex','like',"%$uid%")->select();
                }
                $data['dl']=$data3;
                break;
            case 10000:
                $data1=Db::name('merchant')->field('mid,username,nickname,suffix')->where('role',10)->select();
                $data2=Db::name('merchant')->field('mid,username,nickname,suffix')->where('role',100)->select();
                $data3=Db::name('merchant')->field('mid,username,nickname,suffix')->where('role',1000)->where('levelIndex','<>',0)->select();
                $data['xl']=$data1;
                $data['sh']=$data2;
                $data['dl']=$data3;
                break;
        }
        return $data;

    }

/**
 * 获取指定的线路商或者商户、代理
 */
public function getGivenRole($inputId,$str){
    $datainfo=array();
    switch ($str){
        case 'xl':
            $parentId=Db::name('merchant')->where('levelIndex','like',"%$inputId%")->column('mid');
            if(!count($parentId)){
                $this->error('该线路商下无商户，无玩家信息');
            }
            $users=Db::name('gameuser')->where('parentId','in',$parentId)->paginate(20,false,['query' => request()->param()]);
            $count=Db::name('gameuser')->where('parentId','in',$parentId)->count();
            $remainfangka=Db::name('gameuser')->where('parentId','in',$parentId)->sum('n64RoomCardNum');//剩余房卡总数
            $userids=Db::name('gameuser')->where('parentId','in',$parentId)->column('un32UserID');
            if(!count($userids)){
                $userids=[-1];
            }
            $totalfangka=Db::name('consumelog')->where('n32GoodsID','200000')->where('un32UserID','in',$userids)->sum('un32Num');//总购买房卡数
            $usefangka=$totalfangka-$remainfangka;
            $datainfo['users']=$users;
            $datainfo['count']=$count;
            $datainfo['remainfangka']=$remainfangka;
            $datainfo['usefangka']=$usefangka;
            break;
        case 'sh':
            $users=Db::name('gameuser')->where('parentId',$inputId)->paginate(20,false,['query' => request()->param()]);
            $count=Db::name('gameuser')->where('parentId',$inputId)->count();
            $remainfangka=Db::name('gameuser')->where('parentId',$inputId)->sum('n64RoomCardNum');//剩余房卡总数
            $userids=Db::name('gameuser')->where('parentId',$inputId)->column('un32UserID');
            if(!count($userids)){
                $userids=[-1];
            }
            $totalfangka=Db::name('consumelog')->where('n32GoodsID','200000')->where('un32UserID','in',$userids)->sum('un32Num');//总购买房卡数
            $usefangka=$totalfangka-$remainfangka;
            $datainfo['users']=$users;
            $datainfo['count']=$count;
            $datainfo['remainfangka']=$remainfangka;
            $datainfo['usefangka']=$usefangka;
            break;
        case 'dl':
            //echo $inputId;exit;
            $parentId=Db::name('merchant')->where('levelIndex','like',"%$inputId%")->column('mid');
            $parentId[]=$inputId;
            if(!count($parentId)){
                $this->error('该代理下无玩家信息');
            }
            $users=Db::name('gameuser')->where('parentId','in',$parentId)->paginate(20,false,['query' => request()->param()]);
            $count=Db::name('gameuser')->where('parentId','in',$parentId)->count();
            $remainfangka=Db::name('gameuser')->where('parentId','in',$parentId)->sum('n64RoomCardNum');//剩余房卡总数
            $userids=Db::name('gameuser')->where('parentId','in',$parentId)->column('un32UserID');
            if(!count($userids)){
                $userids=[-1];
            }
            $totalfangka=Db::name('consumelog')->where('n32GoodsID','200000')->where('un32UserID','in',$userids)->sum('un32Num');//总购买房卡数
            $usefangka=$totalfangka-$remainfangka;
            $datainfo['users']=$users;
            $datainfo['count']=$count;
            $datainfo['remainfangka']=$remainfangka;
            $datainfo['usefangka']=$usefangka;
            break;
    }
    return $datainfo;
}













}
