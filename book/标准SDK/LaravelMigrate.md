<h1 align="center">
  <a href="https://github.com/alicfeng/laravel-migrate">
    LaravelMigrate
  </a>
</h1>
<p align="center">
  LaravelMigrate Extend Plugin
</p>
<p align="center">
  <a href="https://packagist.org/packages/alicfeng/laravel-migrate">
    <img src="https://poser.pugx.org/alicfeng/laravel-migrate/v/stable.svg" alt="Latest Stable Version">
  </a>
  <a href="https://packagist.org/packages/alicfeng/laravel-migrate">
    <img src="https://poser.pugx.org/alicfeng/laravel-migrate/d/total.svg" alt="Total Downloads">
  </a>
  <a href="https://packagist.org/packages/alicfeng/laravel-migrate">
    <img src="https://poser.pugx.org/alicfeng/laravel-migrate/license.svg" alt="License">
  </a>
</p>


#### 扩展与使用
###### `Schema` 支持对表名注释 与 支持对表自增字段设定梯度
```php
use Illuminate\Database\Schema\Blueprint;
use AlicFeng\Migrate\Schema\Schema;

Schema::create('users', function (Blueprint $table) {
    // 注明表注释
    $table->comment = '用户基准表';
    
    // 设定自增字段梯度
    $table->auto_increment = 2;
});
```


#### 安装

在项目`composer.json`添加依赖，如下：

```
"require": {
    "alicfeng/laravel-migrate": "~1.0.0"
  }
```

或者直接通过`CLI`安装，如下：

```shell
composer require "alicfeng/laravel-migrate" -vvv
```

#### 配置
将应用配置中原有 `Schame` 别名引用改成此组件即可
```php
[
    'aliases'=>[
        //'Schema' => Illuminate\Support\Facades\Schema::class,
        'Schema'   => AlicFeng\Migrate\Schema\Schema::class,
    ]
];

```

#### 版本更新
###### 1.0.0
- 支持对表名注释 与 支持对表自增字段设定梯度

