# apidoc_markdown
基于 `apidoc` 工具生成的接口文档转 `markdown` 文档

## 前言
使用 `apidoc` 工具生成接口文档，其实已经满足接口文档查阅所需，然而接口文档被按照统一格式维护与管理(对外-markdown)，为满足😌两者共存，于是就出现了 `apidoc-markdown` 😁其实已经有一个 `apidoc-markdown` 这样的扩展 `npm install -g apidoc-markdown`,只是不满足所需，刚需 - 结合 `docsify` 而用。

## 安装

- [x] `composer` 安装
```shell
composer require alicfeng/apidoc-markdown --dev -vvv
```

- [x] `shell` 安装
```shell
wget https://github.com/alicfeng/apidoc-markdown/raw/master/bin/apidoc_markdown -O /usr/local/sbin/apidoc_markdown && chmod a+x /usr/local/sbin/apidoc_markdown
```

## 使用
#### 帮助使用
```shell
➜ vendor/bin/apidoc_markdown -h
Usage: apidoc_markdown [options...]
-i    input directory  
-o    output directory 

# OR

➜ apidoc_markdown -h
Usage: apidoc_markdown [options...]
-i    input directory  
-o    output directory 


```

#### 导出使用
```shell
➜ vendor/bin/apidoc_markdown -i {input} -o {output}

# OR

➜ apidoc_markdown -i {input} -o {output}
```

#### 效果实例
```shell
➜  apidoc-markdown git:(master) ✗ apidoc_markdown -i ~/tutorial/github/api.samego.com/document -o docs
➜  apidoc-markdown git:(master) ✗ tree docs                                                                          
docs
├── documents
│   ├── Algo.md
│   ├── Camera.md
│   ├── Device.md
│   ├── Federal.md
│   ├── Offline.md
│   ├── Online.md
│   ├── Rule.md
│   ├── System.md
│   └── User.md
└── _sidebar.md

1 directory, 10 files
```