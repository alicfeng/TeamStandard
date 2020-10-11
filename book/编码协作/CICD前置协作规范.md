## CICD前置的协作规范

#### Dockerfile

规范
- [x] 定义构建镜像的编排文件名称为`Dockerfile`
- [x] 同时置于项目根目录
- [x] 为了加速构建效率务必有针对此应用的基础镜像
- [x] 项目的基础镜像依然根据最初的(`php-dev-ops`)计划管理



#### git

- [x] 标签作为交付镜像的版本 因此务必使用`tag`打标签记载版本里程碑



#### Pipeline

生态叫法流水线，即跑 `CICD` 任务的编排文件。  
常见的`github`配套`travis`的`.travis.yml`流水线文件，当然它是不开源的，我们将使用生态主流的`Drone`作为持续集成的驱动。 



###### Drone

规范
- [x] 定义持续继承的流水线文件的名称为`.drone.yml` 
- [x] 同时置于项目根目录

可参考[gogs-drone-docker](https://github.com/alicfeng/gogs-drone-docker)

推荐参考[Drone老家](https://docs.drone.io)



###### Jekins

规范

暂定中



#### 项目示例 | github

```
Dockerfile
.gitignore
go.mod
go.sum
LICENSE
Makefile
mysql_markdown.go
README.md
README_ZH.md
release
.travis.yml
```

