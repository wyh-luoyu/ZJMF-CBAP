<?php
/**
 * @desc 插件后台配置
 * @author wyh
 * @version 1.0
 * @time 2022-07-22
 */
return [
    'module_name'            => [    # 在后台插件配置表单中的键名(统一规范:小写+下划线),会是config[module_name]
        'title' => '名称',            # 表单的label标题
        'type'  => 'text',           # 表单的类型：text文本,password密码,checkbox复选框,select下拉,radio单选,textarea文本区域,tip提示
        'value' => 'Easy Payment Usdt',     # 表单的默认值
        'tip'   => 'friendly name',  # 表单的帮助提示
        'size'  => 200,               # 输入框长度(当type类型为text,password,textarea,tip时,可传入此键)
    ],
    'api_auth_token'                 => [ # 从epusdt中.env中获取api_auth_token的值
        'title' => 'Epusdt自定义密钥',
        'type'  => 'text',
        'value' => '',
        'tip'   => '从epusdt中.env中获取api_auth_token的值',
        'size'  => 200,
    ],
    'epusdt_url'                 => [ # epusdt支付地址
        'title' => 'epusdt支付地址',
        'type'  => 'text',
        'value' => '',
        'tip'   => 'epusdt支付地址',
        'size'  => 200,
    ],
];
