<?php
namespace app\admin\model;

use app\common\model\NavModel;
use think\db\Query;
use think\Model;
use think\Validate;
use think\facade\Db;
/**
 * @title 插件模型
 * @desc 插件模型
 * @use app\admin\model\PluginModel
 */
class PluginModel extends Model
{
    protected $name = 'plugin';

    // 设置字段信息
    protected $schema = [
        'id'              => 'int',
        'status'          => 'int',
        'name'            => 'string',
        'title'           => 'string',
        'url'             => 'string',
        'author'          => 'string',
        'author_url'      => 'string',
        'version'         => 'string',
        'description'     => 'string',
        'config'          => 'string',
        'module'          => 'string',
        'order'           => 'int',
        'help_url'        => 'string',
        'create_time'     => 'int',
        'update_time'     => 'int',
    ];

    /**
     * 时间 2022-5-16
     * @title 获取支付/短信/邮件/插件列表
     * @desc 获取支付/短信/邮件/插件列表:module=gateway表示支付接口列表,addon插件列表,sms短信接口列表,mail邮件接口列表
     * @author wyh
     * @version v1
     * @return array list - 插件列表
     * @return int list[].id - ID
     * @return int list[].title - 名称
     * @return int list[].description - 描述
     * @return int list[].name - 标识
     * @return int list[].version - 版本
     * @return int list[].author - 开发者
     * @return int list[].author_url - 开发者链接
     * @return int list[].status - 状态;0:禁用,1:正常,3:未安装
     * @return int list[].help_url - 申请链接
     * @return int count - 总数
     */
    public function pluginList($param)
    {
        $default = ['list'=>[],'count'=>0];

        $module = $param['module'];

        if (!in_array($module,config('idcsmart.plugin_module'))){
            return $default;
        }

        $dirs = array_map('basename', glob(WEB_ROOT . "plugins/{$module}/*", GLOB_ONLYDIR));

        if ($dirs === false){
            return $default;
        }

        if (empty($dirs)){
            return $default;
        }

        $moduleInDb = $this->where('module',$module)
            ->field('id,status,name,title,author,author_url,version,description,help_url')
            ->order('order','asc')
            ->select()
            ->toArray();

        $plugins = [];

        foreach ($moduleInDb as $plugin){
            $plugins[$plugin['name']] = $plugin;
        }

        foreach ($dirs as $k=>$dir) {

            $pluginDir = parse_name($dir, 1);

            if (!isset($plugins[$pluginDir])) { # 数据库未设置此插件
                $class = get_plugin_class($pluginDir, $module);
                if (!class_exists($class)) { # 实例化插件失败,不显示
                    unset($dirs[$k]);
                    continue;
                }
                $obj = new $class;
                $plugins[$pluginDir] = $obj->info;
                $plugins[$pluginDir]['status'] = 3; # 未安装
                $plugins[$pluginDir]['author_url'] = '';
                $plugins[$pluginDir]['help_url'] = '';
                #$plugins[$pluginDir]['url'] = '';
            }
        }

        foreach ($plugins as $kk=>&$vv){
            $class = get_plugin_class($kk, $module);		
            if (!class_exists($class)) { # 实例化插件失败,不显示
                unset($plugins[$kk]);
                continue;
            }
			if($module=="sms"){
				$methods = get_class_methods($class)?:[];
				if(in_array('sendGlobalSms',$methods)){
					$type[] = 1;
				}
				if(in_array('sendCnSms',$methods)){
					$type[] = 0;
				}
				$vv['sms_type'] = $type;
			}
			
            unset($vv['module']);
        }

        if (empty($plugins)){
            return $default;
        }

        return ['list'=>array_values($plugins),'count'=>count($plugins)];

    }

