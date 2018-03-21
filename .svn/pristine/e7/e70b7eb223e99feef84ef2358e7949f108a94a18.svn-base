<?php
namespace application\admin\validate;

use think\Validate;

class Gamemail extends Validate{
	//验证规则
	protected $rule=[
			['title', 'require|max:50', '标题不能为空|标题长度最多16个字符'],
			['content', 'require|max:1200', '内容不能为空|内容长度不能超过400个字符'],			
	];
}