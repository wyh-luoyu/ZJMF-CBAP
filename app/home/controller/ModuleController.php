<?php
namespace app\home\controller;

use app\common\logic\ModuleLogic;

/**
 * @title 模块管理
 * @desc 模块管理
 * @use app\home\controller\ModuleController
 */
class ModuleController extends HomeBaseController
{
	/**
	 * 时间 2022-05-27
	 * @title 前台模块自定义方法
	 * @desc 前台模块自定义方法
	 * @url /console/v1/module/:module/:controller/:method
	 * @method  POST
	 * @author hh
	 * @version v1
	 * @param string module - 模块名称 require
	 * @param string controller - 模块内controller名称,下划线方式 require
	 * @param string method - 方法名称,下划线方式 require
	 */
	public function customFunction()
	{
		$param = $this->request->param();

		$ModuleLogic = new ModuleLogic();

        $result = $ModuleLogic->customClientFunction($param['module'], $param);
        return json($result);
	}


} 


