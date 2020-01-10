# kubernetesClient
使用 `php` 基于 `guzzle` 构建的 `kubernetes` 客户端。

由于项目架构采用 `k8s` ,此部分作为业务实现的根基，作为框架层业务代码，因而可作为项目框架的底层 `lib`，同时公司众多应用层项目涉及 `k8s` ，为了各个项目的 `lib` 一致的目的，避免每一个项目皆异从而花极大的成本维护与开发，所以此框架层 `lib` 独立于业务构建了 `package`。



#### 安装

```shell
composer require alicfeng/kubernetes-client:v1.0.4 -vvv
```



#### 权限

支持账号密码 与 `Token` 方式请求交互



#### 功能支持

###### Service

###### Service

###### Deployment

###### Pod

###### Job

###### ConfigMap

###### DaemonSet

###### Node

###### Secrets

###### StatefulSet

###### Event



#### 使用示例

```php
# token方式
$config = [
  'base_uri'  => 'http://127.0.0.1:8001',
  'token'     => 'token',
  'namespace' => 'default'
];    
# 账号密码方式
$config = [
  'base_uri'  => 'http://127.0.0.1:8001',
  'username'  => 'k8s',
  'password'  => 'pwd',
  'namespace' => 'default'
];  

$serviceClient = new Service($config);
$metadata = [
  'name' => 'demo-service'
];
$spec     = [
  'type'     => 'NodePort',
  'selector' => [
    'k8s-app' => 'demo-service',
  ],
  'ports'    => [
    [
      'protocol'   => 'TCP',
      'port'       => 80,
      'targetPort' => 80,
      'nodePort'   => 30008
    ]
  ]
];

# Create Service
$serviceClient->setMetadata($metadata)->setSpec($spec)->create();
# or 
$serviceClient->setApiVersion('v1')->setKind('Service')->create($yaml);

# Patch Service
$serviceClient->apply();
# Delete Service
$serviceClient->delete('service-name');
# Service Exist
$serviceClient->list()->exist('service-name');
# Item Service
$serviceClient->list()->item('service-name');

... ...
```



#### 官方文档

See the API documentation for an explanation of the options:

https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/
