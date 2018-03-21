<?php
namespace application\admin\controller;

use application\admin\model\Gameroom;
use application\admin\model\Gameuser;
use application\admin\model\Pumpwaterrecord;
use application\admin\model\Tuitongroom;
use think\Db;
use think\Model;
use application\admin\model\Gamebetrecord;
use think\Request;
use application\admin\model\GameroomtemplateTuitongzi;
class GameTuiTongController extends CommonController{
	//显示所有大厅(二期再加)
	public function index(){
// 		$data=['a','b','c',1,2,3];
// 		return json(['data'=>$data,'code'=>1,'message'=>'操作完成']);
		return $this->fetch();
	}
	
	//大厅里面的房间展示
	public function show(){
        $role=session('user_role');
        $inputId=input('get.mid');
        $inputRole=input('get.role');
        $data=$this->getSearchWhere($role);
        if($inputId){
            switch ($inputRole){
                case 'xl':
                    $parentId=Db::name('merchant')->where('levelIndex','like',"%$inputId%")->column('mid');
                    if(!count($parentId)){
                        $this->error('该线路下无商户无玩家信息');
                    }
                    $userids=Db::name('gameuser')->where('parentId','in',$parentId)->column('un32UserID');
                    break;
                case 'sh':
                    $userids=Db::name('gameuser')->where('parentId',$inputId)->column('un32UserID');
                    break;
                case 'dl':
                    $parentId=Db::name('merchant')->where('levelIndex','like',"%$inputId%")->column('mid');
                    $parentId[]=$inputId;
                    $userids=Db::name('gameuser')->where('parentId','in',$parentId)->column('un32UserID');
                    break;
            }
        }else{
            $userids = Db::name('gameuser')->where($this->come_where)->column('un32UserID');
        }
        if(count($userids)){
            $rooms = Db::table(config('tuitongzi_db.db1').'.'.config('database.prefix').'gameroom')->alias('g')->join(config('database.database').'.'.config('database.prefix').'gameuser u','g.un32OwnerUserID=u.un32UserID')->where("g.un32OwnerUserID",'in',$userids)->order('g.un64ID','desc')->paginate(20,false,['query' => request()->param()]);
            $empty=array();
            foreach($rooms as $k=>$v){
                $un32ID=$v['un64ID'];
                $total=Db::table(config('tuitongzi_db.db1').'.'.config('database.prefix').'pumpwaterrecord')->where('un64GameRoomID',$un32ID)->sum('n32PumpWaterNum');
                $empty[$un32ID]['total']=$total;
            }
        }else{
            $this->error('无玩家信息！');
        }
        if(isset($data['xl'])){
            $this->assign('data1',$data['xl']);
        }
        if(isset($data['sh'])){
            $this->assign('data2',$data['sh']);
        }
        if(isset($data['dl'])){
            $this->assign('data3',$data['dl']);
        }
        $this->assign('role',$role);
		$this->assign('rooms', $rooms);
		$this->assign('empty', $empty);
		$this->assign('time', time());
		return $this->fetch();
	}
	
