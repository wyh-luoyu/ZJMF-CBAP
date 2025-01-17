<?php
namespace app\common\model;

use think\Model;
use think\Db;
use app\common\logic\ModuleLogic;

/**
 * @title 产品模型
 * @desc 产品模型
 * @use app\common\model\HostModel
 */
class HostModel extends Model
{
	protected $name = 'host';

    // 设置字段信息
    protected $schema = [
        'id'                    => 'int',
        'client_id'             => 'int',
        'order_id'              => 'int',
        'product_id'            => 'int',
        'server_id'             => 'int',
        'name'                  => 'string',
        'status'                => 'string',
        'suspend_type'          => 'string',
        'suspend_reason'        => 'string',
        'suspend_time'          => 'int',
        'gateway'               => 'string',
        'gateway_name'          => 'string',
        'first_payment_amount'  => 'float',
        'renew_amount'          => 'float',
        'billing_cycle'         => 'string',
        'billing_cycle_name'    => 'string',
        'billing_cycle_time'    => 'int',
        'notes'                 => 'string',
        'client_notes'          => 'string',
        'active_time'           => 'int',
        'due_time'              => 'int',
        'termination_time'      => 'int',
        'create_time'           => 'int',
        'update_time'           => 'int',
        'suspend_type'          => 'string',
    ];

    /**
     * 时间 2022-05-13
     * @title 产品列表
     * @desc 产品列表
     * @author theworld
     * @version v1
     * @param string param.keywords - 关键字,搜索范围:产品ID,商品名称,标识,用户名,邮箱,手机号
     * @param int param.client_id - 用户ID
     * @param string param.status - 状态Unpaid未付款Pending开通中Active已开通Suspended已暂停Deleted已删除Failed开通失败
     * @param int param.page - 页数
     * @param int param.limit - 每页条数
     * @param string param.orderby - 排序 id,active_time,due_time
     * @param string param.sort - 升/降序 asc,desc
     * @return array list - 产品
     * @return int list[].id - 产品ID 
     * @return int list[].client_id - 用户ID 
     * @return int list[].client_name - 用户名 
     * @return string list[].email - 邮箱 
     * @return string list[].phone_code - 国际电话区号 
     * @return string list[].phone - 手机号 
     * @return string list[].company - 公司 
     * @return int list[].product_id - 商品ID 
     * @return string list[].product_name - 商品名称 
     * @return string list[].name - 标识 
     * @return int list[].active_time - 开通时间 
     * @return int list[].due_time - 到期时间
     * @return string list[].first_payment_amount - 金额
     * @return string list[].billing_cycle - 周期
     * @return string list[].status - 状态Unpaid未付款Pending开通中Active已开通Suspended已暂停Deleted已删除Failed开通失败
     * @return int count - 产品总数
     */
    public function hostList($param)
    {
        // 获取当前应用
        $app = app('http')->getName();
        if($app=='home'){
            $param['client_id'] = get_client_id();
            if(empty($param['client_id'])){
                return ['list' => [], 'count' => 0];
            }
        }else{
            $param['client_id'] = isset($param['client_id']) ? intval($param['client_id']) : 0;
        }

        $param['keywords'] = $param['keywords'] ?? '';
        $param['status'] = $param['status'] ?? '';
        $param['orderby'] = isset($param['orderby']) && in_array($param['orderby'], ['id', 'client_id', 'product_name', 'name', 'active_time', 'due_time', 'first_payment_amount', 'status']) ? $param['orderby'] : 'id';
        if($param['orderby']=='product_name'){
            $param['orderby'] = 'p.name';
        }else{
            $param['orderby'] = 'h.'.$param['orderby'];  
        }

        $count = $this->alias('h')
            ->field('h.id')
            ->leftjoin('product p', 'p.id=h.product_id')
            ->leftjoin('client c', 'c.id=h.client_id')
            ->where(function ($query) use($param) {
                if(!empty($param['client_id'])){
                    $query->where('h.client_id', $param['client_id']);
                }
                if(!empty($param['keywords'])){
                    $query->where('h.id|p.name|h.name|c.username|c.email|c.phone', 'like', "%{$param['keywords']}%");
                }
                if(!empty($param['status'])){
                    $query->where('h.status', $param['status']);
                }
            })
            ->count();
        $hosts = $this->alias('h')
            ->field('h.id,h.client_id,c.username client_name,c.email,c.phone_code,c.phone,c.company,h.product_id,p.name product_name,h.name,h.create_time,h.active_time,h.due_time,h.first_payment_amount,h.billing_cycle,h.billing_cycle_name,h.status,o.pay_time')
            ->leftjoin('product p', 'p.id=h.product_id')
            ->leftjoin('client c', 'c.id=h.client_id')
            ->leftjoin('order o', 'o.id=h.order_id')
            ->where(function ($query) use($param) {
                if(!empty($param['client_id'])){
                    $query->where('h.client_id', (int)$param['client_id']);
                }
                if(!empty($param['keywords'])){
                    $query->where('h.id|p.name|h.name|c.username|c.email|c.phone', 'like', "%{$param['keywords']}%");
                }
                if(!empty($param['status'])){
                    $query->where('h.status', $param['status']);
                }
            })
            ->limit($param['limit'])
            ->page($param['page'])
            ->order($param['orderby'], $param['sort'])
            ->select()
            ->toArray();
        foreach ($hosts as $key => $host) {
            $hosts[$key]['first_payment_amount'] = amount_format($host['first_payment_amount']); // 处理金额格式
            $hosts[$key]['billing_cycle'] = $host['billing_cycle']!='onetime' ? $host['billing_cycle_name'] : '';

            // 前台接口去除字段
            if($app=='home'){
                unset($hosts[$key]['client_id'], $hosts[$key]['client_name'], $hosts[$key]['email'], $hosts[$key]['phone_code'], $hosts[$key]['phone'], $hosts[$key]['company']);
            }

            unset($hosts[$key]['billing_cycle_name'], $hosts[$key]['create_time'], $hosts[$key]['pay_time']);
        }

        return ['list' => $hosts, 'count' => $count];
    }

