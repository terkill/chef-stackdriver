require 'chefspec'
require 'chefspec/berkshelf'

describe 'stackdriver::plugins' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'amazon', version: '2012.09') }

  it 'include default recipe' do
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('stackdriver::default')
  end

  context 'apache' do
    context 'disabled' do
      before do
        chef_run.converge(described_recipe)
      end

      it 'not create template' do
        expect(chef_run).to_not create_template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}apache.conf")
      end

      it 'delete conf file' do
        expect(chef_run).to delete_file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}apache.conf")
      end

      it 'file notifies service restart' do
        file = chef_run.file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}apache.conf")
        expect(file).to notify('service[stackdriver-agent]').to(:restart).delayed
      end
    end

    context 'enabled' do
      before do
        chef_run.node.set[:stackdriver][:plugins][:apache][:enable] = true
        chef_run.converge(described_recipe)
      end

      it 'to not delete conf file' do
        expect(chef_run).to_not delete_file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}apache.conf")
      end

      it 'create template' do
        expect(chef_run).to create_template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}apache.conf")
      end

      it 'template notifies service restart' do
        template = chef_run.template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}apache.conf")
        expect(template).to notify('service[stackdriver-agent]').to(:restart).delayed
      end
    end
  end

  context 'elastic search' do
    context 'disabled' do
      before do
        chef_run.converge(described_recipe)
      end

      it 'not install yajl' do
        expect(chef_run).to_not install_package('yajl')
      end

      it 'not create template' do
        expect(chef_run).to_not create_template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}elasticsearch.conf")
      end

      it 'delete conf file' do
        expect(chef_run).to delete_file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}elasticsearch.conf")
      end

      it 'file notifies service restart' do
        file = chef_run.file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}elasticsearch.conf")
        expect(file).to notify('service[stackdriver-agent]').to(:restart).delayed
      end
    end

    context 'enabled' do
      before do
        chef_run.node.set[:stackdriver][:plugins][:elasticsearch][:enable] = true
        chef_run.converge(described_recipe)
      end

      it 'to not delete conf file' do
        expect(chef_run).to_not delete_file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}elasticsearch.conf")
      end

      it 'install yajl' do
        expect(chef_run).to install_package('yajl')
      end

      it 'create template' do
        expect(chef_run).to create_template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}elasticsearch.conf")
      end

      it 'template notifies service restart' do
        template = chef_run.template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}elasticsearch.conf")
        expect(template).to notify('service[stackdriver-agent]').to(:restart).delayed
      end
    end
  end

  context 'mongodb' do
    context 'disabled' do
      before do
        chef_run.converge(described_recipe)
      end

      it 'not create template' do
        expect(chef_run).to_not create_template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}mongodb.conf")
      end

      it 'delete conf file' do
        expect(chef_run).to delete_file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}mongodb.conf")
      end

      it 'file notifies service restart' do
        file = chef_run.file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}mongodb.conf")
        expect(file).to notify('service[stackdriver-agent]').to(:restart).delayed
      end
    end

    context 'enabled' do
      before do
        chef_run.node.set[:stackdriver][:plugins][:mongodb][:enable] = true
        chef_run.converge(described_recipe)
      end

      it 'to not delete conf file' do
        expect(chef_run).to_not delete_file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}mongodb.conf")
      end

      it 'create template' do
        expect(chef_run).to create_template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}mongodb.conf")
      end

      it 'template notifies service restart' do
        template = chef_run.template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}mongodb.conf")
        expect(template).to notify('service[stackdriver-agent]').to(:restart).delayed
      end
    end
  end

  context 'nginx' do
    context 'disabled' do
      before do
        chef_run.converge(described_recipe)
      end

      it 'not create template' do
        expect(chef_run).to_not create_template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}nginx.conf")
      end

      it 'delete conf file' do
        expect(chef_run).to delete_file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}nginx.conf")
      end

      it 'file notifies service restart' do
        file = chef_run.file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}nginx.conf")
        expect(file).to notify('service[stackdriver-agent]').to(:restart).delayed
      end
    end

    context 'enabled' do
      before do
        chef_run.node.set[:stackdriver][:plugins][:nginx][:enable] = true
        chef_run.converge(described_recipe)
      end

      it 'to not delete conf file' do
        expect(chef_run).to_not delete_file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}nginx.conf")
      end

      it 'create template' do
        expect(chef_run).to create_template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}nginx.conf")
      end

      it 'template notifies service restart' do
        template = chef_run.template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}nginx.conf")
        expect(template).to notify('service[stackdriver-agent]').to(:restart).delayed
      end
    end
  end

  context 'redis' do
    context 'disabled' do
      before do
        chef_run.converge(described_recipe)
      end

      it 'not install package' do
        expect(chef_run).to_not install_package(chef_run.node[:stackdriver][:plugins][:redis][:package])
      end

      it 'not create template' do
        expect(chef_run).to_not create_template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}redis.conf")
      end

      it 'delete conf file' do
        expect(chef_run).to delete_file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}redis.conf")
      end

      it 'file notifies service restart' do
        file = chef_run.file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}redis.conf")
        expect(file).to notify('service[stackdriver-agent]').to(:restart).delayed
      end
    end

    context 'enabled' do
      before do
        chef_run.node.set[:stackdriver][:plugins][:redis][:enable] = true
        chef_run.converge(described_recipe)
      end

      it 'install package' do
        expect(chef_run).to install_package(chef_run.node[:stackdriver][:plugins][:redis][:package])
      end

      it 'to not delete conf file' do
        expect(chef_run).to_not delete_file("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}redis.conf")
      end

      it 'create template' do
        expect(chef_run).to create_template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}redis.conf")
      end

      it 'template notifies service restart' do
        template = chef_run.template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}redis.conf")
        expect(template).to notify('service[stackdriver-agent]').to(:restart).delayed
      end
    end
  end
end
