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