    /**
     * 时间 2022-05-13
     * @title 产品详情
     * @desc 产品详情
     * @author theworld
     * @version v1
     * @param int id - 产品ID required
     * @return int id - 产品ID 
     * @return int product_id - 商品ID 
     * @return int server_id - 接口ID 
     * @return string name - 标识 
     * @return string notes - 备注 
     * @return string first_payment_amount - 订购金额
     * @return string renew_amount - 续费金额
     * @return string billing_cycle - 计费周期
     * @return string billing_cycle_name - 模块计费周期名称
     * @return string billing_cycle_time - 模块计费周期时间,秒
     * @return int active_time - 开通时间 
     * @return int due_time - 到期时间
     * @return string status - 状态Unpaid未付款Pending开通中Active已开通Suspended已暂停Deleted已删除Failed开通失败
     * @return string suspend_type - 暂停类型,overdue到期暂停,overtraffic超流暂停,certification_not_complete实名未完成,other其他
     * @return string suspend_reason - 暂停原因
     * @return string product_name - 商品名称
     */
    public function indexHost($id)
    {
        // 获取当前应用
        $app = app('http')->getName();

        $host = $this->field('id,product_id,server_id,name,notes,first_payment_amount,renew_amount,billing_cycle,billing_cycle_name,billing_cycle_time,active_time,due_time,status,client_id,suspend_type,suspend_reason,client_notes')->find($id);
        if (empty($host)){
            return (object)[]; // 转换为对象
        }

        $product = ProductModel::find($host['product_id']);

        // 产品的用户ID和前台用户不一致时返回空对象
        if($app=='home'){
            $client_id = get_client_id();
            if($host['client_id']!=$client_id){
                return (object)[]; // 转换为对象
            }
            $host['notes'] = $host['client_notes'];
            unset($host['server_id'], $host['client_notes']);
        }

        $host['first_payment_amount'] = amount_format($host['first_payment_amount']); 
        $host['renew_amount'] = amount_format($host['renew_amount']);
        $host['product_name'] = $product['name'] ?? '';
        unset($host['client_id']);
        
        return $host;
    }

