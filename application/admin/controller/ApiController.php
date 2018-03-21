<?php
namespace application\admin\controller;

use think\Controller;
use think\Db;
class ApiController extends Controller{
	
	//悦博用户注册
	public function register(){
		$key=input('post.key');
		$szUserName=input('post.szUserName');
		$password=input('post.password');
		$szNickName=input('post.szNickName');
		$bSex=input('post.bSex');
		$userPicture=input('post.userPicture');
		$userAge=input('post.userAge');
		$userPhone=input('post.userPhone');
		$userQQ=input('post.userQQ');
		$userWeiXin=input('post.userWeiXin');
 		if(!$szUserName || !$password || !$szNickName || !$key){
			return json(['code'=>-1,'message'=>'数据不完整']);
		}
		$v2='register';
		$v3='YueBo_2017_1123qwe_aggd';
		$verify=$v2.$v3.$szUserName.$password.$szNickName.$bSex.$userPicture.$userAge.$userPhone.$userQQ.$userWeiXin;		
		$ver_key=md5($verify);
		echo $ver_key;
		if($key!=$ver_key){
			return json(['code'=>-10,'message'=>'非法请求']);
		}
		$info=Db::name('gameuser')->where('szUserName',$szUserName)->find();
		if($info){
			return json(['code'=>-3,'message'=>'用户已经存在']);
		}
		if(empty($bSex)){
			$bSex=0;
		}
		$time=time();
		$data=[
				'szUserName'=>$szUserName,
				'password'=>$password,
				'szNickName'=>$szNickName,
				'bSex'=>$bSex,
				'userPicture'=>$userPicture,
				'userAge'=>$userAge,
				'userPhone'=>$userPhone,
				'userQQ'=>$userQQ,
				'userWeiXin'=>$userWeiXin,
				'tRegisteUTCMilsec'=>$time
		];
		$res=Db::name('gameuser')->insert($data);
		if($res){
			return json(['code'=>1,'message'=>'操作成功']);
		}else{
			return json(['code'=>-2,'message'=>'操作失败']);
		}
	}
	
	//悦博查询用户
	public function search(){
		$key=input('post.key');
		$szUserName=input('post.szUserName');
		$szNickName=input('post.szNickName');
		$userPhone=input('post.userPhone');
		$userQQ=input('post.userQQ');
		$userWeiXin=input('post.userWeiXin');
		$v2='search';
		$v3='YueBo_2017_1123qwe_aggd';
		$verify=$v2.$v3.$szUserName.$szNickName.$userPhone.$userQQ.$userWeiXin;
		$ver_key=md5($verify);
		if($key!=$ver_key){
			return json(['code'=>-10,'message'=>'非法请求']);
		}
		if(isset($szUserName)){
			$map['szUserName']  = ['like',"%$szUserName%"];
		}
		if(isset($szNickName)){
			$map['szNickName']  = ['like',"%$szNickName%"];
		}
		if(isset($userPhone)){
			$map['userPhone']  = ['like',"%$userPhone%"];
		}
		if(isset($userQQ)){
			$map['userQQ']  = ['like',"%$userQQ%"];
		}
		if(isset($userWeiXin)){
			$map['userWeiXin']  = ['like',"%$userWeiXin%"];
		}
		if($szUserName || $szNickName || $userPhone || $userQQ || $userWeiXin){
			$res=Db::name('gameuser')->field('szUserName,szNickName')->where($map)->select();
			if($res){
				return json(['code'=>1,'message'=>'操作成功','data'=>$res]);
			}else{
				return json(['code'=>2,'message'=>'没有查到任何数据']);
			}
		}else{
			return json(['code'=>-1,'message'=>'参数不能为空']);
		}
	}

