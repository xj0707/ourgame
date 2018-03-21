<?php
namespace application\admin\validate;

use think\Validate;
class Broadcast extends Validate{
	//验证规则
	protected $rule=[
			['content', 'require|max:600', '内容不能为空|内容长度不能超过200个字'],				
	];
}