    /**
     * 时间 2022-07-22
     * @title 搜索产品
     * @desc 搜索产品
     * @author theworld
     * @version v1
     * @param string keywords - 关键字,搜索范围:产品ID,标识,商品名称
     * @return array list - 产品
     * @return int list[].id - 产品ID 
     * @return string list[].name - 标识
     * @return string list[].product_name - 商品名称
     * @return int list[].client_id - 用户ID
     */
    public function searchHost($keywords)
    {   
        // 获取当前应用
        $app = app('http')->getName();

        //全局搜索
        $hosts = $this->alias('h')
            ->field('h.id,h.name,p.name product_name,h.client_id')
            ->leftjoin('product p', 'p.id=h.product_id')
            ->where(function ($query) use($keywords, $app) {
                if($app=='home'){
                    $clientId = get_client_id();
                    $query->where('h.client_id', $clientId);
                }
                if(!empty($keywords)){
                    $query->where('h.id|h.name|p.name', 'like', "%{$keywords}%");
                }
            })
            ->select()
            ->toArray();
        if($app=='home'){
            foreach ($hosts as $key => $value) {
                unset($hosts[$key]['client_id']);
            }
        }
        return ['list' => $hosts];
    }

    /**
     * 时间 2022-05-13
     * @title 修改产品
     * @desc 修改产品
     * @author theworld
     * @version v1
     * @param int param.id - 产品ID required
     * @param int param.product_id - 商品ID required
     * @param int param.server_id - 接口
     * @param string param.name - 标识
     * @param string param.notes - 备注
     * @param float param.first_payment_amount - 订购金额
     * @param float param.renew_amount - 续费金额
     * @param string param.billing_cycle - 计费周期 required
     * @param int param.active_time - 开通时间
     * @param int param.due_time - 到期时间
     * @param int param.status - 状态Unpaid未付款Pending开通中Active已开通Suspended已暂停Deleted已删除Failed开通失败
     * @return int status - 状态码,200成功,400失败
     * @return string msg - 提示信息
     */
    public function updateHost($param)
    {
        // 验证产品ID
        $host = $this->find($param['id']);
        if (empty($host)){
            return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
        }

        // 验证商品ID
        $product = ProductModel::find($param['product_id']);
        if (empty($product)){
            return ['status'=>400, 'msg'=>lang('product_is_not_exist')];
        }


        // 获取产品订单
        $order = OrderModel::find($host['order_id']);
        // 已付款订单不允许修改产品订购金额以及修改产品状态到未付款
        /*if(!empty($order)){
            if($order['status']=='Paid'){
                if($param['status']=='Unpaid'){
                    return ['status'=>400, 'msg'=>lang('order_is_paid_host_status_cannot_be_unpaid')];
                }
            }else{
                if($param['status']!='Unpaid'){
                    return ['status'=>400, 'msg'=>lang('order_is_unpaid_host_status_cannot_be_paid')];
                }
            }
            
        }*/

        $this->startTrans();
        try {
            // 计费周期为一次性和免费的产品没有到期时间和续费金额,其他的使用传入的到期时间和续费金额
            if($param['billing_cycle']=='onetime'){
                unset($param['due_time'], $param['renew_amount']);
            }else if($param['billing_cycle']=='free'){
                unset($param['renew_amount']);
            }

            $this->update([
                'product_id' => $param['product_id'],
                'server_id' => $param['server_id'] ?? 0,
                'name' => $param['name'] ?? '',
                'notes' => $param['notes'] ?? '',
                'first_payment_amount' => $param['first_payment_amount'] ?? 0,
                'renew_amount' => $param['renew_amount'] ?? 0,
                'billing_cycle' => $param['billing_cycle'],
                'active_time' => isset($param['active_time']) ? strtotime($param['active_time']) : 0,
                'due_time' => isset($param['due_time']) ? strtotime($param['due_time']) : 0,
                'status' => $param['status'],
                'update_time' => time()
            ], ['id' => $param['id']]);

            // 如果订购金额发生变动更新订单和订单子项金额
            /*if($host['first_payment_amount']!=$param['first_payment_amount'] && !empty($order)){
                OrderItemModel::where('rel_id', $param['id'])->where('type', 'host')->update(['amount' => $param['first_payment_amount'] ? floatval($param['first_payment_amount']) : 0, 'update_time' => time()]);
                // 获取订单金额
                $amount = OrderItemModel::where('order_id', $host['order_id'])->sum('amount');
                if($order['status']=='Paid'){
                    OrderModel::update(['amount'=>$amount, 'update_time'=>time()], ['id' => $host['order_id']]);
                }else{
                    $amountUnpaid = $amount-$order['credit'];
                    if($amountUnpaid<0){
                        // 退款到余额
                        if($amountUnpaid<0 && $param['upgrade_refund']==1){
                            $result = update_credit([
                                'type' => 'Refund',
                                'amount' => -$amount,
                                'notes' => "Upgrade Refund",
                                'client_id' => $host['client_id'],
                                'order_id' => $order->id,
                                'host_id' => $host['id']
                            ]);
                            if(!$result){
                                throw new Exception(lang('fail_message'));           
                            }
                        }
                        $amountUnpaid = 0;
                    }
                    OrderModel::update(['amount'=>$amount, 'amount_unpaid'=>$amountUnpaid, 'update_time'=>time()], ['id' => $host['order_id']]);
                }
                
            }*/
            
            $this->commit();
        } catch (\Exception $e) {
            // 回滚事务
            $this->rollback();
            return ['status' => 400, 'msg' => lang('update_fail')];
        }
        return ['status' => 200, 'msg' => lang('update_success')];
    }

