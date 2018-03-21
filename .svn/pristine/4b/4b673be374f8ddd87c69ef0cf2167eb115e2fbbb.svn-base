<?php
namespace application\admin\validate;

use think\Validate;

class GameroomtemplateTuitongzi extends Validate{
	//验证规则
	protected $rule=[
			//['szName', 'require|max:50|unique:gameroomtemplateTuiguo', '模板名称不能为空|标题长度最多16个字符|模板名称不能一样'],
			['un32TotalAnte', 'require|between:100,10000000', '锅底不能为空|锅底必须在100到10000000之间'],
			['fWinTaxRate', 'integer|between:0,100|requireWith:bIfTax,1', '抽水比例不能有小数|比例在0~100|抽水比例不能为空'],
			['fLoseTaxRate', 'integer|between:0,100|requireWith:bIfTax,1', '抽水比例不能有小数|比例在0~100|抽水比例不能为空'],
	];
	
}