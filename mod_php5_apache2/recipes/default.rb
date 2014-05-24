case node[:platform]

  when "amazon"
    node.set['mysql']['server']['packages'] = %w{mysql55-server}
    node.set['mysql']['client']['packages'] = %w{mysql55}

    # remove any existing php/mysql
    execute "yum remove -y php* mysql*"

    # get the metadata
    execute "yum -q makecache"

    # manually install php 5.5
    execute "yum install -y php55 php55-devel php55-cli php55-snmp php55-soap php55-xml php55-xmlrpc php55-process php55-mysqlnd php55-pecl-memcache php55-opcache php55-pdo php55-imap php55-mbstring php55-intl"

  when "rhel", "fedora", "suse", "centos"
    node.set['php']['packages'] = ['php55', 'php55-devel', 'php55-cli', 'php55-snmp', 'php55-soap', 'php55-xml', 'php55-xmlrpc', 'php55-process', 'php55-mysqlnd', 'php55-pecl-memcache', 'php55-opcache', 'php55-pdo', 'php55-imap', 'php55-mbstring']
    node.set['mysql']['server']['packages'] = %w{mysql55-server}
    node.set['mysql']['client']['packages'] = %w{mysql55}

    include_recipe "php"

  when "debian"
    include_recipe "apt"
  	apt_repository "wheezy-php55" do
  		uri "#{node['php55']['dotdeb']['uri']}"
  		distribution "#{node['php55']['dotdeb']['distribution']}-php55"
  		components ['all']
  		key "http://www.dotdeb.org/dotdeb.gpg"
  		action :add
  	end

	  include_recipe "php"
  end
