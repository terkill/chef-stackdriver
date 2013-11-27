require 'chefspec'

describe 'stackdriver::plugins' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'amazon', version: '2012.09') }
  
  it 'include default recipe' do
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('stackdriver::default')
  end

  context 'elastic search' do
    context 'disabled' do
      before do
        chef_run.converge(described_recipe)
      end

      it 'not install yajil' do
        expect(chef_run).to_not install_package('yajil')
      end

      it 'not create template' do
        expect(chef_run).to_not create_template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}elasticsearch.conf")
      end
    end

    context 'enabled' do
      before do
        chef_run.node.set[:stackdriver][:plugins][:elasticsearch][:enable] = true
        chef_run.converge(described_recipe)
      end

      it 'install yajil' do
        expect(chef_run).to install_package('yajil')
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
    end

    context 'enabled' do
      before do
        chef_run.node.set[:stackdriver][:plugins][:mongodb][:enable] = true
        chef_run.converge(described_recipe)
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
    end

    context 'enabled' do
      before do
        chef_run.node.set[:stackdriver][:plugins][:nginx][:enable] = true
        chef_run.converge(described_recipe)
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

      it 'not create template' do
        expect(chef_run).to_not create_template("#{chef_run.node[:stackdriver][:plugins][:conf_dir]}redis.conf")
      end
    end

    context 'enabled' do
      before do
        chef_run.node.set[:stackdriver][:plugins][:redis][:enable] = true
        chef_run.converge(described_recipe)
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