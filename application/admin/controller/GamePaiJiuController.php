<?php
namespace application\admin\controller;

use application\admin\model\Gameroom;
use application\admin\model\Gameuser;
use application\admin\model\Pumpwaterrecord;
use application\admin\model\Tuitongroom;
use think\db;
use think\Model;
use application\admin\model\Gamebetrecord;
class GamePaiJiuController extends CommonController{
	//显示所有大厅(二期再加)
	public function index(){
// 		$data=['a','b','c',1,2,3];
// 		return json(['data'=>$data,'code'=>1,'message'=>'操作完成']);
		return $this->fetch();
	}
	
	//大厅里面的房间展示
	public function show(){
		$gameroom=new Gameroom();
		$merchantId=$this->merch_id;
		if($merchantId !=10000) {
			$userids = Db::name('gameuser')->field('un32UserID')->where('merchantId', $merchantId)->select();
			$arrId = array();
			if($userids){
				foreach ($userids as $v) {
					$arrId[] = $v['un32UserID'];
				}
				//->join(config('tuiguo_db.db1').'.'.config('database.prefix').'pumpwaterrecord p','p.un32GameRoomID=g.un32ID')
				$rooms = $gameroom->alias('g')->join(config('database.database').'.'.config('database.prefix').'gameuser u','g.un32OwnerUserID=u.un32UserID')->where("g.un32OwnerUserID",'in',$arrId)->order('g.un32ID','desc')->paginate(15);
				foreach($rooms as $k=>$v){
					$un32ID=$v['un32ID'];
					$pwr=new Pumpwaterrecord();
					//总抽水
					$total=$pwr->where('un32GameRoomID',$un32ID)->sum('n32PumpWaterNum');
					$rooms[$k]['total']=$total;
				}
			}else{
				$this->error('无玩家游戏房间！');
			}

		}else{
			$rooms = $gameroom->alias('g')->join(config('database.database').'.'.config('database.prefix').'gameuser u','g.un32OwnerUserID=u.un32UserID')->order('g.un32ID','desc')->paginate(20);
			foreach($rooms as $k=>$v){
				$un32ID=$v['un32ID'];
				$pwr=new Pumpwaterrecord();
				//总抽水
				$total=$pwr->where('un32GameRoomID',$un32ID)->sum('n32PumpWaterNum');
				$rooms[$k]['total']=$total;
			}
		}

		$this->assign('rooms', $rooms);
		return $this->fetch();

	}
	
	//房间详细信息
	public function details(){
		$un32ID=input('get.un32ID');//房间ID
		$roompwd=input('get.roompwd');//房间号
		if($un32ID){
			$un32TotalAnte=Db::table(config('tuiguo_db.db1').'.'.config('database.prefix').'gameroom')->field('un32TotalAnte')->where('un32ID',$un32ID)->find();
			$pwr=new Pumpwaterrecord();
			//总抽水
			$total=$pwr->where('un32GameRoomID',$un32ID)->sum('n32PumpWaterNum');
			$infos=$pwr->alias('p')->join(config('database.database').'.'.config('database.prefix').'gameuser g','p.un32GameBankerID=g.un32UserID')->where('p.un32GameRoomID',$un32ID)->select();
			foreach($infos as $k=>$v){
				if(($v['n32BottonOfPotNum']-$un32TotalAnte['un32TotalAnte'])>0){
					$infos[$k]['state']='赢';
				}else{
					$infos[$k]['state']='输';
				}
			}

			$this->assign('roompwd',$roompwd);
			$this->assign('infos',$infos);
			$this->assign('total',$total);
			return $this->fetch();
		}else{
			$this->error('页面丢失！');
		}
	}
	//每局详情
	public function juinfo(){
		$roomid=input('get.roomid');
		$juid=input('get.juid');
		$roompwd=input('get.roompwd');
		$infos = Db::table(config('tuiguo_db.db1').'.'.config('database.prefix').'gameroundrecord')->where('un32GameRoomID',$roomid)->where('un32GameJuID',$juid)->select();
		$count = Db::table(config('tuiguo_db.db1').'.'.config('database.prefix').'gameroundrecord')->where('un32GameRoomID',$roomid)->where('un32GameJuID',$juid)->count();
		if($infos){
			$this->assign('infos',$infos);
			$this->assign('count',$count);
			$this->assign('roompwd',$roompwd);
			$this->assign('juid',$juid);
			return $this->fetch();
		}else{
			$this->error('无回合详情！');
		}
	}
	//回合详情
	public function huiinfo(){
		$roomid=input('get.roomid');
		$juid=input('get.juid');
		$huiid=input('get.huiid');
		$count=input('get.count');
		if($huiid==$count){//判断是不是最后一回合
			$pwr=new Pumpwaterrecord();
			$pums=$pwr->where('un32GameRoomID',$roomid)->where('un32GameJuID',$juid)->find();
			$fPumpWaterPercent=$pums['fPumpWaterPercent'];//抽水比例
			$n32PumpWaterNum=$pums['n32PumpWaterNum'];//抽水数量
			$n32BottonOfPotNum=$pums['n32BottonOfPotNum']-$n32PumpWaterNum;//实际收益
			$this->assign('info1',$fPumpWaterPercent);
			$this->assign('info2',$n32PumpWaterNum);
			$this->assign('info3',$n32BottonOfPotNum);
			$this->assign('count',$count);
		}
		$Gamebetrecord=new Gamebetrecord();
		$infos = $Gamebetrecord->alias('b')->join(config('database.database').'.'.config('database.prefix').'gameuser g','b.un32PlayerID=g.un32UserID')->where('b.un32GameRoomID',$roomid)->where('b.un32GameJuID',$juid)->where('b.un32GameRoundID',$huiid)->order('eIdentity asc')->select();
		if($infos){
			$this->assign('infos',$infos);
			$this->assign('huiid',$huiid);
			$this->assign('juid',$juid);
			return $this->fetch();
		}else{
			$this->error('无下注详情！');
		}
	}

