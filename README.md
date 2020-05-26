sa_falco
========

[![Build Status](https://travis-ci.com/softasap/sa_falco.svg?branch=master)](https://travis-ci.com/softasap/sa_falco)


Example of usage:

Simple

```YAML

     - {
         role: "sa_falco",
         falco_root_config_template: templates/falco.yml.j2
       }


```

Advanced

```YAML

roles:
     - {
         role: "sa_falco",
         falco_root_config_template: templates/falco.yml.j2
       }


```

Using with prometheus exporter
------------------------------

You can install also prometheus exporter for the tool as a part of  https://github.com/softasap/sa-prometheus-exporters ,
but in this scenario you will you will need go configure gRPC api using keys, as described below


Enabling gRPC APIs
------------------

### Configuration
The Falco gRPC server and the Falco gRPC Outputs APIs are not enabled by default.

To enable them, edit the falco.yaml Falco configuration file. A sample Falco configuration file is given below:

```yaml
# gRPC server configuration.
# The gRPC server is secure by default (mutual TLS) so you need to generate certificates and update their paths here.
# By default the gRPC server is off.
# You can configure the address to bind and expose it.
# By modifying the threadiness configuration you can fine-tune the number of threads (and context) it will use.

grpc:
  enabled: true
  bind_address: "0.0.0.0:5060"
  threadiness: 8
  private_key: "/tmp/server.key"
  cert_chain: "/tmp/server.crt"
  root_certs: "/tmp/ca.crt"

```
As you can see, binding to a network address requires you to generate and specify a set of TLS certificates as show in the next section.

Alternatively, if you want something simpler, you can tell Falco to bind the gRPC server to a local unix socket, 
this does not require you to generate certificates for mTLS but also comes without any authentication mechanism.

```yaml
# gRPC server using an unix socket
grpc:
  enabled: true
  bind_address: "unix:///var/run/falco.sock"
  threadiness: 8
```

Now, remember to enable the services you need, otherwise the gRPC server won’t expose anything, for the outputs use:

```yaml
# gRPC output service.
# By default it is off.
# By enabling this all the output events will be kept in memory until you read them with a gRPC client.
grpc_output:
  enabled: true
```

### Certificates

When configured to bind to a network address, the Falco gRPC server works only with mutual TLS by design. Therefore, you have to generate the certificates and update the paths in the above configuration.

Note: Ensure that you configure the -passin, -passout, and -subj flags according to your settings.

Generate valid CA
Run the following command:

```sh
$ openssl genrsa -passout pass:1234 -des3 -out ca.key 4096
$ openssl req -passin pass:1234 -new -x509 -days 365 -key ca.key -out ca.crt -subj  "/C=SP/ST=Italy/L=Ornavasso/O=Test/OU=Test/CN=Root CA"
```

Generate valid Server Key/Cert

Run the following command:

```sh
$ openssl genrsa -passout pass:1234 -des3 -out server.key 4096
$ openssl req -passin pass:1234 -new -key server.key -out server.csr -subj  "/C=SP/ST=Italy/L=Ornavasso/O=Test/OU=Server/CN=localhost"
$ openssl x509 -req -passin pass:1234 -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt
```

Remove passphrase from the Server Key

Run the following command:

```sh
$ openssl rsa -passin pass:1234 -in server.key -out server.key
```

Generate valid Client Key/Cert
Run the following command:

```
$ openssl genrsa -passout pass:1234 -des3 -out client.key 4096
$ openssl req -passin pass:1234 -new -key client.key -out client.csr -subj  "/C=SP/ST=Italy/L=Ornavasso/O=Test/OU=Client/CN=localhost"
$ openssl x509 -passin pass:1234 -req -days 365 -in client.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out client.crt
```

Remove passphrase from Client Key
Run the following command:

```
$ openssl rsa -passin pass:1234 -in client.key -out client.key
```

### Usage
When the configuration is complete, Falco is ready to expose its gRPC server and its Outputs APIs.

To do so, simply run Falco. For example:

```sh
$ falco -c falco.yaml -r rules/falco_rules.yaml -r rules/falco_rules.local.yaml -r rules/k8s_audit_rules.yaml
```




Usage with ansible galaxy workflow
----------------------------------

If you installed the `sa_falco` role using the command


`
   ansible-galaxy install softasap.sa_falco
`

the role will be available in the folder `softasap.sa_falco`
Please adjust the path accordingly.

```YAML

     - {
         role: "softasap.sa_falco"
       }

```




Copyright and license
---------------------

Code is dual licensed under the [BSD 3 clause] (https://opensource.org/licenses/BSD-3-Clause) and the [MIT License] (http://opensource.org/licenses/MIT). Choose the one that suits you best.

Reach us:

Subscribe for roles updates at [FB] (https://www.facebook.com/SoftAsap/)

Join gitter discussion channel at [Gitter](https://gitter.im/softasap)

Discover other roles at  http://www.softasap.com/roles/registry_generated.html

visit our blog at http://www.softasap.com/blog/archive.html