    /**
     * 时间 2022-05-13
     * @title 删除产品
     * @desc 删除产品
     * @author theworld
     * @version v1
     * @param int id - 产品ID required
     * @return int status - 状态码,200成功,400失败
     * @return string msg - 提示信息
     */
    public function deleteHost($id)
    {
        // 验证产品ID
        $host = $this->find($id);
        if (empty($host)){
            return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
        }
        if($host['status']=='Pending'){
            return ['status'=>400, 'msg'=>lang('host_opening_cannot_delete')];
        }
        $this->startTrans();
        try {
            $client = ClientModel::find($host->client_id);
            if(empty($client)){
                $clientName = '#'.$host->client_id;
            }else{
                $clientName = 'client#'.$client->id.'#'.$client->username.'#';
            }
            # 记录日志
            active_log(lang('admin_delete_user_host', ['{admin}'=>request()->admin_name, '{client}'=>$clientName, '{host}'=>'#'.$host->id.$host->name]), 'host', $host->id);

            $order = OrderModel::find($host['order_id']);
            if(!empty($order) && $order['status']=='Unpaid'){
                OrderItemModel::where('host_id', $host['id'])->delete();
                $count = OrderItemModel::where('order_id', $order['id'])->count();
                if($count==0){
                    OrderModel::destroy($host['order_id']);
                }else{
                    $amount = OrderItemModel::where('order_id', $order['id'])->sum('amount');
                    OrderModel::update(['amount'=>$amount],['id'=>$host['order_id']]);
                }
            }

            $this->destroy($id);
            $this->commit();
        } catch (\Exception $e) {
            // 回滚事务
            $this->rollback();
            return ['status' => 400, 'msg' => lang('delete_fail')];
        }
        return ['status' => 200, 'msg' => lang('delete_success')];
    }

