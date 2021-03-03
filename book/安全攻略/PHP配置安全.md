# `PHP` 配置安全

## 屏蔽 `php` 版本信息

隐藏 `php` 版本号，主要表现在 `http` 头部 `X-Powered-By:PHP/7.2`

```
expose_php=Off  
```



## 文件系统访问限制

```ini
open_basedir = /var/www
```



