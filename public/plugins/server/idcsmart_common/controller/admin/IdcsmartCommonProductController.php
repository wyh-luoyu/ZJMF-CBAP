<?php
namespace server\idcsmart_common\controller\admin;

use app\event\controller\BaseController;
use server\idcsmart_common\logic\IdcsmartCommonLogic;
use server\idcsmart_common\model\IdcsmartCommonProductModel;
use server\idcsmart_common\validate\IdcsmartCommonCustomCycleValidate;
use server\idcsmart_common\validate\IdcsmartCommonProductValidate;

/**
 * @title 商品管理
 * @desc 商品管理
 * @use server\idcsmart_common\controller\admin\IdcsmartCommonProductController
 */
class IdcsmartCommonProductController extends BaseController
{
    public $validate;
    # 初始验证
    public function initialize()
    {
        parent::initialize();

        $this->validate = new IdcsmartCommonProductValidate();

        $param = $this->request->param();

        $IdcsmartCommonLogic = new IdcsmartCommonLogic();

        $IdcsmartCommonLogic->validate($param);
    }

    /**
     * 时间 2022-09-26
     * @title 商品基础信息
     * @desc 商品基础信息,插入默认价格信息
     * @url /admin/v1/idcsmart_common/product/:product_id
     * @method  get
     * @author wyh
     * @version v1
     * @param   int product_id - 商品ID require
     * @return array
     * @return string pay_type - 付款类型：付款类型(免费free，一次onetime，周期先付recurring_prepayment,周期后付recurring_postpaid
     * @return object common_product - 商品信息
     * @return int common_product - 商品信息
     * @return int common_product.product_id - 商品ID
     * @return string common_product.order_page_description - 订购页面html
     * @return int common_product.allow_qty - 是否允许选择数量:1是，0否
     * @return int common_product.auto_support - 是否自动化支持:1是，0否
     * @return  object pricing - 周期信息(注意显示,管理中的删除就是将金额变成-1)
     * @return  float pricing.onetime - 一次性,价格(当pay_type=='onetime'时,只显示此价格)
     * @return  float pricing.monthly - 月，价格(当pay_type!=onetime时,显示,注意按原型图显示,比如：monthly周期名称是月，周期时长是1月，金额就是此字段的值)
     * @return  float pricing.quarterly - 季，价格(当pay_type!=onetime时,显示)
     * @return  float pricing.semaiannually - 半年，价格(当pay_type!=onetime时,显示)
     * @return  float pricing.annually - 一年，价格(当pay_type!=onetime时,显示)
     * @return  float pricing.biennially - 两年，价格(当pay_type!=onetime时,显示)
     * @return  float pricing.triennianlly - 三年，价格(当pay_type!=onetime时,显示)
     * @return object custom_cycle - 自定义周期
     * @return int custom_cycle.id - 自定义周期ID
     * @return string custom_cycle.name - 名称
     * @return int custom_cycle.cycle_time - 时长
     * @return string custom_cycle.cycle_unit - 时长单位
     * @return float custom_cycle.amount - 金额,-1不显示出，留空
     */
	public function index()
    {
        $param = $this->request->param();

        $IdcsmartCommonProductModel = new IdcsmartCommonProductModel();

        $result = $IdcsmartCommonProductModel->indexProduct($param);

		return json($result);
	}