    /**
     * 时间 2022-5-16
     * @title 插件安装
     * @desc 插件安装:module=gateway表示支付接口列表,addon插件列表,sms短信接口列表,mail邮件接口列表
     * @author wyh
     * @version v1
     * @param string param.module - 模块:gateway表示支付接口列表,addon插件列表,sms短信接口列表,mail邮件接口列表 required
     * @param string param.name - 标识 required
     * @return int status - 状态码,200成功,400失败
     * @return string msg - 提示信息
     */
    public function install($param)
    {
        $module = $param['module'];

        $name = $param['name'];

        $class = get_plugin_class($name,$module);
        if (!class_exists($class)){
            return ['status'=>400,'msg'=>lang('plugin_is_not_exist')];
        }

        $installed = $this->where('name',$name)->where('module',$module)->count();
        if ($installed>0){
            return ['status'=>400,'msg'=>lang('plugin_is_installed')];
        }
        $plugin = new $class;

        $info = $plugin->info;
        if (!$info || !$plugin->checkInfo()){
            return ['status'=>400,'msg'=>lang('plugin_information_is_missing')];
        }

        $installSuccess = $plugin->install();
        if (!$installSuccess) {
            return ['status'=>400,'msg'=>lang('plugin_pre_install_fail')];
        }

        # 修改为允许客户自定义hook
        $reflect = new \ReflectionClass($class);
        $methods = $reflect->getMethods(\ReflectionMethod::IS_PUBLIC);
        $methodsFinal = $reflect->getMethods(\ReflectionMethod::IS_FINAL);
        $methodsFilter = [];
        foreach ($methods as $method){
            $methodsFilter[] = parse_name($method->name);
        }
        $methodsFinalFilter = [];
        foreach ($methodsFinal as $methodFinal){
            $methodsFinalFilter[] = parse_name($methodFinal->name);
        }
        $methods = array_diff($methodsFilter,$methodsFinalFilter);
        # 排除
        $methods = array_diff($methods,['install','uninstall','construct','get_view']);
        $pluginHooks = $methods;

        # 仅支持系统存在的hook
        /*$methods = get_class_methods($plugin);
        foreach ($methods as $methodKey => $method) {
            $methods[$methodKey] = parse_name($method);
        }
        $systemHooks = get_system_hooks();
        $pluginHooks = array_intersect($systemHooks, $methods);*/

        $info['config'] = json_encode($plugin->getConfig());

        $info['module'] = $module;

        $info['create_time'] = time();

        if (!isset($info['url'])){
            $info['url'] = '';
        }

        if (!isset($info['author_url'])){
            $info['author_url'] = '';
        }

        if (!isset($info['help_url'])){
            $info['help_url'] = '';
        }

        $this->startTrans();
        try{
            $this->data($info)
                ->allowField(array_keys($this->schema))
                ->save();
            $PluginHookModel = new PluginHookModel();
            $insert = [];
            foreach ($pluginHooks as $pluginHook){
                $insert[] = [
                    'name' => $pluginHook,
                    'plugin' => $name,
                    'status' => 1,
                    'module' => $module,
                ];
            }
            $PluginHookModel->insertAll($insert);

            # 插入导航
            if (!array_key_exists('noNav',get_class_vars($class))){
                $this->pluginInsertNav($module,$name);
            }

            # 插入权限
            $this->pluginInsertAuth($module,$name);

            # 记录日志
            $pluginId = $this->where('name',$name)->value('id');
            active_log(lang('log_admin_install_plugin',['{admin}'=>'admin#'.get_admin_id().'#'.request()->admin_name.'#','{module}'=>lang('log_admin_plugin_'.$module),'{name}'=>$name]),'plugin',$pluginId);
			# xiong sms短信模块安装导入短信模板
			if($module=="sms"){
				if(is_array($installSuccess) && count($installSuccess)>0){
					$notice_action = config("idcsmart.notice_action");
					foreach($installSuccess as $k=>$v){
						if(in_array($v['name'],$notice_action)) $installSuccess[$k]=$v;                   
					}    
					$installSuccess2=[];
					$methods = get_class_methods($class)?:[];
					foreach($methods as $method){
						$num=count($installSuccess2);
						if($method=="sendCnSms"){
							foreach($installSuccess as $k=>$v){
								$installSuccess2[$k+$num]=$v;
								$installSuccess2[$k+$num]['type']=0;
							}
						}else if($method=="sendGlobalSms"){						
							foreach($installSuccess as $k=>$v){
								$installSuccess2[$k+$num]=$v;
								$installSuccess2[$k+$num]['type']=1;
							}
						}
					}	
					$time=time();$insertAll=[];
					foreach($installSuccess2 as $v){
						$type=!empty($v['type'])?1:0;
						$message_template['type'] =$type;
						$message_template['title'] =$v['title'];
						$message_template['content'] =$v['content'];
						$message_template['sms_name'] =$name;
						$message_template['template_id'] ='';
						$message_template['notes'] ='';
						$message_template['status'] = 0; 
						$message_template['create_time'] = $time; 
						$message_template['update_time'] = $time; 
						$insertAll[]=$message_template;
					}
					if(count($insertAll)) Db::name('sms_template')->insertAll($insertAll);
				}
			}
            $this->commit();
        }catch (\Exception $e){
            $this->rollback();
            return ['status'=>400,'msg'=>lang('plugin_install_fail') . ':' . $e->getMessage()];
        }

        return ['status'=>200,'msg'=>lang('plugin_install_success')];
    }