    /**
     * 时间 2022-05-26
     * @title 获取通用模块参数
     * @desc 获取通用模块参数
     * @author hh
     * @version v1
     * @return  array
     */
    public function getModuleParams()
    {
        $result = [];
        $result['host'] = $this;
        $result['client'] = ClientModel::find($this->getAttr('client_id'));
        $result['product'] = ProductModel::find($this->getAttr('product_id'));
        $result['server'] = ServerModel::find($this->getAttr('server_id'));
        if(!empty($result['server'])){
            $result['server']['password'] = aes_password_decode($result['server']['password']);
        }
        // TODO 获取产品关联的config_option
        $result['config_option'] = [];
        return $result;
    }

    /**
     * 时间 2022-05-28
     * @title 获取当前产品关联模块类型(需要先实例化)
     * @desc 获取当前产品关联模块类型
     * @author hh
     * @version v1
     * @return  string
     */
    public function getModule()
    {
        $server = ServerModel::find($this->getAttr('server_id'));
        if(!empty($server)){
            $module = $server['module'];
        }else{
            // 获取商品的模块
            $ProductModel = ProductModel::findOrEmpty($this->getAttr('product_id'));
            $module = $ProductModel->getModule();
        }
        return $module;
    }

    /**
     * 时间 2022-05-28
     * @title 产品开通
     * @desc 产品开通
     * @author hh
     * @version v1
     * @param int id - 产品ID
     * @return int status - 状态码,200=成功,400=失败
     * @return string msg - 提示信息
     */
    public function createAccount($id)
    {
        $host = $this->find($id);
        if(empty($host)){
            return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
        }
        if($host['status'] == 'Active'){
            return ['status'=>400, 'msg'=>lang('host_is_active')];
        }
        if($host['status'] == 'Supended'){
            return ['status'=>400, 'msg'=>lang('host_is_suspended')];
        }
        $ModuleLogic = new ModuleLogic();
        $res = $ModuleLogic->createAccount($host);
        if($res['status'] == 200){
            if($host['billing_cycle']=='onetime'){
                $due_time = 0;
            }else{
                $due_time = time() + $host['billing_cycle_time'];
            }
            $this->update([
                'status'      => 'Active',
                'active_time' => time(),
                'due_time' => $due_time,
                'update_time' => time(),
            ], ['id'=>$id]);
			add_task([
				'type' => 'email',
				'description' => '产品开通成功,发送邮件',
				'task_data' => [
					'name'=>'host_active',//发送动作名称
					'host_id'=>$id,//主机ID
				],		
			]);
			add_task([
				'type' => 'sms',
				'description' => '产品开通成功,发送短信',
				'task_data' => [
					'name'=>'host_active',//发送动作名称
					'host_id'=>$id,//主机ID
				],		
			]);
        }else{
            $this->update([
                'status'      => 'Failed',
                'update_time' => time(),
            ], ['id'=>$id]);
        }
        return $res;
    }