	//新接口验证身份信息，返回登录URL 没有模板接口
    public function checkLoginAccess(){
        header("Access-Control-Allow-Origin:*");
        $info=file_get_contents('php://input');
        $data=json_decode($info);
        $uid=$data->id;
        $timestamp=$data->timestamp;
        $sign=$data->sign;
        if(!$uid ||  !$timestamp  || !$sign){
            return json(['code'=>1,'msg'=>'参数不完整!']);
        }
        $str='id'.$uid.'timestamp'.$timestamp;
        $str=urlencode($str);
        $gameKey= config('qipaikey');
        $truesign=$gameKey.$str.$gameKey;
        $truesign=hash('sha256',$truesign);
        if($truesign!=$sign){
            return  json(['code'=>1,'msg'=>'签名验证失败!']);
        }
        //用uid去查找这个商户信息存在不？
        $info=Db::name('merchant')->where('mid',$uid)->find();
        if(!$info){
            return  json(['code'=>1,'msg'=>'信息没有同步,后台没有检测到商户,请联系管理员1!']);
        }
        if($info['bIfHaveChess'] ==0){
            return  json(['code'=>1,'msg'=>'没有棋牌游戏的权限!']);
        }
        if($info['isAccess']==0){//说明没有分配权限
            $groups=Db::name('admingroup')->column('id');
            if($info['role']==1 || ($info['role']==1000 && $info['levelIndex']==0)){
                foreach($groups as $v) {//分配权限
                   Db::name('admingroupaccess')->insert(['uid' => $info['id'], 'group_id' => $v]);//生成权限
                }
            }else{
                foreach($groups as $v) {//分配权限
                    if($v==11){//房卡配置只有顶级管理员才有 所以跳过
                        continue;
                    }
                   Db::name('admingroupaccess')->insert(['uid' => $info['id'], 'group_id' => $v]);//生成权限
                }
            }
            //更新字段
            Db::name('merchant')->where('mid',$uid)->update(['isAccess'=>1]);
        }
        //存在取出商户昵称,线路号，头像
        $username=$info['username'];
        $time=time();
        $role=$info['role'];
        $parentId=[];
        if($role==1){//平台管理员
            $msninfos=Db::name('merchant')->field('mid')->where('role','in',[10,100])->select();//获取所有的线路商、商户的 ID值
            foreach ($msninfos as $msninfo){
                $parentId[]=$msninfo['mid'];
            }
        }elseif($role==10){//线路商
            $msninfos=Db::name('merchant')->field('mid')->where('levelIndex','like',"%$uid%")->select();
            foreach ($msninfos as $msninfo){
                $parentId[]=$msninfo['mid'];
            }
        }elseif($role==100){//商户
            $parentId[]=$uid;
        }elseif($role=1000){//代理商
            if($info['levelIndex']==0){//超代
                $agentinfos=Db::name('merchant')->field('mid')->where('msn','0')->where('role','1000')->select();
                $parentId[]=$uid;
                foreach ($agentinfos as $agentinfo){
                    $parentId[]=$agentinfo['mid'];
                }
            }else{//普代
                $agentinfos=Db::name('merchant')->field('mid')->where('levelIndex','like',"%$uid%")->select();
                $parentId[]=$uid;
                foreach ($agentinfos as $agentinfo){
                    $parentId[]=$agentinfo['mid'];
                }
            }
        }
        if(!count($parentId)){
            $jsonarr=[
                'code'=>1,
                'msg'=>'无商户无玩家信息',
            ];
            return  json($jsonarr);
        }
        //生成URL给na平台
//        $data=[
//            'username'=>$username,
//            'uid'=>$uid,//是merchant表的mid
//            'parentId'=>$parentId,
//            'time'=>$time,
//            'role'=>$role,
//            'user_id'=>$info['id']//主键自动生成的ID 主要用于权限
//        ];
        $data=[
            'uid'=>$uid,
            'time'=>$time
        ];
        $token=serialize($data);
        $token = encry_code($token);//加密
        $jsonarr=[
            'code'=>0,
            'msg'=>'success',
            'url'=>'http://'.config('naurl').'/admin/login/apilogin/token/'.$token.'.html'
        ];
        return  json($jsonarr);

    }

