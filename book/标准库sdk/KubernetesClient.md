<h1 align="center">
    <a href="https://github.com/alicfeng/kubernetes-client">
        KubernetesClient
    </a>
</h1>
<p align="center">
    A PHP Client For Manage Kubernetes Cluster
     <br>
    Based on official of Kubernetest interface as well as dependent GuzzleHttp to generate.
</p>
<p align="center">
    <a href="https://travis-ci.com/github/alicfeng/KubernetesClient">
        <img src="https://travis-ci.com/alicfeng/KubernetesClient.svg?branch=master" alt="Build Status">
    </a>
    <a href="https://packagist.org/packages/alicfeng/kubernetes-client">
        <img src="https://poser.pugx.org/alicfeng/kubernetes-client/v/stable.svg" alt="Latest Stable Version">
    </a>
    <a href="https://packagist.org/packages/alicfeng/kubernetes-client">
        <img src="https://poser.pugx.org/alicfeng/kubernetes-client/d/total.svg" alt="Total Downloads">
    </a>
    <a href="https://packagist.org/packages/alicfeng/kubernetes-client">
        <img src="https://poser.pugx.org/alicfeng/kubernetes-client/license.svg" alt="License">
    </a>
</p>


## 🚀 Quick start

<<<<<<< HEAD
- **`standard`**

  ```
  composer require alicfeng/kubernetes-client -vvv
  ```

- **`Laravel`**

  ```shell
  php artisan vendor:publish --provider="AlicFeng\Kubernetes\ServiceProvider"
  # OR
  php artisan vendor:publish --tag=kubernetes
  ```

  
=======
```shell
composer require alicfeng/kubernetes-client -vvv
```


>>>>>>> 2864541dae35bfc192c5cb1a8b17f67d13d93df7

## ✨ Features

- [x] Service
- [x] Deployment
- [x] Pod
- [x] Job
- [x] ConfigMap
- [x] DaemonSet
- [x] Node
- [x] Secrets
- [x] StatefulSet
- [x] Event
- [x] Pvc
- [x] PersistentVolumeClaim
- [x] Ingress
- [x] ReplicationController



## ☛ Usage

```php
use AlicFeng\Kubernetes\Kubernetes;

$config   = [
    'base_uri'  => 'https://127.0.0.1:6443',
    'token'     => 'token',
    'namespace' => 'default'
];
$service  = Kubernetes::service($config);
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
$service->setMetadata($metadata)->setSpec($spec)->create();
# or 
$service->setApiVersion('v1')->setKind('Service')->create($yaml);

# Patch Service
$service->apply();
# Delete Service
$service->delete('service-name');
# Service Exist
$service->list()->exist('service-name');
# Item Service
$service->list()->item('service-name');
```



## 💖 Thanks developer

- [lljiuzheyang](https://github.com/lljiuzheyang) 
- [lsrong](https://github.com/lsrong)



## ₤ Kubernetes

See the API documentation for an explanation of the options:

https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/
