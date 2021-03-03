# Http-Api-Json设计

## 前言

开发 `web` 应用项目，几乎离不开使用 `Http` 作为应用程序接口通讯协议、`Json` 作为应用程序接口报文格式，显然非常易知悉：`HTTP + JSON` 属于应用程序接口的一种设计模式。

我们一直试图找出一种良好的、一致的、显而易见的 API 设计方法,而并不是所谓的"最终/理想模式"，我们的目标是保持一致性,专注业务逻辑同时避免过度设计【引用 API 设计指南】，因此本篇章作为应用程序接口通讯的基础规范与定义。



## 基础认知

设计时通过将请求和响应之间的不同部分隔离来让事情变得简单。保持简单的规则让我们能更关注在一些更大的更困难的问题上。请求和响应将解决一个特定的资源或集合。使用路径(`path`)来表明身份,`body`来传输内容(`content`)还有头信息(`header`)来传递元数据(`metadata`)。查询参数同样可以用来传递头信息的内容,但头信息是首选,因为他们更灵活、更能传达不同的信息。



## 协议设计 

#### 提供版本号

制定版本并在版本之间平缓过渡对于设计和维护一套 `API` 是个巨大的挑战。所以,最好在设计之初就使用一些方法来预防可能会遇到的问题。

为了避免 `API` 的变动导致用户使用中产生意外结果或调用失败,最好强制要求所有访问都需要指定版本号。请避免提供默认版本号,一旦提供,日后想要修改它会相当困难。

最适合放置版本号的位置是头信息( `HTTP Headers` ),在 `Accept` 段中使用自定义类型( `contenttype` )与其他元数据( `metadata` )一起提交，例如:

```ini
Accept: application/vnd.heroku+json; version=3
```

同时也允许在路由上显式定义版本号，例如:

```
/v1/books/book/1
```

#### 支持Etag缓存

在所有返回的响应中包含 `ETag` 头信息,用来标识资源的版本。这让用户对资源进行缓存处理成为可能,在后续的访问请求中把 `If-None-Match` 头信息设置为之前得到的 `ETag`值,就可以侦测到已缓存的资源是否需要更新。


#### 强制使用安全连接

所有的访问 `API` 行为,都需要用 `TLS` 通过安全连接来访问。没有必要搞清或解释什么情况需要 `TLS` 什么情况不需要 `TLS`,直接强制任何访问都要通过 `TLS`。理想状态下,通过拒绝所有非 `TLS` 请求,不响应 `http` 或 80 端口的请求以避免任何不安全的数据交换。如果现实情况中无法这样做,可以返回 `403 Forbidden` 响应。把非 `TLS` 的请求重定向( `Redirect` )至 `TLS` 连接是不明智的,这种含混/不好的客户端行为不会带来明显好处。依赖于重定向的客户端访问不仅会导致双倍的服务器负载,还会使 `TLS` 加密失去意义,因为在首次非 `TLS` 调用时,敏感信息就已经暴露出去了。

#### 请求体

也就是 `Request` 对象，统一规范要求 `Request Body` 使用 `application/json` 格式数据，尽可能接触使用 `form-data` 格式。示例：

```shell
curl -X POST https://api.svc.com/apps -H "Content-Type: application/json" -d '{"name": "samego"}'
```

#### 响应

###### 报文结构

|   字段    | 必选 |   类型    |      说明     |
| :-------: | :--: | :-------: | :---------: |
|  `code`   |  是  | `integer` |   业务编码   |
| `message` |  是  | `string`  |   结果信息   |
|  `data`   |  是  | `object`  |   结果数据   |

###### 状态码

为每一次的响应返回合适的HTTP状态码。 好的响应应该使用如下的状态码:

200 : GET 请求成功,及 DELETE 或 PATCH 同步请求完成,或者 PUT 同步更新一个

- 已存在的资源

201 : POST 同步请求完成,或者 PUT 同步创建一个新的资源

202 : POST , PUT , DELETE ,或 PATCH 请求接收,将被异步处理

206 : GET 请求成功,但是只返回一部分,参考:上文中范围分页

- 使用身份认证( `authentication` )和授权( `authorization` )错误码时需要注意:

401 Unauthorized : 用户未认证,请求失败

403 Forbidden : 用户无权限访问该资源,请求失败

- 当用户请求错误时,提供合适的状态码可以提供额外的信息:

422 Unprocessable Entity : 请求被服务器正确解析,但是包含无效字段

429 Too Many Requests : 因为访问频繁,你已经被限制访问,稍后重试

500 Internal Server Error : 服务器错误,确认状态并报告问题

对于用户错误和服务器错误情况状态码,参考: HTTP response code spec

###### 业务码( **额外重要** )

业务编码由报文数据结构的 `code`  复制携带，也就是 `response.data.code`。

业务码由四位数组成，如下

```
x(业务模块) x(业务子模块) xx(细化编码)
```

业务编码需要以区间的范围申请，同时每一个项目的业务编码必须书面化公开于系统开发中心、甚至对外。所有的业务编码使用枚举类定义。详细可阅览 [`laravel-helper`](https://github.com/alicfeng/laravel-helper) 文档。

约定操作成功为 1000 、操作失败为9999，示例：

```php
<?php

/*
 * What php team is that is 'one thing, a team, work together'
 */

namespace App\Enum\Platform;

/**
 * 响应码表
 * 所有接口在使用务必在此定义
 * 将所有的响应码中心化，同时也便于查询
 * Class CodeEnum.
 */
class CodeEnum
{
    /*基础编码 Const*/
    const SUCCESS_CODE = 1000;
    const FAILURE_CODE = 9999;
    
    /*基础编码 Enum*/
    const SUCCESS = [self::SUCCESS_CODE, 'application.success'];
    const FAILURE = [self::FAILURE_CODE, 'application.failure'];
}
```





#### 使用统一的资源路径格式

###### 资源名(Resource names)
使用复数形式为资源命名,除非这个资源在系统中是单例的 (例如,在大多数系统中,给定的用户帐户只有一个)。 这种方式保持了特定资源的统一性。

###### 行为(Actions)

好的末尾不需要为资源指定特殊的行为,但在特殊情况下,为某些资源指定行为却是必要的。为了描述清楚,在行为前加上一个标准的 `actions `

```
# 规范
/resources/:resource/actions/:action

示例
/instance/{instance_id}/actions/stop
```

例如:

路径和属性要小写，为了和域名命名规则保持一致,使用小写字母并用 **-** 分割路径名字,例如:

```
service-api.com/users
service-api.com/app-setups
```

###### 最小化路径嵌套
在一些有父路径/子路径嵌套关系的资源数据模块中,路径可能有非常深的嵌套关系,例如:

```
/orgs/{org_id}/apps/{app_id}/dynos/{dyno_id}
```


推荐在根(root)路径下指定资源来限制路径的嵌套深度。使用嵌套指定范围的资源。在上述例子中, `dyno` 属于 `app` , `app` 属于 `org`可以表示为:

```
/orgs/{org_id}
/orgs/{org_id}/apps
/apps/{app_id}
/apps/{app_id}/dynos
/dynos/{dyno_id}
```




## 严禁条例

1. 一旦你的API宣布产品正式版本及稳定版本时,不要在当前API版本中做一些不兼容的改变。如果你需要,请创建一个新的版本的 `API`。



## 安全准则

1. 强制使用安全连接

2. 禁止报文参数裸奔

3. 昂贵接口进行限流

4. 核心接口进行验证

5. 禁止出现敏感信息