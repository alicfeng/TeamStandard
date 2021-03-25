# Laravel-helper
==============

Laravel-helper Component is a simple package that has been designed to help you generate code specification and robust architecture.

[![Latest Stable Version](http://img.shields.io/packagist/v/alicfeng/laravel-helper.svg)](https://packagist.org/packages/alicfeng/laravel-helper) [![Total Downloads](https://poser.pugx.org/alicfeng/laravel-helper/d/total.svg)](https://packagist.org/packages/alicfeng/laravel-helper) [![Build Status](http://img.shields.io/travis/alicfeng/laravel-helper.svg)](https://travis-ci.org/alicfeng/laravel-helper) 

## Get started

#### install

```shell
composer require alicfeng/laravel-helper:v1.2.3 -vvv
```

#### config

###### app.php

```php
'providers' => [
   AlicFeng\Helper\ServiceProvider\HelperServiceProvider::class,
]
```

###### public vendor

```php
php artisan vendor:publish --provider="AlicFeng\Helper\ServiceProvider\HelperServiceProvider"
```

###### configuration

> `config/helper.php`

```php
// about package setting
'package'   => [
  /*Response Package Structure*/
  'structure' => [
    'code'    => 'code',
    'message' => 'message',
    'data'    => 'data',
  ],

  // Default Header simple:Content-Type => application/json
  'header'    => [

  ],

  /*Package encrypt Setting*/
  'crypt'     => [
    'instance' => \AlicFeng\Helper\Crypt\HelperCryptService::class,
    'method'   => 'aes-128-ecb',
    'password' => '1234qwer',
  ],

  /*Package format (json | xml)*/
  'format'    => 'json',

  /*Log*/
  'log'       => [
    'log'   => true,
    'level' => 'notice',
  ],
],

// about log setting
'log'       => [
  'extra_field' => [
    'runtime_file'   => true,
    'memory_message' => false,
    'web_message'    => false,
    'process_id'     => false,
  ],
],

// translate
'translate' => [
  'model'    => true,
  'instance' => \AlicFeng\Helper\Translate\Translation::class,
],

// runtime model
'runtime'   => [
  'trace' => [
    'request'    => true,
    'response'   => false,
    'filter_uri' => [

    ]
  ],
],

// debug model setting
'debug'     => false,
```



## Helper Model

#### ResponseHelper

###### What function does it have?

- Generate Unified Structure Package Following RESTful
- Response Package Encrypt By Middleware

###### Usage

- Generate Unified Structure Package Following RESTful

  > For example about `Controller - Service`
  >
  > using `return $this->result($codeEnum, $result);` 

  Developers only care about the results of service processing, while the response structure is built by components.

  ```php
  class HelloService extends HelperServiceAbstract {
      public function __construct()
      {
          parent::__construct();
      }
      public function package(string $name = '')
      {
          $codeEnum = [1000, 'success']; // this should define in app/Enum/CodeEnum.php
          $result   = [
              'name'   => $name,
              'age'    => 24,
          ];
          // return $this->rspHelper->transform(DemoTransform::class)->result($codeEnum, $result);
          return $this->rspHelper->result($codeEnum, $result);
      }
  }
  ```
  
  Request Result
  
  ```shell
  ➜ curl -s "https://dev.samego.com/api/package?name=alicfeng" | jq .
  {
    "code": 1000,
    "message": "success",
    "data": {
      "name": "alicfeng",
      "age": 24
    }
  }
  ```
  
- Response Package Encrypt By Middleware

  > First register middle in Kernel 
  >
  > Then add middleware in route file or __construct

  `app/Http/Kernel.php`

  ```php
  protected $routeMiddleware = [
    'package.encrypt'=>\AlicFeng\Helper\Middleware\EncryptMiddleware::class
  ];
  ```

  `routes/api.php`

  ```php
  Route::middleware('package.encrypt')->get('/package', 'HelloController@package');
  ```

  Request Result

  ```shell
  ➜  demo curl -s "http://127.0.0.1:8181/api/package?name=alicfeng"       
  1aGGUAPDs0x80Qqnacwv1LQOd5crQrJZRJ6-7AbmrYb2EqvhUZ4flXBe6DKbKGGYbboU--qwz64epLapZc9nxSCsn4XIW-QG8taK-g_bteE
  ```

  Component provides the function of decrypting ciphertext through Web !!! see~

  now open you browser input `{$host/helper/decrypt}` then enter.

  ![decrypt-web](https://raw.githubusercontent.com/alicfeng/laravel-helper/master/doc/web@2x.png)

  > You can specify instances of encryption and decryption by configuring them，
>
  > `config/helper.php` in `package.crypt.instance`
  >
  > have to implements `HelperCryptServiceInterface`

 

#### CurlHelper
```php
/**
*@return \Symfony\Component\HttpFoundation\Response
*/
$response = CurlHelper::get(...);
$response = CurlHelper::post(...);
$response = CurlHelper::put(...);
$response = CurlHelper::delete(...);

```



#### LogHelper

###### display log content format

```
[2019-08-20 23:36:37.310839] local.INFO: push cash {"user_id":9510,"cash":"52.00"}
{"memory_usage":"14 MB","memory_peak_usage":"14 MB","runtime_file":{"file":"/Users/alicfeng/tutorial/github/tmp/demo/app/Console/Commands/AlicFeng.php:69","function":"App\\Console\\Commands\\AlicFeng->handle"}}

[2019-08-20 23:36:37.311712] local.DEBUG: source data come from cache 
{"memory_usage":"14 MB","memory_peak_usage":"14 MB","runtime_file":{"file":"/Users/alicfeng/tutorial/github/tmp/demo/app/Console/Commands/AlicFeng.php:71","function":"App\\Console\\Commands\\AlicFeng->handle"}}

[2019-08-20 23:36:37.311834] local.NOTICE: sync article successful {"user_id":9510}
{"memory_usage":"14 MB","memory_peak_usage":"14 MB","runtime_file":{"file":"/Users/alicfeng/tutorial/github/tmp/demo/app/Console/Commands/AlicFeng.php:73","function":"App\\Console\\Commands\\AlicFeng->handle"}}

[2019-08-20 23:36:37.311935] local.WARNING: logout failed {"user_id":8888}
{"memory_usage":"14 MB","memory_peak_usage":"14 MB","runtime_file":{"file":"/Users/alicfeng/tutorial/github/tmp/demo/app/Console/Commands/AlicFeng.php:75","function":"App\\Console\\Commands\\AlicFeng->handle"}}
```

###### configure

> `config/logging.php`

```php
'daily' => [
  'driver'         => 'daily',
  'path'           => storage_path('logs/laravel.log'),
  'level'          => 'debug',
  'permission'     => 0777,
  'tap'            => [\AlicFeng\Helper\Component\Log\LogEnhancer::class],
  'days'           => 7,
  'formatter'      => \Monolog\Formatter\LineFormatter::class,
  'formatter_with' => [
    'dateFormat'                 => 'Y-m-d H:i:s.u',
    'allowInlineLineBreaks'      => true,
    'ignoreEmptyContextAndExtra' => true,
    'format' => "[%datetime%] %channel%.%level_name%: %message% %context%\n%extra%\n"
  ]
]
```

###### Usage

```php
Log::info('push cash', ['user_id' => 9510, 'cash' => '52.00']);
Log::debug('source data come from cache');
Log::notice('sync article successful', ['user_id' => 9510]);
Log::warning('logout failed', ['user_id' => 8888]);
// or 
LogHelper::info('push cash', ['user_id' => 9510, 'cash' => '52.00']);
LogHelper::debug('source data come from cache');
LogHelper::notice('sync article successful', ['user_id' => 9510]);
LogHelper::warning('logout failed', ['user_id' => 8888]);
```



#### DateTimeHelper

###### api function

- msectime

  ```php
  DateTimeHelper::msectime()
  ```

