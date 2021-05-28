<h1 align="center">
    <a href="https://github.com/alicfeng/service-client">
        服务客户端
    </a>
</h1>
<p align="center">
    一款远程调用微服务通讯的客户端
     <br>
    支持多种通讯协议的远程调用客户端，安装一个客户端可配置灵活调用多个服务
</p>
<p align="center">
    <a href="https://travis-ci.com/github/alicfeng/service-client">
        <img src="https://travis-ci.com/alicfeng/service-client.svg?branch=master" alt="Build Status">
    </a>
    <a href="https://packagist.org/packages/alicfeng/service-client">
        <img src="https://poser.pugx.org/alicfeng/service-client/v/stable.svg" alt="Latest Stable Version">
    </a>
    <a href="https://packagist.org/packages/alicfeng/service-client">
        <img src="https://poser.pugx.org/alicfeng/service-client/d/total.svg" alt="Total Downloads">
    </a>
    <a href="https://packagist.org/packages/alicfeng/service-client">
        <img src="https://poser.pugx.org/alicfeng/service-client/license.svg" alt="License">
    </a>
</p>


## 🚀 安装配置

- **`standard`**

```
composer require alicfeng/service-client -vvv
```

- **`Laravel`**

```shell
php artisan vendor:publish --provider="Samego\Client\ServiceProvider\ServiceClientProvider"
```

  

## ✨ 支持特性

- [x] Http

- [ ] ICE

- [ ] Grpc


## ☛ 快速使用

```php
<?php
return [
    'arrangement' => [
        'success_code' => 1000,
    ],
    // 协议驱动 HTTP
    'http'        => [
        // 路由列表
        'routes' => [
            // 服务路由 服务名称.路由别名
            'user.profile' => [
                'uri'     => '/api/user',
                'method'  => 'GET',
                'headers' => [
                ],
            ],
        ],
        // 服务分组 配置每组服务通用配置
        'groups' => [
            'user' => [
                'timeout'  => 60,
                'base_uri' => env('SERVICE_CLIENT_USER_SERVER_BASE_URI'),
                'verify'   => env('SERVICE_CLIENT_USER_SERVER_VERIFY', false),
                'headers'  => [
                ],
            ],
        ],
    ],
];
```

```php
use Samego\Client\Facades\ServiceHttpClient;

// 简单请求
ServiceHttpClient::service('user.profile')->request();

// 复杂请求
ServiceHttpClient::service('user.profile')->package(['name'=>'samego'])->header(['Auth'=>'token'])->uri('api/user/profile')->request();
```

## ✅组件建议

1. 对于 `Http` 提供服务的建议使用 [laravel-response](https://github.com/alicfeng/laravel-response) 作为配套响应组件