    /**
     * 时间 2022-05-28
     * @title 产品暂停
     * @desc 产品暂停
     * @author hh
     * @version v1
     * @param int id - 产品ID require
     * @param string param.suspend_type overdue 暂停类型(overdue=到期暂停,overtraffic=超流暂停,certification_not_complete=实名未完成,other=其他)
     * @param string param.suspend_reason - 暂停原因
     * @return int status - 状态码,200=成功,400=失败
     * @return string msg - 提示信息
     */
    public function suspendAccount($param)
    {
        $id = (int)$param['id'];
        $param['suspend_reason'] = $param['suspend_reason'] ?? '';

        $host = $this->find($id);
        if(empty($host)){
            return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
        }
        if($host['status'] == 'Suspended'){
            // 状态先200,这样如果上下游不会失败
            return ['status'=>200, 'msg'=>lang('host_is_suspended')];
        }
        if($host['status'] != 'Active'){
            return ['status'=>400, 'msg'=>lang('host_is_not_active_cannot_suspend')];
        }
        $ModuleLogic = new ModuleLogic();
        $res = $ModuleLogic->suspendAccount($host);
        if($res['status'] == 200){
            $this->update([
                'status'         => 'Suspended',
                'suspend_type'   => $param['suspend_type'] ?? 'overdue',
                'suspend_reason' => $param['suspend_reason'],
                'suspend_time'   => time(),
                'update_time'    => time(),
            ], ['id'=>$id]);
			add_task([
				'type' => 'email',
				'description' => '产品暂停通知,发送邮件',
				'task_data' => [
					'name'=>'host_suspend',//发送动作名称
					'host_id'=>$id,//主机ID
				],		
			]);
			add_task([
				'type' => 'sms',
				'description' => '产品暂停通知,发送短信',
				'task_data' => [
					'name'=>'host_suspend',//发送动作名称
					'host_id'=>$id,//主机ID
				],		
			]);
        }else{

        }
        return $res;
    }

    /**
     * 时间 2022-05-28
     * @title 产品解除暂停
     * @desc 产品解除暂停
     * @author hh
     * @version v1
     * @param int id - 产品ID
     * @return int status - 状态码,200=成功,400=失败
     * @return string msg - 提示信息
     */
    public function unsuspendAccount($id)
    {
        $host = $this->find($id);
        if(empty($host)){
            return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
        }
        if($host['status'] == 'Active'){
            // 状态先200,这样如果上下游不会失败
            return ['status'=>200, 'msg'=>lang('host_is_already_unsuspend')];
        }
        if($host['status'] != 'Active' && $host['status'] != 'Suspended'){
            return ['status'=>400, 'msg'=>lang('host_status_not_need_unsuspend')];
        }
        $ModuleLogic = new ModuleLogic();
        $res = $ModuleLogic->unsuspendAccount($host);
        if($res['status'] == 200){
            $this->update([
                'status'         => 'Active',
                'suspend_reason' => '',
                'suspend_time'   => 0,
                'update_time'    => time(),
            ], ['id'=>$id]);
			if(configuration('cron_due_unsuspend_swhitch')==1){
				add_task([
					'type' => 'email',
					'description' => '产品解除暂停通知,发送邮件',
					'task_data' => [
						'name'=>'host_unsuspend',//发送动作名称
						'host_id'=>$id,//主机ID
					],		
				]);
				add_task([
					'type' => 'sms',
					'description' => '产品解除暂停通知,发送短信',
					'task_data' => [
						'name'=>'host_unsuspend',//发送动作名称
						'host_id'=>$id,//主机ID
					],		
				]);
			}
        }else{


        }
        return $res;
    }

    /**
     * 时间 2022-05-28
     * @title 产品删除
     * @desc 产品删除
     * @author hh
     * @version v1
     * @param int id - 产品ID
     * @return int status - 状态码,200=成功,400=失败
     * @return string msg - 提示信息
     */
    public function terminateAccount($id)
    {
        $host = $this->find($id);
        if(empty($host)){
            return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
        }
        // 暂不判断状态,所有状态应该都能删除
        $ModuleLogic = new ModuleLogic();
        $res = $ModuleLogic->terminateAccount($host);
        if($res['status'] == 200){
            $this->update([
                'status'           => 'Deleted',
                'termination_time' => time(),
                'update_time'      => time(),
            ], ['id'=>$id]);
			add_task([
				'type' => 'email',
				'description' => '产品删除通知,发送邮件',
				'task_data' => [
					'name'=>'host_terminate',//发送动作名称
					'host_id'=>$id,//主机ID
				],		
			]);
			add_task([
				'type' => 'sms',
				'description' => '产品删除通知,发送短信',
				'task_data' => [
					'name'=>'host_terminate',//发送动作名称
					'host_id'=>$id,//主机ID
				],		
			]);
        }else{

        }
        return $res;
    }

