<h1 align="center">
    <a href="https://github.com/alicfeng/laravel-response">
        LaravelResponse
    </a>
</h1>
<p align="center">
    A Laravel Plugin For Manage API Response Package
     <br>
    It could make your api standard as well as Improve development efficiency
</p>
<p align="center">
    <a href="https://travis-ci.com/github/alicfeng/laravel-response">
        <img src="https://travis-ci.com/alicfeng/LaravelResponse.svg?branch=master" alt="Build Status">
    </a>
    <a href="https://packagist.org/packages/alicfeng/laravel-response">
        <img src="https://poser.pugx.org/alicfeng/laravel-response/v/stable.svg" alt="Latest Stable Version">
    </a>
    <a href="https://packagist.org/packages/alicfeng/laravel-response">
        <img src="https://poser.pugx.org/alicfeng/laravel-response/d/total.svg" alt="Total Downloads">
    </a>
    <a href="https://packagist.org/packages/alicfeng/laravel-response">
        <img src="https://poser.pugx.org/alicfeng/laravel-response/license.svg" alt="License">
    </a>
</p>



## 能力

1. 统一动作标准化影响体结构
2. 支持响应自定义报文加解密



## 安装

```shell
composer require alicfeng/laravel-response -vvv

php artisan vendor:publish --provider="Samego\Response\ServiceProvider\ServiceProvider"
```



## 配置

```php
return [
    // about package setting
    /*Response Package Structure*/
    'structure' => [
        'code'    => 'code',
        'message' => 'message',
        'data'    => 'data',
    ],

    // Default Header simple:Content-Type => application/json
    'header'    => [
        'Content-Type' => 'application/json',
    ],

    /*Package encrypt Setting*/
    'crypt'     => [
        'instance' => \Samego\Response\Service\CryptService::class,
        'method'   => 'aes-128-ecb',
        'password' => '1234qwer',
    ],

    /*Log*/
    'log'       => [
        'log'   => true,
        'level' => 'notice',
    ],

    // translate
    'translate' => [
        'model'    => true,
        'instance' => \Samego\Response\Service\Translation::class,
    ],

    // runtime model
    'runtime'   => [
        'trace' => [
            'request'    => true,
            'response'   => false,
            'filter_uri' => [
            ],
        ],
    ],

    // debug model setting
    'debug'     => false,
];
```



## 使用

业务层基类定义

```PHP
namespace App\Services;

use App\Enums\Application\CodeEnum;
use Illuminate\Contracts\Routing\ResponseFactory;
use Samego\Response\Service\ServiceAbstract;

/**
 * Class Service
 * 业务层基类.
 * @version 1.0.0
 * @author  AlicFeng
 */
class Service extends ServiceAbstract
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * @function    success
     * @description 响应业务成功处理结果调用
     * @param array $data        业务结果数据
     * @param array $code_enum   业务编码枚举
     * @param int   $status_code 协议状态编码
     * @param array $headers     协议头部信息
     * @return ResponseFactory
     * @author      AlicFeng
     */
    public function success($data = [], array $code_enum = CodeEnum::SUCCESS, int $status_code = 200, array $headers = [])
    {
        return $this->rspHelper->result($code_enum, $data, $status_code, $headers);
    }

    /**
     * @function    failure
     * @description 响应业务失败处理结果调用
     * @param array $code_enum   业务编码枚举
     * @param array $data        业务结果数据
     * @param int   $status_code 协议状态编码
     * @param array $headers     协议头部信息
     * @return ResponseFactory
     * @author      AlicFeng
     */
    public function failure(array $code_enum = CodeEnum::FAILURE, $data = [], int $status_code = 200, array $headers = [])
    {
        return $this->rspHelper->result($code_enum, $data, $status_code, $headers);
    }
}
```

具体业务层使用

```php
namespace App\Services\Demo;

use App\Services\Service;

/**
 * Class HelloService
 * 模板示例业务层 项目上请删除 TODO.
 * @version 1.0.0
 * @author  AlicFeng
 */
class HelloService extends Service
{
    public function __construct()
    {
        parent::__construct();
    }

    public function printer(string $name)
    {
        $data = compact('name');

        return $this->success($data);
    }
}

```