	//房间详细信息
	public function details(){
		$un32ID=input('get.un32ID');//房间ID
		$roompwd=input('get.roompwd');//房间号
		if($un32ID){
			$un32TotalAnte=Db::table(config('tuitongzi_db.db1').'.'.config('database.prefix').'gameroom')->field('un32TotalAnte')->where('un64ID',$un32ID)->find();

			$total=Db::table(config('tuitongzi_db.db1').'.'.config('database.prefix').'pumpwaterrecord')->where('un64GameRoomID',$un32ID)->sum('n32PumpWaterNum');
			$infos=Db::table(config('tuitongzi_db.db1').'.'.config('database.prefix').'pumpwaterrecord')->alias('p')->join(config('database.database').'.'.config('database.prefix').'gameuser g','p.un32GameBankerID=g.un32UserID')->where('p.un64GameRoomID',$un32ID)->order('p.un32LogTime asc')->select();
			foreach($infos as $k=>$v){
				if(($v['n32BottonOfPotNum']-$un32TotalAnte['un32TotalAnte'])>0){
					$infos[$k]['state']='赢';
				}else{
					$infos[$k]['state']='输';
				}
			}
			$this->assign('guodi',$un32TotalAnte['un32TotalAnte']);
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
		$infos = Db::table(config('tuitongzi_db.db1').'.'.config('database.prefix').'gameroundrecord')->where('un64GameRoomID',$roomid)->where('un32GameJuID',$juid)->select();
		$count = Db::table(config('tuitongzi_db.db1').'.'.config('database.prefix').'gameroundrecord')->where('un64GameRoomID',$roomid)->where('un32GameJuID',$juid)->count();
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
		$roompwd=input('get.roompwd');
		if($huiid==$count){//判断是不是最后一回合
			$pums=Db::table(config('tuitongzi_db.db1').'.'.config('database.prefix').'pumpwaterrecord')->where('un64GameRoomID',$roomid)->where('un32GameJuID',$juid)->find();
			$fPumpWaterPercent=$pums['fPumpWaterPercent'];//抽水比例
			$n32PumpWaterNum=$pums['n32PumpWaterNum'];//抽水数量
			$n32BottonOfPotNum=$pums['n32BottonOfPotNum']-$n32PumpWaterNum;//实际收益
			$this->assign('info1',$fPumpWaterPercent);
			$this->assign('info2',$n32PumpWaterNum);
			$this->assign('info3',$n32BottonOfPotNum);
			$this->assign('count',$count);
		}
		$infos = Db::table(config('tuitongzi_db.db1').'.'.config('database.prefix').'gamebetrecord')->alias('b')->join(config('database.database').'.'.config('database.prefix').'gameuser g','b.un32PlayerID=g.un32UserID')->where('b.un64GameRoomID',$roomid)->where('b.un32GameJuID',$juid)->where('b.un32GameRoundID',$huiid)->order('eIdentity asc')->select();
		if($infos){
			$this->assign('roompwd',$roompwd);
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
        $role=session('user_role');
        $data=$this->getSearchWhere($role);
        $userids = Db::name('gameuser')->where($this->come_where)->column('un32UserID');
        if(!count($userids)){
            $this->error('无玩家信息！');
        }
        $rooms = Db::table(config('tuitongzi_db.db1').'.'.config('database.prefix').'gameroom')->alias('g')->join(config('database.database').'.'.config('database.prefix').'gameuser u','g.un32OwnerUserID=u.un32UserID')->where('g.n32GameRoomPwd','like',"%$n32GameRoomPwd%")->where("g.un32OwnerUserID",'in',$userids)->paginate(20);
        $empty=array();
        foreach($rooms as $k=>$v){
            $un32ID=$v['un32ID'];
            $total=Db::table(config('tuitongzi_db.db1').'.'.config('database.prefix').'pumpwaterrecord')->where('un64GameRoomID',$un32ID)->sum('n32PumpWaterNum');
            //$rooms[$k]['total']=$total;
            $empty[$un32ID]['total']=$total;
        }
        if(isset($data['xl'])){
            $this->assign('data1',$data['xl']);
        }
        if(isset($data['sh'])){
            $this->assign('data2',$data['sh']);
        }
        if(isset($data['dl'])){
            $this->assign('data3',$data['dl']);
        }
        $this->assign('role',$role);
        $this->assign('rooms', $rooms);
        $this->assign('empty', $empty);
        return $this->fetch('show');

	}
	//根据用户名来查询房间
	public function likeuser(){
		$szUserName=input('post.szUserName');
        $role=session('user_role');
        $data=$this->getSearchWhere($role);
        $userids = Db::name('gameuser')->where($this->come_where)->column('un32UserID');
        if(!count($userids)){
            $this->error('无玩家信息！');
        }
        $rooms = Db::table(config('tuitongzi_db.db1').'.'.config('database.prefix').'gameroom')->alias('g')->join(config('database.database').'.'.config('database.prefix').'gameuser u','g.un32OwnerUserID=u.un32UserID')->where('u.szUserName','like',"%$szUserName%")->where("g.un32OwnerUserID",'in',$userids)->paginate(20);
        $empty=array();
        foreach($rooms as $k=>$v){
            $un32ID=$v['un32ID'];
            $total=Db::table(config('tuitongzi_db.db1').'.'.config('database.prefix').'pumpwaterrecord')->where('un64GameRoomID',$un32ID)->sum('n32PumpWaterNum');
            //$rooms[$k]['total']=$total;
            $empty[$un32ID]['total']=$total;
        }
        if(isset($data['xl'])){
            $this->assign('data1',$data['xl']);
        }
        if(isset($data['sh'])){
            $this->assign('data2',$data['sh']);
        }
        if(isset($data['dl'])){
            $this->assign('data3',$data['dl']);
        }
        $this->assign('role',$role);
        $this->assign('rooms', $rooms);
		$this->assign('empty', $empty);
        return $this->fetch('show');

	}

	//系统模板展示
	public function template(){
//		if($this->merch_id !=10000){
//			$info=Db::name('gameroomtemplate_tuitongzi')->where(['merchantId'=>$this->merch_id])->find();
//			if(!$info){
//				$data=[
//					'szName'=>'系统模板',
//					'un32UserID'=>0,
//					'bIfTax'=>1,
//					'fWinTaxRate'=>10,
//					'fLoseTaxRate'=>5,
//					'un32TotalAnte'=>5000,
//					'bIfLookOn'=>1,
//					'un32OnLookerNum'=>10,
//					'un32InitScore'=>10000,
//					'eForbidChat'=>0,
//					'un32SingleScore'=>500,
//					'merchantId'=>$this->merch_id,
//					'un32IfActive'=>1
//				];
//
//				Db::name('gameroomtemplate_tuitongzi')->insert($data);
//			}
//		}
		$info=Db::name('gameroomtemplate_tuitongzi')->where(['un32UserID'=>0])->where('merchantId','in',$this->come_where)->order('un32ID desc')->paginate(20);
		$this->assign('info', $info);
		return $this->fetch();
	}
	//添加模板
	public function addtemplate(){
		if(Request::instance()->isPost()){
			$data=input();
			$result = $this->validate($data,'GameroomtemplateTuitongzi');
			if (true !== $result) {
				$this->error($result,url('template'),'',1);
			}else{
				$data['merchantId']=$this->merch_id;
				$template = new GameroomtemplateTuitongzi();
				$result=$template->allowField(true)->save($data);
				if($result){
					//连接服务器
					$host=config('host');
					$port=config('port');
					$protectId=config('systemtel');
					$jintinginfo=$this->gameListen($host,$port,$protectId);
					$this->success('操作成功'.$jintinginfo, url('template'),'',1);
				}else{
					$this->error('操作失败',url('template'),'',1);
				}
			}
		}else{
			return $this->fetch();
		}
	}
	//修改模板
	public function edittem(){
		if(Request::instance()->isPost()){
			$data=input();
			$result = $this->validate($data,'GameroomtemplateTuitongzi');
			if (true !== $result) {
				$this->error($result,url('template'),'',1);
			}else{
				$template = new GameroomtemplateTuitongzi();
				$result=$template->allowField(true)->save($data,['un32ID' => $data['un32ID']]);
				if($result){
					//连接服务器
					$host=config('host');
					$port=config('port');
					$protectId=config('systemtel');
					$jintinginfo=$this->gameListen($host,$port,$protectId);
					$this->success('操作成功'.$jintinginfo, url('template'),'',1);
				}else{
					$this->error('操作失败',url('template'),'',1);
				}
			}
		}else{
			$id=input('id');
			if($id){
				$template = new GameroomtemplateTuitongzi();
				$info=$template->where('un32ID',$id)->find();
				$this->assign('info',$info);
				return $this->fetch('addtemplate');
			}else{
				$this->error('页面丢失！');
			}
		}
	}
	//删除模板
	public function deltem(){
		$id=input('id');
		if($id){
			//$res=Db::name('gameroomtemplateTuiguo')->delete($id);
			$info=GameroomtemplateTuitongzi::get($id);
			if($info->un32IfActive==1){
				$this->error('激活中的模板不能删除！');
			}
			$res=GameroomtemplateTuitongzi::destroy($id);
			if($res){
				//连接服务器
				$host=config('host');
				$port=config('port');
				$protectId=config('systemtel');
				$jintinginfo=$this->gameListen($host,$port,$protectId);
				$this->success('操作成功'.$jintinginfo, url('template'),'',1);
			}else{
				$this->error('操作失败');
			}
		}else{
			$this->error('没有该页面');
		}
	}
	//应用模板
	public function activetem(){
		$id=input('id');
		if($id){
			$template = new GameroomtemplateTuitongzi();
			$merchantId=$this->merch_id;
			if($merchantId !=10000) {
				$res1=$template->where('un32ID',$id)->where('un32UserID',0)->where($this->come_where)->update(['un32IfActive'=>1]);
				$res2=$template->where('un32ID','<>',$id)->where('un32UserID',0)->where($this->come_where)->update(['un32IfActive'=>0]);
				if($res1){
					//连接服务器
					$host=config('host');
					$port=config('port');
					$protectId=config('systemtel');
					$jintinginfo=$this->gameListen($host,$port,$protectId);
					$this->success('操作成功'.$jintinginfo, url('template'),'',1);
				}else{
					$this->error('操作失败');
				}
			}else{
				$res1=$template->where('un32ID',$id)->where('un32UserID',0)->update(['un32IfActive'=>1]);
				$res2=$template->where('un32ID','<>',$id)->where('un32UserID',0)->update(['un32IfActive'=>0]);
				if($res1){
					$this->success('操作成功', url('template'),'',1);
				}else{
					$this->error('操作失败');
				}
			}
		}else{
			$this->error('没有该页面');
		}
	}
	//解除应用模板
	public function disactivetem(){
		$id=input('id');
		if($id){
			$template = new GameroomtemplateTuitongzi();
			$count=$template->where('un32UserID',0)->where(['un32IfActive'=>1])->where('un32ID','<>',$id)->where($this->come_where)->find();
			if(!$count){
				$this->error('激活其他模板即可解除！');
			}
			$res1=$template->where('un32ID',$id)->where('un32UserID',0)->update(['un32IfActive'=>0]);
			if($res1){
				//连接服务器
				$host=config('host');
				$port=config('port');
				$protectId=config('systemtel');
				$jintinginfo=$this->gameListen($host,$port,$protectId);
				$this->success('操作成功'.$jintinginfo, url('template'),'',1);
			}else{
				$this->error('操作失败');
			}
		}else{
			$this->error('没有该页面');
		}
	}
	//玩家模板
	public function gameUserTel(){
        $userids = Db::name('gameuser')->field('un32UserID')->where($this->come_where)->select();
        $arrId = array();
        if(count($userids)){
            foreach ($userids as $v) {
                $arrId[] = $v['un32UserID'];
            }
            $info=Db::name('gameroomtemplate_tuitongzi')->alias('p')->join(config('database.database').'.'.config('database.prefix').'gameuser g','p.un32UserID=g.un32UserID')->where('p.un32UserID','in',$arrId)->order('p.un32ID desc')->paginate(15);
            $this->assign('info', $info);
        }else{
            $this->error('暂无玩家模板！');
        }
		return $this->fetch();
	}
	//删除玩家模板
	public function userdeltem(){
		$id=input('id');
		if($id){
			$res=GameroomtemplateTuitongzi::destroy($id);
			if($res){
				$this->success('操作成功', url('gameUserTel'),'',1);
			}else{
				$this->error('操作失败');
			}
		}else{
			$this->error('没有该页面');
		}
	}
	//设置搓牌时间
    public function timeindex(){
        $infos=Db::name('settime_tuitongzi')->where('merchantId','in',$this->come_where)->paginate(20);
        $this->assign('infos',$infos);
        return $this->fetch('timeindex');
    }

	public function edittime(){
		if(Request::instance()->isPost()){
			$data=input('post.');
			$info=Db::name('settime_tuitongzi')->where('id',$data['id'])->find();
			if($info){//更新
				$result=Db::name('settime_tuitongzi')->where(['id'=>$data['id']])->update($data);
                if($result){
                    //连接服务器
                    $host=config('host');
                    $port=config('port');
                    $protectId=config('settime');
                    $jintinginfo=$this->gameListen($host,$port,$protectId);
                    $this->success('操作成功'.$jintinginfo, url('timeindex'),'',1);
                }else{
                    $this->error('操作失败',url('timeindex'),'',1);
                }
			}else{
                $this->error('操作失败',url('timeindex'),'',1);
			}

		}else{
		    $id=input('get.id');
			$info=Db::name('settime_tuitongzi')->where('merchantId','in',$this->come_where)->where('id',$id)->find();
			$this->assign('info',$info);
			return $this->fetch('edittime');
		}
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