    /**
     * 时间 2022-05-28
     * @title 后台产品内页模块输出
     * @desc 后台产品内页模块输出
     * @author hh
     * @version v1
     * @param int id - 产品ID
     * @return int status - 状态码,200=成功,400=失败
     * @return string msg - 提示信息
     * @return string data.content - 内页模块输出
     */
    public function adminArea($id)
    {
        $host = $this->find($id);
        if(empty($host)){
            return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
        }

        $ModuleLogic = new ModuleLogic();
        $content = $ModuleLogic->adminArea($host);
        
        $result = [
            'status' => 200,
            'msg'    => lang('success_message'),
            'data'   => [
                'content' => $content,
            ]
        ];
        return $result;
    }

    /**
     * 时间 2022-05-28
     * @title 前台产品内页模块输出
     * @desc 前台产品内页模块输出
     * @author hh
     * @version v1
     * @param int id - 产品ID
     * @return int status - 状态码,200=成功,400=失败
     * @return string msg - 提示信息
     * @return string data.content - 内页模块输出
     */
    public function clientArea($id)
    {
        $host = $this->find($id);
        if(empty($host) || $host['client_id'] != get_client_id()){
            return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
        }
        
        $ModuleLogic = new ModuleLogic();
        $content = $ModuleLogic->clientArea($host);
        
        $result = [
            'status' => 200,
            'msg'    => lang('success_message'),
            'data'   => [
                'content' => $content,
            ]
        ];
        return $result;
    }

    /**
     * 时间 2022-05-28
     * @title 后台产品升降级输出
     * @desc 后台产品升降级输出
     * @author hh
     * @version v1
     * @param int id - 产品ID
     * @return int status - 状态码,200=成功,400=失败
     * @return string msg - 提示信息
     * @return string data.content - 内页模块输出
     */
    public function adminChangeConfigOption($id)
    {
        $host = $this->find($id);
        if(empty($host)){
            return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
        }
        
        $ModuleLogic = new ModuleLogic();
        $content = $ModuleLogic->adminChangeConfigOption($host);
        
        $result = [
            'status' => 200,
            'msg'    => lang('success_message'),
            'data'   => [
                'content' => $content,
            ]
        ];
        return $result;
    }

    /**
     * 时间 2022-05-28
     * @title 前台产品升降级输出
     * @desc 前台产品升降级输出
     * @author hh
     * @version v1
     * @param int id - 产品ID
     * @return int status - 状态码,200=成功,400=失败
     * @return string msg - 提示信息
     * @return string data.content - 内页模块输出
     */
    public function clientChangeConfigOption($id)
    {
        $host = $this->find($id);
        if(empty($host) || get_client_id() != $host['client_id']){
            return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
        }
        
        $ModuleLogic = new ModuleLogic();
        $content = $ModuleLogic->clientChangeConfigOption($host);
        
        $result = [
            'status' => 200,
            'msg'    => lang('success_message'),
            'data'   => [
                'content' => $content,
            ]
        ];
        return $result;
    }