	//新接口验证身份信息 返回登录URL
//	public function checkLoginAccess(){
//        header("Access-Control-Allow-Origin:*");
//        $info=file_get_contents('php://input');
//        $data=json_decode($info);
//        $uid=$data->id;
//        $timestamp=$data->timestamp;
//        $sign=$data->sign;
//        if(!$uid ||  !$timestamp  || !$sign){
//            return json(['code'=>1,'msg'=>'参数不完整!']);
//        }
//        $str='id'.$uid.'timestamp'.$timestamp;
//        $str=urlencode($str);
//        $gameKey='3c1149e7-7ccb-475d-888f-baa6a3da342b';//定义棋牌的key
//        $truesign=$gameKey.$str.$gameKey;
//        $truesign=hash('sha256',$truesign);
//        if($truesign!=$sign){
//            $jsonarr=[
//                'code'=>1,
//                'msg'=>'签名验证失败!',
//            ];
//            return  json($jsonarr);
//        }
//        //用uid去查找这个商户信息存在不？
//        $info=Db::name('merchant')->where('id',$uid)->find();
//        if(!$info){
//            $jsonarr=[
//                'code'=>1,
//                'msg'=>'信息没有同步,后台没有检测到商户,请联系管理员!',
//            ];
//            return  json($jsonarr);
//        }
//        //存在取出商户昵称,线路号，头像
//        $username=$info['username'];
//        $merchantId=$info['msn'];
//        $time=time();
//        //代理商角色
//        if($info['role']==0){
//            if($info['bIfHaveChess']==1){
//                $admininfo=Db::name('admin')->where('merchantId',0)->where('username',$info['username'])->find();
//                if(!$admininfo){//如果不存在生成管理员
//                    $datainfo=[
//                        'username'=>$username,
//                        'password'=>md5("sup_%_".$username.'1000'),
//                        'merchantId'=>0,
//                        'parentId'=>0,
//                        'status'=>1,
//                    ];
//                    $admin_info=Db::name('admin')->insert($datainfo);
//                    if($admin_info){
//                        $id = Db::name('admin')->getLastInsID();
//                        $groups=Db::name('admingroup')->field('id')->select();
//                        foreach($groups as $v) {
//                            Db::name('admingroupaccess')->insert(['uid' => $id, 'group_id' => $v['id']]);//生成权限
//                            if ($v['id'] == 1) {//推锅添加系统模板，即搓牌下注时间
//                                $teminfo = [
//                                    'szName' => '系统模板',
//                                    'un32UserID' => 0,
//                                    'bIfTax' => 1,
//                                    'fWinTaxRate' => 10,
//                                    'fLoseTaxRate' => 5,
//                                    'un32TotalAnte' => 5000,
//                                    'bIfLookOn' => 1,
//                                    'un32OnLookerNum' => 10,
//                                    'un32InitScore' => 10000,
//                                    'eForbidChat' => 0,
//                                    'un32SingleScore' => 500,
//                                    'merchantId' => 0,
//                                    'un32IfActive' => 1,//应用
//                                ];
//                                $resinfo = Db::name('gameroomtemplate_tuiguo')->insert($teminfo);
//                                $temId = Db::name('gameroomtemplate_tuiguo')->getLastInsID();
//                                $timeinfo = [
//                                    'tel_id' => $temId,
//                                    'un32BetWaitSecond' => 15,
//                                    'un32RubCardSecond' => 15,
//                                    'time' => $time,
//                                    'merchantId' => 0
//                                ];
//                                Db::name('settime_tuiguo')->insert($timeinfo);
//                            } elseif ($v['id'] == 2) {//推筒子添加系统模板，即搓牌下注时间
//                                $teminfo = [
//                                    'szName' => '系统模板',
//                                    'un32UserID' => 0,
//                                    'bIfTax' => 1,
//                                    'fWinTaxRate' => 10,
//                                    'fLoseTaxRate' => 5,
//                                    'un32TotalAnte' => 5000,
//                                    'bIfLookOn' => 1,
//                                    'un32OnLookerNum' => 10,
//                                    'un32InitScore' => 10000,
//                                    'eForbidChat' => 0,
//                                    'un32SingleScore' => 500,
//                                    'merchantId' => 0,
//                                    'un32IfActive' => 1,//应用
//                                ];
//                                $resinfo = Db::name('gameroomtemplate_tuitongzi')->insert($teminfo);
//                                $temId = Db::name('gameroomtemplate_tuitongzi')->getLastInsID();
//                                $timeinfo = [
//                                    'tel_id' => $temId,
//                                    'un32BetWaitSecond' => 15,
//                                    'un32RubCardSecond' => 15,
//                                    'time' => $time,
//                                    'merchantId' => 0
//                                ];
//                                Db::name('settime_tuitongzi')->insert($timeinfo);
//                            }//有其他模板的添加其他模板
//                        }
//                    }else{
//                        file_put_contents('apilog.txt',date('Y-m-d H:i:s').'代理商管理员生成失败',FILE_APPEND);
//                    }
//                }else{
//                    $id=$admininfo['id'];
//                }
//                //生成代理商URL给na平台
//                $data=[
//                    'username'=>$username,
//                    'uid'=>$id,
//                    'merchantId'=>[0],
//                    'agentId'=>$uid,//这个来区分代理商下面的玩家所属那个代理商
//                    'time'=>$time
//                ];
//                $token=serialize($data);
//                $token = encry_code($token);//加密
//                $jsonarr=[
//                    'code'=>0,
//                    'msg'=>'success',
//                    'url'=>'http://root.rottagame.com/admin/login/apilogin/token/'.$token.'.html'
//                ];
//                return  json($jsonarr);
//
//
//            }else{
//                $jsonarr=[
//                    'code'=>1,
//                    'msg'=>'该代理商没有棋牌管理权限',
//                ];
//                return json($jsonarr);
//            }
//        }
//
//        //线路商角色
//        if($info['role']==10){
//            $xInfos=Db::name('merchant')->where('parentId',$info['id'])->where('bIfHaveChess',1)->select();
//            if(count($xInfos)){
//                $xmsn=[];
//                foreach($xInfos as $xInfo){
//                    $xmsn[]=$xInfo['msn'];
//                }
//                $admininfo=Db::name('admin')->where('merchantId',1000)->where('username',$info['username'])->find();
//                if(!$admininfo){//如果不存在生成管理员
//                    $datainfo=[
//                        'username'=>$username,
//                        'password'=>md5("sup_%_".$username.'1000'),
//                        'merchantId'=>1000,
//                        'parentId'=>0,
//                        'status'=>1,
//                    ];
//                    $admin_info=Db::name('admin')->insert($datainfo);
//                    if($admin_info){
//                        $id = Db::name('admin')->getLastInsID();
//                        $groups=Db::name('admingroup')->field('id')->select();
//                        foreach($groups as $v) {
//                            Db::name('admingroupaccess')->insert(['uid' => $id, 'group_id' => $v['id']]);//生成权限
//                        }
//                    }else{
//                        file_put_contents('apilog.txt',date('Y-m-d H:i:s').'线路商管理员生成失败',FILE_APPEND);
//                    }
//
//                }else{
//                    $id=$admininfo['id'];
//                }
//                //生成线路商URL给na平台
//                $data=[
//                    'username'=>$username,
//                    'uid'=>$id,
//                    'merchantId'=>$xmsn,
//                    'time'=>$time
//                ];
//                $token=serialize($data);
//                $token = encry_code($token);//加密
//                $jsonarr=[
//                    'code'=>0,
//                    'msg'=>'success',
//                    'url'=>'http://root.rottagame.com/admin/login/apilogin/token/'.$token.'.html'
//                ];
//            }else{
//                $jsonarr=[
//                    'code'=>1,
//                    'msg'=>'旗下没有商户拥有棋牌游戏!',
//                ];
//            }
//            return  json($jsonarr);
//        }
//        //超管角色
//        if($info['role']==1){
//            //生成超级管理员URL
//            $data=[
//                'username'=>$username,
//                'uid'=>1,//超管ID
//                'merchantId'=>[10000],//超管变一万
//                'time'=>$time
//            ];
//            $token=serialize($data);
//            $token = encry_code($token);//加密
//            $jsonarr=[
//                'code'=>0,
//                'msg'=>'success',
//                'url'=>'http://root.rottagame.com/admin/login/apilogin/token/'.$token.'.html'
//            ];
//            return  json($jsonarr);
//        }
//        //商户角色
//        if($info['role']==100 ){
//            if( $info['bIfHaveChess']==1){
//                //判断有没有这个管理员，没有生成管理员，并分配权限
//                $admininfo=Db::name('admin')->where('merchantId',$merchantId)->find();
//                if(!$admininfo){//没有就生成管理员
//                    $datainfo=[
//                        'username'=>$username,
//                        'password'=>md5("sup_%_".$username.$merchantId),
//                        'merchantId'=>$merchantId,
//                        'parentId'=>0,
//                        'status'=>1,
//                    ];
//                    $admin_info=Db::name('admin')->insert($datainfo);
//                    if($admin_info){
//                        $userId = Db::name('admin')->getLastInsID();
//                        //查出所有的权限分组（因为目前是全部购买棋牌的所以所有权限都有）
//                        $groups=Db::name('admingroup')->field('id')->select();
//                        foreach($groups as $v) {
//                            Db::name('admingroupaccess')->insert(['uid' => $userId, 'group_id' => $v['id']]);//生成权限
//                            if ($v['id'] == 1) {//推锅添加系统模板，即搓牌下注时间
//                                $teminfo = [
//                                    'szName' => '系统模板',
//                                    'un32UserID' => 0,
//                                    'bIfTax' => 1,
//                                    'fWinTaxRate' => 10,
//                                    'fLoseTaxRate' => 5,
//                                    'un32TotalAnte' => 5000,
//                                    'bIfLookOn' => 1,
//                                    'un32OnLookerNum' => 10,
//                                    'un32InitScore' => 10000,
//                                    'eForbidChat' => 0,
//                                    'un32SingleScore' => 500,
//                                    'merchantId' => $merchantId,
//                                    'un32IfActive' => 1,//应用
//                                ];
//                                $resinfo = Db::name('gameroomtemplate_tuiguo')->insert($teminfo);
//                                $temId = Db::name('gameroomtemplate_tuiguo')->getLastInsID();
//                                $timeinfo = [
//                                    'tel_id' => $temId,
//                                    'un32BetWaitSecond' => 15,
//                                    'un32RubCardSecond' => 15,
//                                    'time' => $time,
//                                    'merchantId' => $merchantId
//                                ];
//                                Db::name('settime_tuiguo')->insert($timeinfo);
//                            } elseif ($v['id'] == 2) {//推筒子添加系统模板，即搓牌下注时间
//                                $teminfo = [
//                                    'szName' => '系统模板',
//                                    'un32UserID' => 0,
//                                    'bIfTax' => 1,
//                                    'fWinTaxRate' => 10,
//                                    'fLoseTaxRate' => 5,
//                                    'un32TotalAnte' => 5000,
//                                    'bIfLookOn' => 1,
//                                    'un32OnLookerNum' => 10,
//                                    'un32InitScore' => 10000,
//                                    'eForbidChat' => 0,
//                                    'un32SingleScore' => 500,
//                                    'merchantId' => $merchantId,
//                                    'un32IfActive' => 1,//应用
//                                ];
//                                $resinfo = Db::name('gameroomtemplate_tuitongzi')->insert($teminfo);
//                                $temId = Db::name('gameroomtemplate_tuitongzi')->getLastInsID();
//                                $timeinfo = [
//                                    'tel_id' => $temId,
//                                    'un32BetWaitSecond' => 15,
//                                    'un32RubCardSecond' => 15,
//                                    'time' => $time,
//                                    'merchantId' => $merchantId
//                                ];
//                                Db::name('settime_tuitongzi')->insert($timeinfo);
//                            }//有其他模板的添加其他模板
//                        }
//
//                    }else{
//                        file_put_contents('apilog.txt',date('Y-m-d H:i:s').'商户管理员生成失败',FILE_APPEND);
//                    }
//                }else{
//                    $userId=$admininfo['id'];
//                }
//                //生成商户URL给na平台
//                $data=[
//                    'username'=>$username,
//                    'uid'=>$userId,
//                    'merchantId'=>[$merchantId],
//                    'time'=>$time
//                ];
//                $token=serialize($data);
//                $token = encry_code($token);//加密
//                $jsonarr=[
//                    'code'=>0,
//                    'msg'=>'success',
//                    'url'=>'http://root.rottagame.com/admin/login/apilogin/token/'.$token.'.html'
//                ];
//                return  json($jsonarr);
//            }else{
//                $jsonarr=[
//                    'code'=>1,
//                    'msg'=>'该商户没有棋牌游戏的权限！',
//                ];
//                return  json($jsonarr);
//            }
//        }
//    }

	
	//接口生成后台商户管理员账号密码权限（新增和修改）
	public function init_admin_access(){
	    exit;
		header("Access-Control-Allow-Origin:*");
		$data=input();
		$merchantId=$data['merchantId'];
		$policy=$data['policy'];
		$gameAdmin=$data['gameAdmin'];
		$password=$data['password'];
		$pk=$data['key'];
		$action=$data['action'];
		$mall=$data['mall'];//是否拥有商店配置 0 是不能1 是有
		if(!$merchantId || !$gameAdmin || !$password || !$pk || !$action || !isset($mall)){
			return json(['code'=>-1,'message'=>'参数不完整！']);
		}

		if(empty($policy)){
			return json(['code'=>-6,'message'=>'权限字段为空！']);
		}
		$today=date("Y-m-d");
		$truekey=md5($password."+".	md5($today.":NA_TABLE"));
		if($pk!=$truekey){
			return json(['code'=>-2,'message'=>'非法请求！']);
		}
		$groups=array(4,5,8,9);//默认的权限（这个与数据库里面的一一对应）
		if(in_array('10000',$policy)){//有推锅
			array_push($groups,1);//赋予推锅权限
		}
		if(in_array('10001',$policy)){//推筒子
			array_push($groups,2);//赋予推筒子权限
		}
		if(in_array('paijiu',$policy)){//牌九
			array_push($groups,3);//赋予牌九权限
		}
		if($mall===1){
			array_push($groups,6);//添加商店配置
		}
		if(!in_array('10000',$policy) && !in_array('10001',$policy) && !in_array('paijiu',$policy)){//都为false的时候走里面
			return json(['code'=>-7,'message'=>'没有找到相关游戏权限字段！']);
		}
		$time=time();
		//不同字段操作不同
		switch($action){
			case 'create':
				$res=Db::name('admin')->where('merchantId',$merchantId)->find();
				if($res){
					return json(['code'=>-3,'message'=>'该线路号已经存在了！']);
				}
				$info=Db::name('admin')->where('username',$gameAdmin)->find();
				if($info){
					return json(['code'=>-5,'message'=>'该账号已经被占用了！']);
				}
				$data=[
					'username'=>$gameAdmin,
					'password'=>md5("sup_%_".$password),
					'merchantId'=>$merchantId,
					'parentId'=>0,
					'status'=>1,
				];
				$admin_info=Db::name('admin')->insert($data);
				if($admin_info){
					$userId = Db::name('admin')->getLastInsID();
					foreach($groups as $v){
						Db::name('admingroupaccess')->insert(['uid' => $userId, 'group_id' => $v]);
						if($v==1){//推锅添加系统模板，即搓牌下注时间
							$teminfo=[
								'szName'=>'系统模板',
								'un32UserID'=>0,
								'bIfTax'=>1,
								'fWinTaxRate'=>10,
								'fLoseTaxRate'=>5,
								'un32TotalAnte'=>5000,
								'bIfLookOn'=>1,
								'un32OnLookerNum'=>10,
								'un32InitScore'=>10000,
								'eForbidChat'=>0,
								'un32SingleScore'=>500,
								'merchantId'=>$merchantId,
								'un32IfActive'=>1,//应用
							];
							$resinfo=Db::name('gameroomtemplate_tuiguo')->insert($teminfo);
							$temId = Db::name('gameroomtemplate_tuiguo')->getLastInsID();
							$timeinfo=[
								'tel_id'=>$temId,
								'un32BetWaitSecond'=>15,
								'un32RubCardSecond'=>15,
								'time'=>$time,
								'merchantId'=>$merchantId
							];
							Db::name('settime_tuiguo')->insert($timeinfo);

						}elseif($v==2){//推筒子添加系统模板，即搓牌下注时间
							$teminfo=[
								'szName'=>'系统模板',
								'un32UserID'=>0,
								'bIfTax'=>1,
								'fWinTaxRate'=>10,
								'fLoseTaxRate'=>5,
								'un32TotalAnte'=>5000,
								'bIfLookOn'=>1,
								'un32OnLookerNum'=>10,
								'un32InitScore'=>10000,
								'eForbidChat'=>0,
								'un32SingleScore'=>500,
								'merchantId'=>$merchantId,
								'un32IfActive'=>1,//应用
							];
							$resinfo=Db::name('gameroomtemplate_tuitongzi')->insert($teminfo);
							$temId = Db::name('gameroomtemplate_tuitongzi')->getLastInsID();
							$timeinfo=[
								'tel_id'=>$temId,
								'un32BetWaitSecond'=>15,
								'un32RubCardSecond'=>15,
								'time'=>$time,
								'merchantId'=>$merchantId
							];
							Db::name('settime_tuitongzi')->insert($timeinfo);
						}elseif($v==6){
							$lists = Db::name('roomshopping')->where('merchantId',$merchantId)->paginate(6);
							if(count($lists)!=6){//初始的时候没有
								//房卡商店
								$dataall = [
									['roomcard' => 10, 'coins' => 5,'state'=>0,'merchantId'=>$merchantId],
									['roomcard' => 24, 'coins' => 12,'state'=>0,'merchantId'=>$merchantId],
									['roomcard' => 72, 'coins' => 36,'state'=>0,'merchantId'=>$merchantId],
									['roomcard' => 96, 'coins' => 48,'state'=>0,'merchantId'=>$merchantId],
									['roomcard' => 120, 'coins' => 60,'state'=>0,'merchantId'=>$merchantId],
									['roomcard' => 144, 'coins' => 72,'state'=>0,'merchantId'=>$merchantId]
								];
								Db::name('roomshopping')->insertAll($dataall);
							}
						}
					}

					return json(['code'=>1,'message'=>'操作成功！']);
				}else{
					return json(['code'=>-8,'message'=>'操作失败！']);
				}
				break;
			case 'update':
				$res=Db::name('admin')->where('merchantId',$merchantId)->find();
				if(!$res){
					return json(['code'=>-3,'message'=>'更新的线路号不存在！']);
				}
				$id=$res['id'];//商户管理员ID
				$info=db('admingroupaccess')->where(['uid' => $id])->delete();//先删再更新
				if($info){
					foreach($groups as $v){
						Db::name('admingroupaccess')->insert(['uid' => $id, 'group_id' => $v]);
					}
					$adminIds=Db::name('admin')->field('id')->where(['parentId'=>$id])->select();
					if($adminIds){
						//删除子管理员中不存在的权限
						foreach($adminIds as $vv){
							$groupsids=Db::name('admingroupaccess')->field('group_id')->where(['uid'=>$vv['id']])->select();
							foreach($groupsids as $vvv){
								if(!in_array($vvv['group_id'],$groups)){
									db('admingroupaccess')->where(['uid' => $vv['id']])->where(['group_id'=>$vvv['group_id']])->delete();
								}
							}
						}
					}
					return json(['code'=>1,'message'=>'更新成功！']);
				}else{
					return json(['code'=>-8,'message'=>'操作失败！']);
				}
				break;
			case 'delete':
				$res=Db::name('admin')->where('merchantId',$merchantId)->find();
				if($res){//存在就删掉
					$id=$res['id'];
					Db::name('admin')->where('id',$id)->delete();
					//这里是删掉旗下的子管理员 如果后面要保留就不能删除！
					db('admingroupaccess')->where(['uid' => $id])->delete();
					$adminIds=Db::name('admin')->field('id')->where(['merchantId'=>$merchantId])->select();
					foreach($adminIds as $v){
						Db::name('admin')->where(['id'=>$v['id']])->delete();
						db('admingroupaccess')->where(['uid' => $v['id']])->delete();
					}
					Db::name('roomshopping')->where('merchantId',$merchantId)->delete();
					Db::name('gameroomtemplate_tuitongzi')->where('merchantId',$merchantId)->delete();
					Db::name('settime_tuitongzi')->where('merchantId',$merchantId)->delete();
					Db::name('gameroomtemplate_tuiguo')->where('merchantId',$merchantId)->delete();
					Db::name('settime_tuiguo')->where('merchantId',$merchantId)->delete();
					return json(['code'=>1,'message'=>'删除成功！']);
				}else{
					return json(['code'=>-5,'message'=>'该线路号不存在！']);
				}
				break;
			default:
				return json(['code'=>-10,'message'=>'操作指令不明确！']);
		}
	}

	public function sendInfoApi($host,$port,$protectId,$user_id){
		$socket=socket_create(AF_INET,SOCK_STREAM,SOL_TCP);
		if($socket==false){
			return false;
		}
		if(@$conn=socket_connect($socket,$host,$port)==false){
			return false;
		}
		$info=Db::name('admin')->where('id',$user_id)->find();
		//$length=strlen($info['username']);
		$sendlen=4+4+4+4+32;
		// 向socket服务器发送消息
		if(!@socket_write($socket, pack("IIIIa32",$sendlen,$protectId,$user_id,32,$info['password']))){
			return false;
		}
		return true;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}