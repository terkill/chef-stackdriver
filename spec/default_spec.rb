require 'chefspec'
require 'chefspec/berkshelf'

describe 'stackdriver::default' do
  context 'raise exception' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'when attributes for platform are not defined' do
      expect(Chef::Formatters::ErrorMapper).to_not receive(:file_load_failed)
      expect { chef_run }.to raise_error('No package repository available for your platform.')
    end
  end
  context 'fedora platform' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'amazon', version: '2012.09').converge(described_recipe) }

    it 'create yum repo' do
      expect(chef_run).to create_remote_file('/etc/yum.repos.d/stackdriver.repo')
    end

    it 'install stackdriver-agent' do
      expect(chef_run).to upgrade_package('stackdriver-agent')
    end
  end

  context 'ubuntu platform' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '10.04').converge(described_recipe) }

    it 'create apt repo' do
      expect(chef_run).to add_apt_repository('stackdriver')
    end

    it 'install stackdriver-agent' do
      expect(chef_run).to upgrade_package('stackdriver-agent')
    end
  end

  context 'general configuration' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'amazon', version: '2012.09').converge(described_recipe) }

    it 'create stackdriver-agent config template' do
      expect(chef_run).to create_template(chef_run.node[:stackdriver][:config_path])
    end

    it 'template should notify service' do
      template = chef_run.template(chef_run.node[:stackdriver][:config_path])
      expect(template).to notify('service[stackdriver-agent]').to(:restart)
    end
  end

  context 'action' do
    before do
      @chef_run = ChefSpec::Runner.new(platform: 'amazon', version: '2012.09')
      @chef_run.node.set[:stackdriver][:action] = :install
      @chef_run.converge(described_recipe)
    end

    it 'only install package' do
      expect(@chef_run).to install_package('stackdriver-agent')
    end
  end

  context 'gen_hostid' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'amazon', version: '2012.09') }

    it 'do not execute generate hostid' do
      chef_run.converge(described_recipe)

      expect(chef_run).not_to run_execute('generate hostid')
    end

    context 'execute' do
      before do
        chef_run.node.set[:stackdriver][:gen_hostid] = true
        chef_run.converge(described_recipe)
      end

      it 'generate hostid' do
        expect(chef_run).to run_execute('generate hostid')
      end

      it 'notify stackdriver service to restart' do
        exec = chef_run.execute('generate hostid')
        expect(exec).to notify('service[stackdriver-agent]').to(:restart)
      end
    end
  end

  context 'disable' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'amazon', version: '2012.09') }

    before do
      chef_run.node.set[:stackdriver][:enable] = false
      chef_run.converge(described_recipe)
    end

    it 'not to create yum repo' do
      expect(chef_run).not_to create_remote_file('/etc/yum.repos.d/stackdriver.repo')
    end

    it 'not to install stackdriver-agent' do
      expect(chef_run).not_to install_package('stackdriver-agent')
    end

    it 'to disable and stop service' do
      expect(chef_run).to disable_service('stackdriver-agent')
      expect(chef_run).to stop_service('stackdriver-agent')
    end

    it 'not to create stackdriver-agent config template' do
      expect(chef_run).not_to create_template(chef_run.node[:stackdriver][:config_path])
    end
  end
end