    /**
     * 时间 2022-09-26
     * @title 保存商品基础信息
     * @desc 保存商品基础信息
     * @url /admin/v1/idcsmart_common/product/:product_id
     * @method  post
     * @author wyh
     * @version v1
     * @param int product_id - 商品ID require
     * @param string order_page_description - 订购页描述
     * @param int allow_qty - 是否允许选择数量:1是，0否默认
     * @param int auto_support - 自动化支持:开启后所有配置选项都可输入参数
     * @param object pricing - 周期价格,格式:{"onetime":0.1,"monthly":-1,"quarterly":1.0}
     * @param float pricing.onetime - 一次性价格:删除时，传此周期价格为-1
     * @param float pricing.monthly - 月:删除时，传此周期价格为-1
     * @param float pricing.quarterly - 季:删除时，传此周期价格为-1
     * @param float pricing.semaiannually - 半年:删除时，传此周期价格为-1
     * @param float pricing.annually - 一年:删除时，传此周期价格为-1
     * @param float pricing.biennially - 两年:删除时，传此周期价格为-1
     * @param float pricing.triennianlly - 三年:删除时，传此周期价格为-1
     */
    public function create()
    {
        $param = $this->request->param();

        //参数验证
        if (!$this->validate->scene('create')->check($param)){
            return json(['status' => 400 , 'msg' => lang_plugins($this->validate->getError())]);
        }

        $IdcsmartCommonProductModel = new IdcsmartCommonProductModel();

        $result = $IdcsmartCommonProductModel->createProduct($param);

        return json($result);

	}

    /**
     * 时间 2022-09-26
     * @title 获取自定义周期详情
     * @desc 获取自定义周期详情
     * @url /admin/v1/idcsmart_common/product/:product_id/custom_cycle/:id
     * @method  get
     * @author wyh
     * @version v1
     * @param   int product_id - 商品ID require
     * @param   int id - 自定义字段ID require
     * @return object custom_cycle
     * @return string custom_cycle.name - 名称
     * @return string custom_cycle.cycle_time - 周期时长
     * @return string custom_cycle.cycle_unit - 周期单位:hour小时,day天,month月
     * @return string custom_cycle.amout - 金额
     */
    public function customCycle()
    {
        $param = $this->request->param();

        $IdcsmartCommonProductModel = new IdcsmartCommonProductModel();

        $result = $IdcsmartCommonProductModel->customCycle($param);

        return json($result);
	}

    /**
     * 时间 2022-09-26
     * @title 添加自定义周期
     * @desc 添加自定义周期
     * @url /admin/v1/idcsmart_common/product/:product_id/custom_cycle
     * @method  post
     * @author wyh
     * @version v1
     * @param   int product_id - 商品ID require
     * @param   string name - 名称 require
     * @param   int cycle_time - 周期时长 require
     * @param   string cycle_unit - 周期单位:hour小时,day天,month月 require
     * @param   float amout - 金额 require
     */
    public function createCustomCycle()
    {
        $param = $this->request->param();

        $validate = new IdcsmartCommonCustomCycleValidate();
        if (!$validate->check($param)){
            return json(['status'=>400,'msg'=>$validate->getError()]);
        }

        $IdcsmartCommonProductModel = new IdcsmartCommonProductModel();

        $result = $IdcsmartCommonProductModel->createCustomCycle($param);

        return json($result);
	}

    /**
     * 时间 2022-09-26
     * @title 修改自定义周期
     * @desc 修改自定义周期
     * @url /admin/v1/idcsmart_common/product/:product_id/custom_cycle/:id
     * @method  get
     * @author wyh
     * @version v1
     * @param   int product_id - 商品ID require
     * @param   int id - 自定义字段ID require
     * @param   int product_id - 商品ID require
     * @param   string name - 名称 require
     * @param   int cycle_time - 周期时长 require
     * @param   string cycle_unit - 周期单位:hour小时,day天,month月 require
     * @param   float amout - 金额 require
     */
	public function updateCustomCycle()
    {
        $param = $this->request->param();

        $IdcsmartCommonProductModel = new IdcsmartCommonProductModel();

        $result = $IdcsmartCommonProductModel->updateCustomCycle($param);

        return json($result);
    }

    /**
     * 时间 2022-09-26
     * @title 删除自定义字段
     * @desc 删除自定义字段
     * @url /admin/v1/idcsmart_common/product/:product_id/custom_cycle/:id
     * @method  get
     * @author wyh
     * @version v1
     * @param   int product_id - 商品ID require
     * @param   int id - 自定义字段ID require
     */
    public function deleteCustomCycle()
    {
        $param = $this->request->param();

        $IdcsmartCommonProductModel = new IdcsmartCommonProductModel();

        $result = $IdcsmartCommonProductModel->deleteCustomCycle($param);

        return json($result);
    }

}