    /**
     * 时间 2022-5-16
     * @title 插件卸载
     * @desc 插件卸载:module=gateway表示支付接口列表,addon插件列表,sms短信接口列表,mail邮件接口列表
     * @author wyh
     * @version v1
     * @param string param.module - 模块:gateway表示支付接口列表,addon插件列表,sms短信接口列表,mail邮件接口列表 required
     * @param string param.name - 插件标识 required
     * @return int status - 状态码,200成功,400失败
     * @return string msg - 提示信息
     */
    public function uninstall($param)
    {
        $plugin = $this->where('name',$param['name'])->find();

        if (empty($plugin)){
            return ['status'=>400,'msg'=>lang('plugin_is_not_exist')];
        }

        $module = $param['module'];
        $class = get_plugin_class($plugin['name'],$module);

        $this->startTrans();
        try{
            $plugin->delete();

            $PluginHookModel = new PluginHookModel();
            $PluginHookModel->where('plugin',$plugin['name'])->delete();

            if (class_exists($class)) {
                $Plugin = new $class;

                $uninstallSuccess = $Plugin->uninstall();
                if (!$uninstallSuccess) {
                    $this->rollback();
                    throw new \Exception(lang('plugin_uninstall_pre_fail'));
                }
            }

            # 删除插件导航
            $NavModel = new NavModel();
            $NavModel->deletePluginNav(['module'=>$module,'plugin'=>parse_name($param['name'],1)]);

            # 删除插件权限
            $AuthModel = new AuthModel();
            $AuthModel->deletePluginAuth($module,parse_name($param['name'],1));
			
            # 记录日志
            active_log(lang('log_admin_uninstall_plugin',['{admin}'=>'admin#'.get_admin_id().'#'.request()->admin_name.'#','{module}'=>lang('log_admin_plugin_'.$module),'{name}'=>$param['name']]),'plugin',$plugin->id);
			if($module=="sms"){
				
				$sms_template = Db::name('sms_template')->where('sms_name',$plugin['name'])->field('template_id,type')->find();
				$data['config'] = $Plugin->getConfig();
				foreach($sms_template as $smstemplate){
					if(!empty($smstemplate['template_id'])){
						$cmd=($smstemplate['type']==0)?"deleteCnTemplate":"deleteGlobalTemplate";
						$data['template_id']=$smstemplate['template_id'];
						$Plugin->$cmd($data);
					}				
				}				
				Db::name('sms_template')->where('sms_name',strtolower($plugin['name']))->delete();//删除摸板
				
			}
            $this->commit();
        }catch (\Exception $e){
            $this->rollback();
            return ['status'=>400,'msg'=>lang('plugin_uninstall_fail') . ":" . $e->getMessage()];
        }

        return ['status'=>200,'msg'=>lang('plugin_uninstall_success')];
    }

    /**
     * 时间 2022-5-16
     * @title 禁用(启用)插件
     * @desc 禁用(启用)插件:module=gateway表示支付接口列表,addon插件列表,sms短信接口列表,mail邮件接口列表
     * @author wyh
     * @version v1
     * @param string param.module - 模块:gateway表示支付接口列表,addon插件列表,sms短信接口列表,mail邮件接口列表 required
     * @param string param.name - 插件标识 required
     * @param string param.status - 状态:1启用,0禁用 required
     * @return int status - 状态码,200成功,400失败
     * @return string msg - 提示信息
     */
    public function status($param)
    {
        $module = $param['module'];

        $plugin = $this->where('name',$param['name'])->where('module',$module)->find();

        if (empty($plugin)){
            return ['status'=>400,'msg'=>lang('plugin_is_not_exist')];
        }

        $status = intval($param['status']);

        if ($status == $plugin['status']){
            return ['status'=>400,'msg'=>lang('cannot_repeat_opreate')];
        }

        $this->startTrans();
        try{
            $plugin->status = $status;
            $plugin->save();

            $PluginHookModel = new PluginHookModel();
            $PluginHookModel->where('plugin',$plugin->name)->save(['status'=>$status]);

            $this->commit();
        }catch (\Exception $e){
            $this->rollback();
            if ($status == 1){
                return ['status'=>400,'msg'=>lang('enable_fail') . ":" . $e->getMessage()];
            }else{
                return ['status'=>400,'msg'=>lang('disable_fail') . ":" . $e->getMessage()];
            }
        }

        if ($status == 1){
            # 记录日志
            active_log(lang('log_admin_enable_plugin',['{admin}'=>'admin#'.get_admin_id().'#'.request()->admin_name.'#','{module}'=>lang('log_admin_plugin_'.$module),'{name}'=>$param['name']]),'plugin',$plugin->id);
            return ['status'=>200,'msg'=>lang('enable_success')];
        }else{
            # 记录日志
            active_log(lang('log_admin_disable_plugin',['{admin}'=>'admin#'.get_admin_id().'#'.request()->admin_name.'#','{module}'=>lang('log_admin_plugin_'.$module),'{name}'=>$param['name']]),'plugin',$plugin->id);
            return ['status'=>200,'msg'=>lang('disable_success')];
        }
    }

