<?php
/**
 * 对邮件、公告、建议操作
 */

namespace application\admin\controller;
use application\admin\model\SettimeTuiguo;
use think\Db;
use think\Request;
use application\admin\model\Info as InfoModel;
use application\admin\validate\Gamemail;
use application\admin\model\Broadcast as BCModel;
use application\admin\validate\Roomshopping;
use application\admin\model\GameroomtemplateTuiguo;
class SystemController extends CommonController{
	//显示历史公告
 	public function index(){		
 		$lists = Db::name('broadcast')->alias('b')->join(config('database.prefix')."gameserver g",'b.un32HallID=g.un32GameServerID')->where($this->come_where)->order('b.id desc')->paginate(20);
 		//$lists = Db::table(config('tuiguo_db.db1').'.'.config('database.prefix').'broadcast')->order('id desc')->paginate(20);//可以成功
 		$this->assign('lists', $lists);
 		return $this->fetch();
 	}
	
	//发布公告
	public function announce(){		
		if(Request::instance()->isPost()){
			$time=time();
			$data=input();
			//var_dump($data);exit;
			//$broadcast=new BCModel();
			$result = $this->validate($data,'Broadcast');
			if (true !== $result) {
				return $this->error($result,url('announce'),'',1);
			}
			$content=trim(input('post.content'));
			if(strlen($content)>=600){
				return $this->error('内容长度超过200个汉字！');
			}
			$interval=input('post.hour')*3600+input('post.minute')*60+input('post.second');
			$start_time=strtotime(input('post.s_time'));
			$end_time=strtotime(input('post.e_time'));
			if($start_time>=$end_time || $end_time<$time){
				return $this->error('开始或结束时间有误！');
			}
			$un32GameKindID= input('post.un32GameKindID');
			$kindId=Db::name('gameserver')->field('un32GameServerID')->where('un32GameKindID',$un32GameKindID)->select();
			foreach ($kindId as $item) {
				$un32HallID=$item['un32GameServerID'];
				$info=[
					'content'=>$content,
					'un32HallID'=>$un32HallID,
					'time'=>$time,
					'start_time'=>$start_time,
					'end_time'=>$end_time,
					'interval'=>$interval,
					'merchantId'=>$this->merch_id,
				];
				$res=Db::name('broadcast')->insert($info);
			}

			//$res=$broadcast->allowField(true)->validate(true)->save($data);
			if($res){
//				$userId = Db::name('broadcast')->getLastInsID();
//				//连接服务器
//				$host=config('host');
//				$port=config('port');
//				$socket=socket_create(AF_INET,SOCK_STREAM,SOL_TCP);
//				if($socket==false){
//					//return $this->error('暂时无法查看，请稍后点击！');
//					$jintinginfo="但是监听失败！";
//				}
//				if(@$conn=socket_connect($socket,$host,$port)==false){
//					$jintinginfo="但是监听失败！";
//				}
//				$user_id=session('user_id');
//				$info=Db::name('admin')->where('id',$user_id)->find();
//				$length=strlen($info['username']);
//				$sendlen=$length+4+4+4+4+32+4;
//				// 向socket服务器发送消息
//				if(!@socket_write($socket, pack("IIIa{$length}Ia32I",$sendlen,config('broadcasttocs'),$length,$info['username'],32,$info['password'],$userId))){
//					$jintinginfo="但是监听失败！";
//				}
				//连接服务器
				$host=config('host');
				$port=config('port');
				$protectId=config('broadcasttocs');
				$jintinginfo=$this->gameListen($host,$port,$protectId);
				$this->success('操作成功'.$jintinginfo, url('index'),'',1);
			}else{
				$this->error('操作失败',url('index'),'',1);
			}
		}else{
		    //定义一个数组 1=》10000代表推锅,参考admingroup和gaemserver表来
            $data=[
                '1'=>'10000',//推锅
                '2'=>'10001',//推筒子
                '3'=>'10002',//牌九
            ];
			$res=Db::name('gameserver')->select();
			$arr=array();
			foreach($res as $k=>$v){
				$arr[$k]=$v['un32GameKindID'];
			}
			$arr=array_unique($arr);
			$this->assign('res', $arr);
			return $this->fetch();
		}		
	}
	//查看公告详细信息
	public function show(){
		$id=input('id');
		if($id){
			$info = Db::name('broadcast')->alias('b')->join(config('database.prefix')."gameserver g",'b.un32HallID=g.un32GameServerID')->where('b.id',$id)->find();
			$this->assign('info', $info);			
			return $this->fetch();
		}else{
			$this->error('页面丢失！');
		}
	}
	//修改公告
	public function editbc(){
		if(Request::instance()->isPost()){
			$data=input();
			$result = $this->validate($data,'Broadcast');
			if (true !== $result) {
				$this->error($result,url('index'),'',1);
			}else{
				$interval=input('post.hour')*3600+input('post.minute')*60+input('post.second');
				$start_time=strtotime(input('post.s_time'));
				$end_time=strtotime(input('post.e_time'));
				$broadcast           = BCModel::get($data['id']);
				$broadcast->content = $data['content'];
				//$broadcast->un32HallID = $data['un32HallID'];
				$broadcast->time    = time();
				$broadcast->interval    = $interval;
				$broadcast->start_time    = $start_time;
				$broadcast->end_time  = $end_time;
				if($broadcast->save()){
//					//连接服务器
//					$host=config('host');
//					$port=config('port');
//					$socket=socket_create(AF_INET,SOCK_STREAM,SOL_TCP);
//					if($socket==false){
//						$jintinginfo="但是监听失败！";
//					}
//					if(@$conn=socket_connect($socket,$host,$port)==false){
//						$jintinginfo="但是监听失败！";
//					}
//					$user_id=session('user_id');
//					$info=Db::name('admin')->where('id',$user_id)->find();
//					$length=strlen($info['username']);
//					$sendlen=$length+4+4+4+4+32+4;
//					// 向socket服务器发送消息
//					if(!@socket_write($socket, pack("IIIa{$length}Ia32I",$sendlen,config('broadcasttocs'),$length,$info['username'],32,$info['password'],$data['id']))){
//						$jintinginfo="但是监听失败！";
//					}
					//连接服务器
					$host=config('host');
					$port=config('port');
					$protectId=config('broadcasttocs');
					$jintinginfo=$this->gameListen($host,$port,$protectId);
					$this->success('修改成功'.$jintinginfo, url('index'),'',1);
				}else{
					$this->error($broadcast->getError(),url('index'),'',1);
				}
			}  
		}else{
			$id=input('id');
			if($id){
				$info = Db::name('broadcast')->alias('b')->join(config('database.prefix')."gameserver g",'b.un32HallID=g.un32GameServerID')->where('b.id',$id)->find();
				$this->assign('info', $info);
				//var_dump($info);exit;
				$hour=floor($info['interval']/3600);
				$minute=floor(($info['interval']-$hour*3600)/60);
				$second=$info['interval']-$hour*3600-$minute*60;
				$this->assign('hour',$hour);
				$this->assign('minute',$minute);
				$this->assign('second',$second);
				$this->assign('type',1);//标识为修改
				return $this->fetch('announce');
			}else{
				$this->error('页面丢失');
			}
		}
	}
	//删除公告
	public function del(){		
		$id=input('id');
		if($id){
			$res=Db::name('broadcast')->where('id',$id)->delete();
			if($res){
				//连接服务器
//				$host=config('host');
//				$port=config('port');
//				$socket=socket_create(AF_INET,SOCK_STREAM,SOL_TCP);
//				if($socket==false){
//					$jintinginfo="但是监听失败！";
//				}
//				if(@$conn=socket_connect($socket,$host,$port)==false){
//					$jintinginfo="但是监听失败！";
//				}
//				$user_id=session('user_id');
//				$info=Db::name('admin')->where('id',$user_id)->find();
//				$length=strlen($info['username']);
//				$sendlen=$length+4+4+4+4+32+4;
//				// 向socket服务器发送消息
//				if(!@socket_write($socket, pack("IIIa{$length}Ia32I",$sendlen,config('broadcasttocs'),$length,$info['username'],32,$info['password'],$id))){
//					$jintinginfo="但是监听失败！";
//				}
				//连接服务器
				$host=config('host');
				$port=config('port');
				$protectId=config('broadcasttocs');
				$jintinginfo=$this->gameListen($host,$port,$protectId);
				$this->success('删除成功'.$jintinginfo, url('index'),'',1);
			}else{
				$this->error('删除失败');
			}
		}else{
			$this->error('没有该页面');
		}
	}
	//查看历史邮件
	public function showmail(){
//		$merchantId=$this->merch_id;
//		if($merchantId !=10000){
//			$userids=Db::name('gameuser')->field('un32UserID')->where('merchantId',$merchantId)->select();
//			$arrId=array();
//			foreach($userids as $v){
//				$arrId[]=$v['un32UserID'];
//			}
//			//var_dump($arrId);exit;
//			$lists = Db::name('gamemail')->where('fromto','in',$arrId)->order('id desc')->paginate(20);
//		}else{
//			$lists = Db::name('gamemail')->order('id desc')->paginate(20);
//		}
		$lists = Db::name('gamemail')->where($this->come_where)->order('id desc')->paginate(20);
		$this->assign('lists', $lists);	
		return $this->fetch('showmail');
	}
	//显示某个指定邮件信息
	public function showinfo(){
		$id=input('id');
		if($id){
			$info = Db::name('gamemail')->where('id',$id)->find();
			$this->assign('info', $info);
			return $this->fetch();
		}else{
			$this->error('页面丢失！');
		}
	}
	//发布系统邮件all
	public function sendmail(){
		if(Request::instance()->isPost()){
			$data=input();
			$result = $this->validate($data,'Gamemail');
			if (true !== $result) {
				$this->error($result,url('showmail'),'',1);
			}else{
				//发送所有玩家 写入多条
//				$lists = Db::name('gameuser')->where('status', 1)->column('un32UserID');
//				for($i=0;$i<count($lists);$i++){
//					$result=Db::name('gamemail')->insert([ 'title' => $data['title'], 'content' => $data['content'],'from'=>'系统管理员','fromto'=>$lists[$i],'time'=>time()]);
//				}
				//只写一条
				$result=Db::name('gamemail')->insert([ 'title' => $data['title'], 'content' => $data['content'],'from'=>'系统管理员','fromto'=>0,'time'=>time(),'merchantId'=>$this->merch_id]);
				if($result){
					$mailId = Db::name('gamemail')->getLastInsID();
					//连接服务器
//					$host=config('host');
//					$port=config('port');
//					$socket=socket_create(AF_INET,SOCK_STREAM,SOL_TCP);
//					if($socket==false){
//						$jintinginfo="但是监听失败！";
//					}
//					if(@$conn=socket_connect($socket,$host,$port)==false){
//						$jintinginfo="但是监听失败！";
//					}
//					$user_id=session('user_id');
//					$info=Db::name('admin')->where('id',$user_id)->find();
//					$length=strlen($info['username']);
//					$sendlen=$length+4+4+4+4+32+4;
//					// 向socket服务器发送消息
//					if(!@socket_write($socket, pack("IIIa{$length}Ia32I",$sendlen,config('mailtocs'),$length,$info['username'],32,$info['password'],$mailId))){
//						$jintinginfo="但是监听失败！";
//					}
					//连接服务器
					$host=config('host');
					$port=config('port');
					$protectId=config('mailtocs');
					$jintinginfo=$this->gameListen($host,$port,$protectId);

					$this->success('操作成功'.$jintinginfo, url('showmail'),'',1);
				}else{
					$this->error('操作失败',url('showmail'),'',1);
				}
			}
		}else{
			return $this->fetch('sendmail');
		}
	}
	//发布邮件一个或多个
	public function sendmailone(){

	}
	//修改邮件内容
	public function editmail(){
		if(Request::instance()->isPost()){
			$data=input();
			$result = $this->validate($data,'Gamemail');
			if (true !== $result) {
				$this->error($result);
			}else{
				$result=Db::name('gamemail')->where('id',$data['id'])->update([ 'title' => $data['title'], 'content' => $data['content'],'time'=>time()]);
				if($result){
					$this->success('操作成功', url('showmail'),'',1);
				}else{
					$this->error('操作失败',url('showmail'),'',1);
				}
			}
		}else{
			$id=input('id');
			if($id){
				$info=Db::name('gamemail')->where('id',$id)->find();
				$this->assign('info',$info);
				return $this->fetch('sendmail');
			}else{
				$this->error('页面丢失！');
			}
		}		
	}
	//删除邮件
	public function delmail(){
		$id=input('id');
		if($id){
			$res=Db::name('gamemail')->delete($id);
			if($res){
				$this->success('操作成功', url('showmail'),'',1);
			}else{
				$this->error('操作失败');
			}
		}else{
			$this->error('没有该页面');
		}
	}
	//帮助手册
	public function help(){
		$lists = Db::name('help')->order('id desc')->paginate(15);
		$this->assign('type', 3);
		$this->assign('lists', $lists);		
		return $this->fetch('help');
	}
	//添加帮助手册
	public function addhelp(){
		if(Request::instance()->isPost()){
			$data=Request::instance()->param();

			$res=Db::name('help')->insert($data);

			if($res){
				$this->success('操作成功', url('help'),'',1);
			}else{
				$this->error('操作失败',url('help'),'',1);
			}
		}else{
			return $this->fetch('addhelp');
		}
	}
	//编辑手册
	public function edithelp(){
		if(Request::instance()->isPost()){
			$data=Request::instance()->param();
			$res=Db::name('help')->update($data);
			//$res=$info->allowField(true)->save($data);
			if($res){
				$this->success('操作成功', url('help'),'',1);
			}else{
				$this->error('操作失败',url('help'),'',1);
			}
		}else{
			$id=input('id');
			if($id){
				$info = Db::name('help')->where('id',$id)->find();
				$this->assign('info', $info);
				return $this->fetch('addhelp');
			}else{
				$this->error('非法操作');
			}
		}
	}
	//显示手册详细信息
	public function showhelp(){
		$id=input('id');
		if($id){
			$info = Db::name('help')->where('id',$id)->find();
			$this->assign('info', $info);
			return $this->fetch();
		}else{
			$this->error('没有该页面');
		}
	}
	//删除手册
	public function delhelp(){
		$id=input('id');
		if($id){
			$res=db('help')->delete($id);
			if($res){
				$this->success('操作成功', url('help'),'',1);
			}else{
				$this->error('操作失败');
			}
		}else{
			$this->error('没有该页面');
		}
	}
	//玩家反馈
	public function propose(){
		$merchantId=$this->merch_id;
		if($merchantId !=10000) {
			$userids = Db::name('gameuser')->field('un32UserID')->where('merchantId', $merchantId)->select();
			$arrId = array();
			if($userids){
				foreach ($userids as $v) {
					$arrId[] = $v['un32UserID'];
				}
				$lists = Db::name('userfeedback')->where("un32GameUserID",'in',$arrId)->order('un32ID desc')->paginate(15);
			}else{
				$this->error('暂未玩家反馈！');
			}

		}else{
			$lists = Db::name('userfeedback')->order('un32ID desc')->paginate(15);
		}
		$this->assign('lists', $lists);		
		return $this->fetch();
	}
	//显示玩家反馈详情
	public function showpro(){
		$id=input('id');
		if($id){
			$info = Db::name('userfeedback')->where('un32ID',$id)->find();
			$this->assign('info', $info);
			return $this->fetch();
		}else{
			$this->error('没有该页面');
		}
	}
	//删除反馈信息
	public function delpro(){
		$id=input('id');
		if($id){
			$res=db('userfeedback')->delete($id);
			if($res){
				$this->success('操作成功', url('propose'),'',1);
			}else{
				$this->error('操作失败');
			}
		}else{
			$this->error('没有该页面');
		}
	}
	//系统模板展示
	public function template(){
		$template=new GameroomtemplateTuiguo();
//		if($this->merch_id[0] !=10000){
//			$info=$template->where(['merchantId'=>$this->merch_id])->find();
//			if(!$info){
//				$template->data([
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
//					'un32IfActive'=>1,//应用
//				]);
//				$template->save();
//			}
//		}
		$info=$template->where(['un32UserID'=>0])->where('merchantId','in',$this->come_where)->order('un32ID desc')->paginate(15);
		$this->assign('info', $info);
		return $this->fetch();
	}
	//添加模板
	public function addtemplate(){
		if(Request::instance()->isPost()){
			$data=input();
			$result = $this->validate($data,'GameroomtemplateTuiguo');
			if (true !== $result) {
				$this->error($result,url('template'),'',1);
			}else{
				$data['merchantId']=$this->merch_id;
				$template = new GameroomtemplateTuiguo();
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
			$result = $this->validate($data,'GameroomtemplateTuiguo');
			if (true !== $result) {
				$this->error($result,url('template'),'',1);
			}else{
				$template = new GameroomtemplateTuiguo();
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
				$template = new GameroomtemplateTuiguo();
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
			$info=GameroomtemplateTuiguo::get($id);
			if($info->un32IfActive==1){
				$this->error('激活中的模板不能删除！');
			}
			$res=GameroomtemplateTuiguo::destroy($id);
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
			$template = new GameroomtemplateTuiguo();
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
			$template = new GameroomtemplateTuiguo();
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
		$template=new GameroomtemplateTuiguo();
        $userids = Db::name('gameuser')->field('un32UserID')->where($this->come_where)->select();
        $arrId = array();
        if(count($userids)){
            foreach ($userids as $v) {
                $arrId[] = $v['un32UserID'];
            }
            $info=$template->alias('p')->join(config('database.database').'.'.config('database.prefix').'gameuser g','p.un32UserID=g.un32UserID')->where('p.un32UserID','in',$arrId)->order('p.un32ID desc')->paginate(20);
        }else{
            $this->error('暂无玩家模板！！');
        }
        $this->assign('info', $info);
		return $this->fetch();
	}
	//删除玩家模板
	public function userdeltem(){
		$id=input('id');
		if($id){
			$res=GameroomtemplateTuiguo::destroy($id);
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
        $template = new SettimeTuiguo();
        $infos=$template->where('merchantId','in',$this->come_where)->paginate(20);
        $this->assign('infos',$infos);
        return $this->fetch();
    }

//修改时间表单验证
	public function edittime(){
		if(Request::instance()->isPost()){
			$data=input('post.');
			$template = new SettimeTuiguo();
			$info=$template->where('id',$data['id'])->find();
			if($info){//更新
				$result=$template->allowField(true)->save($data,['id'=>$info['id']]);
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
			}else{//添加
                $this->error('操作失败',url('timeindex'),'',1);
			}

		}else{
		    $id=input('id');
			$template = new SettimeTuiguo();
			$info=$template->where('merchantId','in',$this->come_where)->where('id',$id)->find();
			$this->assign('info',$info);
			return $this->fetch('edittime');
		}
	}
	//房卡商店
	public function roomcard(){
		if($this->merch_id !=10000){
			$lists = Db::name('roomshopping')->where($this->come_where)->paginate(6);
			if(count($lists)!=6){//初始的时候没有
				$data1=[
					'roomcard'=>10,
					'coins'=>5,
					'state'=>0,
					'merchantId'=>$this->merch_id,
				];
				Db::name('roomshopping')->insert($data1);
				$data2=[
					'roomcard'=>24,
					'coins'=>12,
					'state'=>0,
					'merchantId'=>$this->merch_id,
				];
				Db::name('roomshopping')->insert($data2);
				$data3=[
					'roomcard'=>72,
					'coins'=>36,
					'state'=>0,
					'merchantId'=>$this->merch_id,
				];
				Db::name('roomshopping')->insert($data3);
				$data4=[
					'roomcard'=>96,
					'coins'=>48,
					'state'=>0,
					'merchantId'=>$this->merch_id,
				];
				Db::name('roomshopping')->insert($data4);
				$data5=[
					'roomcard'=>120,
					'coins'=>60,
					'state'=>0,
					'merchantId'=>$this->merch_id,
				];
				Db::name('roomshopping')->insert($data5);
				$data6=[
					'roomcard'=>144,
					'coins'=>72,
					'state'=>0,
					'merchantId'=>$this->merch_id,
				];
				Db::name('roomshopping')->insert($data6);
			}
		}
		$lists = Db::name('roomshopping')->where($this->come_where)->limit(6)->select();
		$this->assign('lists', $lists);
		return $this->fetch();
	}

	//修改商店配置
	public function editrc(){
		if(Request::instance()->isPost()){
			$data=input();
			//var_dump($data);exit;
			$result = $this->validate($data,'Roomshopping');
			if (true !== $result) {
				$this->error($result,url('roomcard'),'',1);
			}else{
				isset($data['state'])?$data['state']=1:$data['state']=0;
				$res=Db::name('roomshopping')->update($data);
				if($res){
					//连接服务器
					$host=config('host');
					$port=config('port');
					$protectId=config('shoptocs');
					$jintinginfo=$this->gameListen($host,$port,$protectId);
					$this->success('修改成功'.$jintinginfo, url('roomcard'),'',1);
				}else{
					$this->error('修改失败',url('roomcard'),'',1);
				}
			}
		}else{
			$id=input('id');
			if($id){
				$info = Db::name('roomshopping')->where('id',$id)->find();
				$this->assign('info', $info);
				return $this->fetch('editrc');
			}else{
				$this->error('页面丢失');
			}
		}
	}
	
	//游戏大厅
	public function gamehall(){
		$lists = Db::name('gameserver')->paginate(15);
		$this->assign('lists', $lists);
		return $this->fetch();
	}
	//修改游戏大厅类别
	public function editgh(){
		if(Request::instance()->isPost()){
			//$data=input();
			$info=[
				'un32GameServerID'=>input('post.un32GameServerID'),
				'un32GameKindID'=>input('post.un32GameKindID'),
				'szGameServerName'=>input('post.szGameServerName'),
				'szGameServerPwd'=>input('post.szGameServerPwd'),
			];
			$res=Db::name('gameserver')->update($info);
			if($res){
				$this->success('操作成功', url('gamehall'),'',1);
			}else{
				$this->error('操作失败');
			}

		}else{
			$id=input('id');
			if($id){
				$info = Db::name('gameserver')->where('un32GameServerID',$id)->find();
				$this->assign('info', $info);
				return $this->fetch('addgamehall');
			}else{
				$this->error('不能修改！');
			}
		}
	}
	//添加游戏大厅
	public function addgamehall(){
		if(Request::instance()->isPost()){
			$data=input();
			$res=Db::name('gameserver')->insert($data);
			if($res){
				$this->success('操作成功', url('gamehall'),'',1);
			}else{
				$this->error('操作失败');
			}
		}else{
			return $this->fetch();
		}
	}
	
	
	
}