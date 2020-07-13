# kubernetesClient
A PHP Client For Managing K8S Cluster~

> Base K8S Office Interface as well as dependence GuzzleHttp To Generate.

#### Install

```shell
composer require alicfeng/kubernetes-client -vvv
```



#### Feature

###### Supported

- Service
- Deployment
- Pod
- Job
- ConfigMap
- DaemonSet
- Node
- Secrets
- StatefulSet
- Event
- PersistentVolume
- PersistentVolumeClaim

###### Will Support

- ReplicationController



#### Usage

```php
$config = [
  'base_uri'  => 'http://127.0.0.1:8001',
  'token'     => 'token',
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



#### K8S

See the API documentation for an explanation of the options:

https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.17/

