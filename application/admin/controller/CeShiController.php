<?php
namespace application\admin\controller;

use think\Db;
use think\Request;

class CeShiController extends CommonController{
    //牌型测试
    public function index(){
        $this->error('此功能已下架！');
        return $this->fetch();
    }
    //ajax验证 用户信息
    public function  doAction(Request $request){
        if($request->isAjax()){
            $username=input('username');
            $merchantId=input('merchantId');
            $res=Db::name('gameuser')->where('szUserName',$username)->where('merchantId',$merchantId)->find();
            if($res){
                $uid=$res['un32UserID'];
                return json(['code'=>1,'message'=>'操作成功','uid'=>$uid]);
            }else{
                return json(['code'=>-2,'message'=>'没有找到该玩家']);
            }
        }else{
            return json(['code'=>-1,'message'=>'非法请求！']);
        }
    }
    //麻将牌型操作
    public function dopaixing(Request $request){
        if($request->isAjax()){
            $uid=input('uid');
            $paixin=input('paixin');
            $arrpaixin=explode(',',$paixin);
            if(!count($arrpaixin)){
                return json(['code'=>-2,'message'=>'请输入想要的牌型！！']);
            }
//            foreach ($arrpaixin as $value){
//                if(abs($value)>40 || abs($value)<10){
//                    return json(['code'=>-3,'message'=>'你输入的牌型有误！！']);
//                }
//            }
            $strlen=strlen($paixin);
            //连接服务器
            $host='192.168.3.95';
            $port='20003';
            $protectId=config('majiangceshi');
            $socket=socket_create(AF_INET,SOCK_STREAM,SOL_TCP);
            if($socket==false){
                return json(['code'=>-1,'message'=>'与服务器连接失败1,请联系管理员！！']);
            }
            if(@$conn=socket_connect($socket,$host,$port)==false){
                return json(['code'=>-1,'message'=>'与服务器连接失败2，请联系管理员！！']);
            }
            $user_id=session('user_id');
            $info=Db::name('admin')->where('id',$user_id)->find();
            //$length=strlen($info['username']);
            $sendlen=4+4+4+4+32+4+4+$strlen;
            // 向socket服务器发送消息
            if(!@socket_write($socket, pack("IIIIa32IIa$strlen",$sendlen,$protectId,$user_id,32,$info['password'],$uid,$strlen,$paixin))){
                return json(['code'=>-1,'message'=>'与服务器连接失败3，请联系管理员！！！']);
            }else{
                return json(['code'=>1,'message'=>'操作成功！！']);
            }
        }else{
            return json(['code'=>-1,'message'=>'非法请求！']);
        }
    }

    //推锅操作
    public function dotuiguo(Request $request){
        if($request->isAjax()){
            $uid=input('uid');
            $tuiguo=input('tuiguo');
            $arrpaixin=explode(',',$tuiguo);
            if(!count($arrpaixin)){
                return json(['code'=>-2,'message'=>'请输入想要的牌型！！']);
            }
            foreach ($arrpaixin as $value){
                if(abs($value)>4747 || abs($value)<1111){
                    return json(['code'=>-3,'message'=>'你输入的牌型有误！！']);
                }
            }
            $strlen=strlen($tuiguo);
            //连接服务器
            $host='192.168.3.95';
            $port='20003';
            $protectId=config('tuiguoceshi');
            $socket=socket_create(AF_INET,SOCK_STREAM,SOL_TCP);
            if($socket==false){
                return json(['code'=>-1,'message'=>'与服务器连接失败1,请联系管理员！！']);
            }
            if(@$conn=socket_connect($socket,$host,$port)==false){
                return json(['code'=>-1,'message'=>'与服务器连接失败2，请联系管理员！！']);
            }
            $user_id=session('user_id');
            $info=Db::name('admin')->where('id',$user_id)->find();
            //$length=strlen($info['username']);
            $sendlen=4+4+4+4+32+4+4+$strlen;
            // 向socket服务器发送消息
            if(!@socket_write($socket, pack("IIIIa32IIa$strlen",$sendlen,$protectId,$user_id,32,$info['password'],$uid,$strlen,$tuiguo))){
                return json(['code'=>-1,'message'=>'与服务器连接失败3，请联系管理员！！！']);
            }else{
                return json(['code'=>1,'message'=>'操作成功！！']);
            }
        }else{
            return json(['code'=>-1,'message'=>'非法请求！']);
        }
    }













}