    /**
     * 时间 2022-5-16
     * @title 获取单个插件配置
     * @desc 获取单个插件配置:module=gateway表示支付接口列表,addon插件列表,sms短信接口列表,mail邮件接口列表
     * @author wyh
     * @version v1
     * @param string module - 模块:gateway表示支付接口列表,addon插件列表,sms短信接口列表,mail邮件接口列表 required
     * @param string name - 插件标识 required
     * @return object plugin - 插件
     * @return int plugin.id - 插件ID
     * @return int plugin.status - 插件状态:0禁用,1启用,3未安装
     * @return int plugin.name - 标识
     * @return int plugin.title - 名称
     * @return int plugin.url - 图标地址
     * @return int plugin.author - 作者
     * @return int plugin.author_url - 作者链接
     * @return int plugin.version - 版本
     * @return int plugin.description - 描述
     * @return int plugin.module - 所属模块
     * @return int plugin.order - 排序
     * @return int plugin.help_url - 帮助链接
     * @return int plugin.create_time - 创建时间
     * @return int plugin.update_time - 更新时间
     * @return array plugin.config - 配置
     * @return string plugin.config[].title - 配置名称
     * @return string plugin.config[].type - 配置类型:text文本
     * @return string plugin.config[].value - 默认值
     * @return string plugin.config[].tip - 提示
     * @return string plugin.config[].field - 配置字段名,保存时传的键
     */
    public function setting($param)
    {
        $plugin = $this->where('name',$param['name'])->find();

        if (empty($plugin)){
            return (object)[];
        }

        $plugin = $plugin->toArray();

        $module = $param['module'];
        $class = get_plugin_class($plugin['name'],$module);
        if (!class_exists($class)){
            return (object)[];
        }

        $PluginClass = new $class;

        $pluginConfigInDb = $plugin['config']; // 数据库配置
        $plugin['config'] = include $PluginClass->getConfigFilePath();// 文件配置

        if ($pluginConfigInDb) {
            $pluginConfigInDb = json_decode($pluginConfigInDb, true);
            foreach ($plugin['config'] as $key => $value) {
                $plugin['config'][$key]['field'] = $key;
                if (isset($pluginConfigInDb[$key])) {
                    $plugin['config'][$key]['field'] = $key;
                    $plugin['config'][$key]['value'] = htmlspecialchars_decode($pluginConfigInDb[$key],ENT_QUOTES);
                }
            }
        }
        $plugin['config'] = array_values($plugin['config']);

        return $plugin;
    }