    /**
     * 时间 2022-05-31
     * @title 升降级配置项计算价格 
     * @desc 升降级配置项计算价格
     * @author hh
     * @version v1
     * @param   int param.id - 产品ID required
     * @param   mixed param.config_options - 自定义配置项
     * @return  int status - 状态码,200=成功,400=失败
     * @return  array data - 计算后数据
     * @return  float data.price - 配置项金额
     * @return  string data.billing_cycle - 周期名称
     * @return  int data.duration - 周期时长(秒)
     * @return  string data.description - 子项描述
     */
    public function changeConfigOptionCalculatePrice($param){
        $host = $this->find((int)$param['id']);
        if(empty($host)){
            return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
        }
        $param['config_options'] = $param['config_options'] ?? [];

        $app = app('http')->getName();
        if($app=='home'){
            $clientId = get_client_id();
            if(empty($clientId) || $clientId != $host['client_id']){
                return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
            }
        }
        $ModuleLogic = new ModuleLogic();
        $result = $ModuleLogic->changeConfigOptionCalculatePrice($host, $param['config_options']);
        return $result;
    }
    /**
     * 时间 2022-05-28
     * @title 升降级
     * @desc 升降级
     * @author hh
     * @version v1
     * @param int id - upgrade表ID
     * @return int status - 状态码,200=成功,400=失败
     * @return string msg - 提示信息
     */
    public function upgradeAccount($id)
    {
        $upgrade = UpgradeModel::find($id);
        if (empty($upgrade)){
            return false;
        }

        # 升降级
        if($upgrade['type']=='product'){
            // 获取接口
            $product = ProductModel::find($upgrade['rel_id']);
            if($product['type']=='server_group'){
                $server = ServerModel::where('server_group_id', $product['rel_id'])->where('status', 1)->find();
                $serverId = $server['id'] ?? 0;
            }else{
                $serverId = $product['rel_id'];
            }
            $this->update([
                'product_id' => $upgrade['rel_id'],
                'server_id' => $serverId,
                'first_payment_amount' => $upgrade['price'],
                'renew_amount' => ($product['pay_type']=='recurring_postpaid' || $product['pay_type']=='recurring_prepayment') ? $upgrade['price'] : 0,
                'billing_cycle' => $product['pay_type'],
                'billing_cycle_name' => $upgrade['billing_cycle_name'],
                'billing_cycle_time' => $upgrade['billing_cycle_time'],
            ],['id' => $upgrade['host_id']]);
            $ModuleLogic = new ModuleLogic();
            $host = $this->find($upgrade['host_id']);
            $ModuleLogic->changeProduct($host, json_decode($upgrade['data'], true));
        }else if($upgrade['type']=='config_option'){
            $ModuleLogic = new ModuleLogic();
            $host = $this->find($upgrade['host_id']);
            $ModuleLogic->changePackage($host, json_decode($upgrade['data'], true));
        }

        # 发送邮件短信
		add_task([
			'type' => 'email',
			'description' => '产品升降级,发送邮件',
			'task_data' => [
				'name'=>'host_upgrad',//发送动作名称
				'host_id'=>$upgrade['host_id'],//主机ID
			],		
		]);
		add_task([
			'type' => 'sms',
			'description' => '产品升降级,发送短信',
			'task_data' => [
				'name'=>'host_upgrad',//发送动作名称
				'host_id'=>$upgrade['host_id'],//主机ID
			],		
		]);
        return ['status'=>200, 'msg'=>lang('success_message')];
    }

    /**
     * 时间 2022-08-11
     * @title 修改产品备注
     * @desc 修改产品
     * @author theworld
     * @version v1
     * @param int param.id - 产品ID required
     * @param string param.notes - 备注
     * @return int status - 状态码,200成功,400失败
     * @return string msg - 提示信息
     */
    public function updateHostNotes($param)
    {
        $clientId = get_client_id();
        // 验证产品ID
        $host = $this->find($param['id']);
        if (empty($host)){
            return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
        }

        if($clientId!=$host['client_id']){
            return ['status'=>400, 'msg'=>lang('host_is_not_exist')];
        }


        $this->startTrans();
        try {
            $this->update([
                'client_notes' => $param['notes'] ?? '',
                'update_time' => time()
            ], ['id' => $param['id']]);
            
            $this->commit();
        } catch (\Exception $e) {
            // 回滚事务
            $this->rollback();
            return ['status' => 400, 'msg' => lang('update_fail')];
        }
        return ['status' => 200, 'msg' => lang('update_success')];
    }

}
