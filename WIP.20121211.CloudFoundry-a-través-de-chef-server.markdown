CloudFoundry a través de chef server
====================================

`figarcia@corelia ~/src/andreacampi $ git clone git://github.com/andreacampi/cloudfoundry-vagrant.git`

{% codeblock %}
figarcia@corelia ~/src/andreacampi/cloudfoundry-vagrant/chef $ librarian-chef install
Installing apt (1.5.0)
Installing aws (0.100.2)
Installing build-essential (1.2.0)
Installing logrotate (1.0.2)
Installing dmg (1.0.0)
Installing runit (0.16.0)
Installing yum (2.0.2)
Installing git (2.0.0)
Installing ohai (1.1.2)
Installing rbenv (1.4.1)
Installing cloudfoundry (1.0.0)
Installing openssl (1.0.0)
Installing mysql (2.0.2)
Installing postgresql (2.0.0)
Installing xfs (1.0.0)
Installing database (1.3.6)
Installing nginx (1.1.0)
Installing cloudfoundry-cloud_controller (1.0.2)
Installing cloudfoundry-dea (1.0.0)
Installing cloudfoundry-health_manager (1.0.0)
Installing cloudfoundry-nginx (1.0.0)
Installing cloudfoundry-router (1.0.0)
Installing cloudfoundry-ruby-runtime (1.0.0)
Installing cloudfoundry-stager (1.0.0)
Installing nats (1.0.0)
Installing redisio (1.1.0)
{% endcodeblock %}

{% codeblock %}
figarcia@corelia ~/src/andreacampi/cloudfoundry-vagrant/chef $ knife cookbook upload --all --cookbook-path ./cookbooks/
Uploading apt            [1.5.0]
Uploading aws            [0.100.2]
Uploading build-essential [1.2.0]
Uploading cloudfoundry   [1.0.0]
Uploading cloudfoundry-cloud_controller [1.0.2]
Uploading cloudfoundry-dea [1.0.0]
Uploading cloudfoundry-health_manager [1.0.0]
Uploading cloudfoundry-nginx [1.0.0]
Uploading cloudfoundry-router [1.0.0]
Uploading cloudfoundry-ruby-runtime [1.0.0]
Uploading cloudfoundry-stager [1.0.0]
Uploading database       [1.3.6]
Uploading dmg            [1.0.0]
Uploading git            [2.0.0]
Uploading logrotate      [1.0.2]
Uploading mysql          [2.0.2]
Uploading nats           [1.0.0]
Uploading nginx          [1.1.0]
Uploading ohai           [1.1.2]
Uploading openssl        [1.0.0]
Uploading postgresql     [2.0.0]
Uploading rbenv          [1.4.1]
Uploading redisio        [1.1.0]
Uploading runit          [0.16.0]
Uploading xfs            [1.0.0]
Uploading yum            [2.0.2]
Uploaded all cookbooks.
{% endcodeblock %}
