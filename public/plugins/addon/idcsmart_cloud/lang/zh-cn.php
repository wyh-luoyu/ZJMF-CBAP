<?php

return [
	'id_error' => 'ID错误',
	'success_message' => '请求成功',
    'fail_message' => '请求失败',
    'create_success' => '创建成功',
    'create_fail' => '创建失败',
    'delete_success' => '删除成功',
    'delete_fail' => '删除失败',
    'update_success' => '修改成功',
    'update_fail' => '修改失败',
	'security_group_is_not_exist' => '安全组不存在',
	'security_group_rule_is_not_exist' => '安全组规则不存在',
    'security_rule_description_length' => '描述不能超过255个字',
	'security_rule_direction_require' => '规则方向必须',
	'security_rule_direction_in' => '规则方向错误',
	'security_rule_protocol_require' => '协议必须',
	'security_rule_protocol_in' => '协议错误',
	'security_rule_ip_require' => '授权IP必须',
	'security_rule_ip_format' => '授权IP格式错误',
	'security_rule_lock_in' => '锁定参数错误',
	'security_rule_start_ip_require' => '起始IP必须',
	'security_rule_start_ip_ip' => '起始IP格式错误',
	'security_rule_end_ip_require' => '结束IP必须',
	'security_rule_end_ip_ip' => '结束IP格式错误',
	'security_rule_start_port_format' => '起始端口只能是0-65535的整数',
	'security_rule_end_port_format' => '结束端口只能是0-65535的整数',
	'security_rule_priority_format' => '优先级只能是0-9999的整数',
	'security_rule_action_require' => '授权策略不能为空',
	'security_rule_action_in' => '授权策略参数错误',
	'security_rule_port_require' => '端口必须',
	'port_error' => '端口错误',
	'the_same_rule_exist' => '已存在相同规则',
	'please_input_port_range' => '请输入端口范围',
	'port_range_format_error' => '端口范围格式错误',
	'security_max_rule_num' => '每个安全组最多100条规则',

	'security_name_require' => '安全组名称不能为空',
	'security_name_length' => '安全组名称不能超过100个字符',
	'security_description_length' => '描述不能超过1000个字符',
	'security_type_in' => '安全组类型错误',

	'vpc_network_name_require' => '名称不能为空',
	'vpc_network_name_max' => '名称最大不能超过255',
	'vpc_network_ip_require' => '网段不能为空',
	'vpc_network_ip_format' => '网段格式错误',
	'data_center_is_not_exist' => '数据中心不存在',
	'vpc_network_data_center_require' => '数据中心不能为空',
	'vpc_is_not_exist' => 'VPC不存在',

	'addon_idcsmart_security_group_delete' => '删除安全组',
	'addon_idcsmart_security_group_rule_create' => '创建安全组规则',
	'addon_idcsmart_security_group_rule_update' => '修改安全组规则',
	'addon_idcsmart_security_group_rule_delete' => '删除安全组规则',

	'host_is_not_exist' => '产品不存在',
	'host_already_in_security_group' => '产品已经被添加到安全组，无需重复操作',
	'host_type_error' => '产品类型错误，只有魔方云产品才能被添加到安全组中',
	'host_not_in_security_group' => '产品未关联到安全组',
	'host_is_not_active' => '产品未开通',

];
