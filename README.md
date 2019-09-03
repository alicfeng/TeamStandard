## 团队开发规范 | TeamStandard

#### 章节目录

- [x] **编码协作**
    - [x] `Git` 工作流
    - [x] `Git` 提交规范
    - [x] Code风格统一
    - [x] 代码审查`CodeReview`
- [x] **PHP规范**
    - [x] 领略代码优雅与整洁之道
    - [x] 基于Laravel的目录结构
    - [x] 配置信息与环境变量
    - [x] 日志规范
    - [x] 注释规范
    - [x] 单元测试
- [ ] **架构层面**
    - [x] 扩展目录规约
- [ ] **面向项目**
    - [ ] 语义化版本管理
    - [ ] 文档编写
    - [x] 行为规范
- [ ] **标准`SDK`**
    - [x] `LaravelHelper`
    - [x] `KubernetesClient`
- [ ] **数据库**
    - [x] MySQL规范
    - [x] 数据库迭代迁移更新
- [ ] **效率提升**
    - [x] 那个程序员的`Linux`常用软件清单
- [ ] **程序员的自我修养**
    - [x] 关爱自己



#### book

本规范文档基于 `gitbook` 构建 `web`服务，主要是便于阅览。

###### 拉取镜像

```shell
# 此流程可以 ignore
docker pull alicfeng/gitbook:team_standard_rc
```

###### 运行规范文档服务

```shell
docker run -it --name team_standard -p 8088:2015  alicfeng/gitbook:team_standard_rc
```

###### 文档预览

![规范文档预览](https://raw.githubusercontent.com/alicfeng/TeamStandard/master/resource/mainUI.png)



























