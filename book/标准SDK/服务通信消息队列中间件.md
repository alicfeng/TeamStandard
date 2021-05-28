<h1 align="center">
    <a href="https://github.com/alicfeng/aliyun_rocket_mq">
        阿里云RocketMQ增强组件
    </a>
</h1>
<p align="center">
    基于阿里云官方SDK增强组件
     <br>
    更加优雅的应用姿势、更加灵活的动态配置，让应用层服务组件更加标准规范
</p>
<p align="center">
    <a href="https://packagist.org/packages/alicfeng/aliyun_rocket_mq">
        <img src="https://poser.pugx.org/alicfeng/aliyun_rocket_mq/v/stable.svg" alt="Latest Stable Version">
    </a>
    <a href="https://packagist.org/packages/alicfeng/aliyun_rocket_mq">
        <img src="https://poser.pugx.org/alicfeng/aliyun_rocket_mq/d/total.svg" alt="Total Downloads">
    </a>
    <a href="https://packagist.org/packages/alicfeng/aliyun_rocket_mq">
        <img src="https://poser.pugx.org/alicfeng/aliyun_rocket_mq/license.svg" alt="License">
    </a>
</p>

## 特点

1. 支持消息幂等性消费，防止消息重复消费

2. 关系协议约定，仅关心消息消费逻辑即可

3. 专注于配置化定义与注册，更加灵活简洁



## 安装

```shell
composer require alicfeng/aliyun_rocket_mq -vvv

# 安装完毕必须执行如下脚本 解决官网代码缺陷
vendor/alicfeng/aliyun_rocket_mq/bin/fix_official_pkg.sh
```



## 配置

```php

$config = [
    'client'   => [
        'endpoint'   => env('MQ_ROCKET_CLIENT_ENDPOINT'),
        'access_key' => env('MQ_ROCKET_CLIENT_ACCESS_KEY'),
        'secret_key' => env('MQ_ROCKET_CLIENT_SECRET_KEY'),
    ],
    'consumer' => [
        'handler_base_namespace' => env('MQ_ROCKET_CONSUMER_HANDLER_BASE_NAMESPACE'),
        'topic'                  => env('MQ_ROCKET_CONSUMER_TOPIC'),
        'message_tags'           => [

        ],
        'group_id'               => env('MQ_ROCKET_CONSUMER_GROUP_ID'),
        'instance_id'            => env('MQ_ROCKET_CONSUMER_INSTANCE_ID'),
    ],

    'cache' => [
        'enable'   => env('MQ_ROCKET_CACHE_ENABLE', true),
        'host'     => env('REDIS_HOST', '127.0.0.1'),
        'password' => env('REDIS_PASSWORD', null),
        'port'     => env('REDIS_PORT', '6379'),
        'database' => env('REDIS_DB', '0'),
    ]
];
```



## 使用

#### 简单使用

```php
use MQ\Model\TopicMessage;
use Samego\RocketMQ\Consumer;
use Samego\RocketMQ\Enum\MessageTagEnum;
use Samego\RocketMQ\Enum\TopicEnum;
use Samego\RocketMQ\Event\MessageEvent;
use Samego\RocketMQ\Producer;

$message = new TopicMessage('hello world');
$message->putProperty('timestamp', time());
$message->setMessageTag(MessageTagEnum::TRAINING_SERVICE_TRAINING_CONTROLLER);
$message->setMessageKey('uuid');

// 普通消息发送
Producer::normal($config['client'])->publish('MQ_xxx', TopicEnum::DEMO_SERVICE, $message);

// 普通消息订阅
Consumer::normal($config['client'], new MessageEvent($config['consumer'], $config['cache']))->subscribe();
```

#### 模切约定

1. 消费时、每一个服务订阅一个主题，即一个进程仅支持一个主题( `topic` )监听
2. 消费时、每一个订阅进程支持多个消息标签( `MessageTag` )监听
3. 消费时、每一个消息标签需要实现对于应的标签处理事件类，具体约定示例如下：

```php
// 消费配置
'consumer' => [
  // 定义承载消费处理基类命名空间
  'handler_base_namespace' => 'App\\Queue\\Handler',
  'topic'                  => env('MQ_ROCKET_CONSUMER_TOPIC'),
  'message_tags'           => [
    'Demo'
  ],
  'group_id'               => env('MQ_ROCKET_CONSUMER_GROUP_ID'),
  'instance_id'            => env('MQ_ROCKET_CONSUMER_INSTANCE_ID'),
];

// 定义好了 consumer.handler_base_namespace 与 consumer.message_tags.* 则需要定义Demo消费处理类 DemoHandler
// 同时此类需要继承 Samego\RocketMQ\Contract\QueueServiceHandlerInterface 接口

namespace App\Queue\Handler;
use MQ\Model\Message;
use Samego\RocketMQ\Contract\QueueServiceHandlerInterface;
use Samego\RocketMQ\Helper\StdLogHelper;

class DemoHandler implements QueueServiceHandlerInterface
{
    public function handler(Message $message): bool
    {
        return true;
    }

    public function failure(Message $message): void
    {
      
    }
}
```



## 注意

假设以镜像交付时，务必再安装依赖完毕时执行修复脚本，如下为示例

```dockerfile
# 安装完毕必须执行如下脚本 解决官网代码缺陷
RUN vendor/alicfeng/aliyun_rocket_mq/bin/fix_official_pkg.sh
```

或者在持续集成中执行

```yaml
# 安装完毕必须执行如下脚本 解决官网代码缺陷
- name: 安装依赖
  image: registry-vpc.cn-shenzhen.aliyuncs.com/library/application:1.0.0
  commands:
  - composer config -g
  - COMPOSER_MEMORY_LIMIT=-1 composer install --optimize-autoloader -vvv
  - vendor/alicfeng/aliyun_rocket_mq/bin/fix_official_pkg.sh
```