    /**
     * 时间 2022-5-16
     * @title 保存配置
     * @desc 保存配置:module=gateway表示支付接口列表,addon插件列表,sms短信接口列表,mail邮件接口列表
     * @author wyh
     * @version v1
     * @param string param.module - 模块:gateway表示支付接口列表,addon插件列表,sms短信接口列表,mail邮件接口列表 required
     * @param string param.name - 插件标识 required
     * @param array param.config.field - 配置:field为返回的配置字段 required
     * @return array
     * @return int status - 状态码,200成功,400失败
     * @return string msg - 提示信息
     */
    public function settingPost($param)
    {
        if (!isset($param['config']) || !is_array($param['config'])){
            return ['status'=>400,'msg'=>lang('param_error')];
        }

        $config = $param['config'];

        $plugin = $this->where('name',$param['name'])->find();
        $id = $plugin->id;

        if (empty($plugin)){
            return ['status'=>400,'msg'=>lang('plugin_is_not_exist')];
        }

        $plugin = $plugin->toArray();

        $module = $param['module'];
        $class = get_plugin_class($plugin['name'],$module);
        if (!class_exists($class)){
            return ['status'=>400,'msg'=>lang('plugin_is_not_exist')];
        }

        $PluginClass = new $class;

        $plugin['config'] = include $PluginClass->getConfigFilePath();
        $rules = [];
        $messages = [];
        foreach ($plugin['config'] as $key => $value) {
            # 对type类型为checkbox,select,radio的进行判断
            if (in_array($value['type'],['checkbox','select','radio'])){
                if (!empty($value['options']) && is_array($value['options'])){
                    if (!in_array($config[$key],array_keys($value['options']))){
                        return ['status'=>400,'msg'=>lang('range_of_values',['{key}'=>$key,'{value}'=>implode(',',array_keys($value['options']))])];
                    }
                }
            }else{
                # 以下规则未使用
                if (isset($value['rule'])) {
                    $rules[$key] = $this->parseRules($value['rule']);
                }
                if (isset($value['message'])) {
                    foreach ($value['message'] as $rule => $msg) {
                        $messages[$key . '.' . $rule] = $msg;
                    }
                }
            }
        }
        $validate = new Validate();
        if (!$validate->rule($rules)->message($messages)->check($config)) {
            return ['status'=>400,'msg'=>$validate->getError()];
        }

        if (isset($config['return_url'])){
            unset($config['return_url']);
        }
        if (isset($config['notify_url'])){
            unset($config['notify_url']);
        }

        $update = [];

        if (!empty($config['module_name'])){
            $update['title'] = $config['module_name'];
        }

        $update['config'] = json_encode($config);
        $update['update_time'] = time();

        $this->startTrans();
        try{
            $this->where('id',$id)->save($update);

            # 记录日志
            active_log(lang('log_admin_config_plugin',['{admin}'=>'admin#'.get_admin_id().'#'.request()->admin_name.'#','{module}'=>lang('log_admin_plugin_'.$module),'{name}'=>$param['name']]),'plugin',$id);

            $this->commit();
        }catch (\Exception $e){
            $this->rollback();
            return ['status'=>400,'msg'=>lang('update_fail')];
        }

        return ['status'=>200,'msg'=>lang('update_success')];
    }

    /**
     * 时间 2022-5-17
     * @title 获取可用支付/短信/邮件/插件
     * @desc 获取可用支付/短信/邮件/插件
     * @author wyh
     * @version v1
     * @param string param.module - 模块:gateway表示支付接口列表,addon插件列表,sms短信接口列表,mail邮件接口列表 required
     * @return array list - 可用接口
     * @return int list[].id - ID
     * @return int list[].title - 名称
     * @return int list[].name - 标识
     * @return int list[].url - 图片:base64格式(默认),或者自定义图片路径(支付接口使用此参数)
     * @return int count - 总数
     */
    public function plugins($module)
    {
        $plugins = $this->field('id,name,title,url')
            ->where(function (Query $query)use($module){
                $query->where('module',$module)
                    ->where('status',1);
            })
            ->withAttr('url',function ($value,$data){
                $file = WEB_ROOT . 'plugins/gateway/' . parse_name($data['name'],0) . '/' . $data['name'] . '.png';
                if (file_exists($file)){
                    return base64_encode_image($file);
                }
                # 自定义图片路径
                return $value;
            })
            ->order('order','asc')
            ->order('id','asc')
            ->select()
            ->toArray();
		if($module == 'sms' || $module == 'mail'){
			foreach ($plugins as $kk=>&$vv){
				$class = get_plugin_class($vv['name'], $module);		
				if (!class_exists($class)) { # 实例化插件失败,不显示
					unset($plugins[$kk]);
					continue;
				}
				if($module == "sms"){
					$methods = get_class_methods($class)?:[];
					if(in_array('sendGlobalSms',$methods)){
						$type[] = 1;
					}
					if(in_array('sendCnSms',$methods)){
						$type[] = 0;
					}
					$vv['sms_type'] = $type;
				}
				unset($vv['url']);
			}
        }
        return ['list'=>$plugins,'count'=>count($plugins)];
    }

    /**
     * title 验证接口是否可用
     * @desc 验证接口是否可用
     * @author wyh
     * @version v1
     * @param string name WxPay 插件标识
     * @param string module gateway 所属模块
     * @return bool
     */
    public function checkPlugin($name,$module='gateway')
    {
        $plugin = $this->where('status',1)
            ->where('name',$name)
            ->where('module',$module)
            ->find();
        return !empty($plugin)?true:false;
    }