	//根据房间号来查询房间
	public function likeroomid(){
		$n32GameRoomPwd=input('post.n32GameRoomPwd');

			$gameroom=new Gameroom();
			$merchantId=$this->merch_id;
			if($merchantId !=10000) {
				$userids = Db::name('gameuser')->field('un32UserID')->where('merchantId', $merchantId)->select();
				$arrId = array();
				foreach ($userids as $v) {
					$arrId[] = $v['un32UserID'];
				}
				$rooms = $gameroom->alias('g')->join(config('database.database').'.'.config('database.prefix').'gameuser u','g.un32OwnerUserID=u.un32UserID')->where('g.n32GameRoomPwd','like',"%$n32GameRoomPwd%")->where("g.un32OwnerUserID",'in',$arrId)->paginate(20);
			}else{
				$rooms = $gameroom->alias('g')->join(config('database.database').'.'.config('database.prefix').'gameuser u','g.un32OwnerUserID=u.un32UserID')->where('g.n32GameRoomPwd','like',"%$n32GameRoomPwd%")->paginate(20);
			}
			$this->assign('rooms', $rooms);
			return $this->fetch('show');

	}
	//根据用户名来查询房间
	public function likeuser(){
		$szUserName=input('post.szUserName');

			$gameroom=new Gameroom();
			$merchantId=$this->merch_id;
			if($merchantId !=10000) {
				$userids = Db::name('gameuser')->field('un32UserID')->where('merchantId', $merchantId)->select();
				$arrId = array();
				foreach ($userids as $v) {
					$arrId[] = $v['un32UserID'];
				}
				$rooms = $gameroom->alias('g')->join(config('database.database').'.'.config('database.prefix').'gameuser u','g.un32OwnerUserID=u.un32UserID')->where('u.n32GameRoomPwd','like',"%$szUserName%")->where("g.un32OwnerUserID",'in',$arrId)->paginate(20);
			}else{
				$rooms = $gameroom->alias('g')->join(config('database.database').'.'.config('database.prefix').'gameuser u','g.un32OwnerUserID=u.un32UserID')->where('g.n32GameRoomPwd','like',"%$szUserName%")->paginate(20);
			}
			$this->assign('rooms', $rooms);
			return $this->fetch('show');

	}
	//socket链接
	public function socket(){
		//现在只需查看结果


		//原来需要监听修改
//		header("Content-Type: text/html; charset=utf-8");
//		$un32ID=input('get.un32ID');//房间ID
//		$roompwd=input('get.roompwd');//房间号
//		set_time_limit(0);
//		$host=config('host');
//		$port=config('port');
//		$socket=socket_create(AF_INET,SOCK_STREAM,SOL_TCP);
//		if($socket==false){
//			return $this->error('暂时无法查看，请稍后点击！');
//		}
//		if(@$conn=socket_connect($socket,$host,$port)==false){
//			return $this->error('暂时无法查看，请稍后点击！');
//		}
//		$user_id=session('user_id');
//		$info=Db::name('admin')->where('id',$user_id)->find();
//		$sendlen=strlen($info['username'])+12+32+4+4+4;
//		$i=strlen($info['username']);
//		// 向socket服务器发送消息
//		if(!socket_write($socket, pack("IIIa{$i}Ia32II",$sendlen,config('tuiguoroom'),$i,$info['username'],32,$info['password'],$un32ID,$roompwd))){
//			return $this->error('暂时无法查看，请稍后点击！');
//		}
//		// 读取socket服务器发送的消息
//		while ($out = @socket_read($socket, 8192)) {
//			//var_dump($out);
//			$len=strlen($out);
//			$arr2=unpack('Isize/IProtocolID/Ilength',$out);
//			//var_dump($arr2);
//			if($len!=$arr2[0]){
//				return $this->error('数据有误，请稍后查看！');
//			}
//			switch($arr2[1]){
//				case config('tuiguoroom')://协议号
//					$group=($len-3)/3;
//						if($group!=$arr2[2]){
//							return $this->error('暂时无法查看，请稍后点击！');
//						}
//						$userinfo=array();
//						for($i=1;$i<=$group;$i++){
//							$a=3*$i;
//							$b=4*$i;
//							$c=5*$i;
//							$d=6*$i;
//							$userinfo[$i]['uid']=$arr2[$a];
//							$userinfo[$i]['nickname']=$arr2[$b];
//							$userinfo[$i]['socre']=$arr2[$c];
//							$userinfo[$i]['gold']=$arr2[$d];
//						}
//					$this->assign('userinfo', $userinfo);
//					return $this->fetch('socket');
//					break;
//			}
//		}
//		$this->error('暂时无法查看，请稍后点击！');
	}





















}