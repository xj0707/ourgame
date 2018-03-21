<?php


namespace application\admin\model;

use think\Db;

class Gameuser extends \think\Model {
	
	


/**
 * 玩家总数
 */
	public function getUserTotal() {
		$merch_id=session('merch_id');
		if($merch_id[0]!=10000){
			$total=Db::name('gameuser')->where("merchantId",'in',$merch_id)->count();
		}else{
			$total=Db::name('gameuser')->count();
		}

		return $total;
	}

	
	
	
}