    /**
     * 解析插件配置验证规则
     * @param $rules
     * @return array
     */
    private function parseRules($rules)
    {
        $newRules = [];

        $simpleRules = [
            'require', 'number',
            'integer', 'float', 'boolean', 'email',
            'array', 'accepted', 'date', 'alpha',
            'alphaNum', 'alphaDash', 'activeUrl',
            'url', 'ip'];
        foreach ($rules as $key => $rule) {
            if (in_array($key, $simpleRules) && $rule) {
                array_push($newRules, $key);
            }
        }

        return $newRules;
    }

    # 插入插件导航
    private function pluginInsertNav($module,$name)
    {
        # 非插件,不插入导航
        if (!in_array($module,['addon'])){
            return false;
        }

        $name = parse_name($name);

        # 添加插件默认导航
        $NavModel = new NavModel();

        $maxOrder = $NavModel->max('order');

        $navPluginId = $NavModel->where('type','admin')->where('name','nav_plugin')->value('id')?:0;
        $NavModel->create([
            'type' => 'admin',
            'name' => "nav_plugin_addon_{$name}",
            'url' => "plugin/{$name}/index.html",
            'parent_id' => $navPluginId,
            'order' => $maxOrder+1,
            'module' => $module,
            'plugin' => parse_name($name,1)
        ]);

        # 后台导航文件存在,导航添加至插件之上,管理之下
        if (file_exists(WEB_ROOT . "plugins/{$module}/{$name}/sidebar.php")){
            $navs = require WEB_ROOT . "plugins/{$module}/{$name}/sidebar.php";
            if (!empty($navs[0])){
                foreach ($navs as $nav){
                    $NavModel->createPluginNav($nav,$module,$name);
                }
            }
        }

        # 添加插件默认前台导航
        /*$maxOrder = $NavModel->max('order');

        $navPluginId2 = $NavModel->where('type','home')->where('name','nav_plugin')->value('id')?:0;
        $NavModel->create([
            'type' => 'home',
            'name' => "nav_plugin_addon_{$name}",
            'url' => "plugin/{$name}/index.html",
            'parent_id' => $navPluginId2,
            'order' => $maxOrder+1,
            'module' => $module,
            'plugin' => parse_name($name,1)
        ]);*/

        # 前台导航文件存在
        if (file_exists(WEB_ROOT . "plugins/{$module}/{$name}/sidebar_home.php")){
            $navs = require WEB_ROOT . "plugins/{$module}/{$name}/sidebar_home.php";
            if (!empty($navs[0])){
                $NavModel = new NavModel();
                foreach ($navs as $nav){
                    $NavModel->createPluginNav($nav,$module,$name,'home');
                }
            }
        }

        # 修改插件导航的排序为最后
        $maxOrder = $NavModel->max('order');
        $NavModel->update([
            'order' => $maxOrder+1
        ],['id'=>$navPluginId]);

        return true;
    }

    # 插入权限
    private function pluginInsertAuth($module,$name)
    {
        # 非插件,不插入权限
        if (!in_array($module,['addon'])){
            return false;
        }

        # 存入默认一级权限
        $class = get_plugin_class(parse_name($name,1), $module);
        $plugin = new $class;
        $AuthModel = new AuthModel();
        $maxOrder = $AuthModel->max('order');
        $authObject = $AuthModel->create([
            'title' => (isset($plugin->info['title']) && !empty($plugin->info['title']))?$plugin->info['title']:parse_name($name),
            'url'  => '',
            'parent_id' => 0,
            'order'  => $maxOrder+1,
            'module' => $module,
            'plugin' => parse_name($name,1)
        ]);

        $name = parse_name($name);

        $AuthModel = new AuthModel();
        if (file_exists(WEB_ROOT . "plugins/{$module}/{$name}/auth.php")){
            $auths = require WEB_ROOT . "plugins/{$module}/{$name}/auth.php";

            if (!empty($auths[0])){
                foreach ($auths as $auth){
                    $auth['parent_id'] = $authObject->id;
                    $AuthModel->createPluginAuth($auth,$module,$name);
                }
            }
        }

        # 更改超级管理员分组权限为所有权限
        $supperAdminId = 1;
        $AuthLinkModel = new AuthLinkModel();
        $AuthLinkModel->where('admin_role_id',$supperAdminId)->delete();
        $authIds = $AuthModel->column('id');
        $all = [];
        foreach ($authIds as $authId){
            $all[] = [
                'auth_id' => $authId,
                'admin_role_id' => $supperAdminId
            ];
        }
        $AuthLinkModel->insertAll($all);

        return true;
    }

}