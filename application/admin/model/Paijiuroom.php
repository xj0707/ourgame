<?php
namespace application\admin\model;

use think\Model;

class Paijiuroom extends Model{
	// 设置当前模型对应的完整数据表名称
	protected $table = 'NA_GameRoom';
	// 设置单独的数据库连接
	protected $connection = [
			// 数据库类型
			'type'        => 'mysql',
			// 服务器地址
			'hostname'    => '127.0.0.1',
			// 数据库名
			'database'    => 'na_6_paijiu',
			// 数据库用户名
			'username'    => 'root',
			// 数据库密码
			'password'    => '123321',
			// 数据库连接端口
			'hostport'    => '',
			// 数据库连接参数
			'params'      => [],
			// 数据库编码默认采用utf8
			'charset'     => 'utf8',
			// 数据库表前缀
			'prefix'      => 'na_',
			// 数据库调试模式
			'debug'       => true,
	];
	
	
	
}