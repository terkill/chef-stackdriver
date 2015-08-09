require 'chefspec'
require 'chefspec/berkshelf'

describe 'stackdriver::default' do
  context 'raise exception' do
    let(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }

    it 'when attributes for platform are not defined' do
      expect(Chef::Formatters::ErrorMapper).to_not receive(:file_load_failed)
      expect { chef_run }.to raise_error('No package repository available for your platform.')
    end
  end
  context 'amazon platform' do
    let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'amazon', version: '2015.03').converge(described_recipe) }

    it 'use amazon linux yum repo' do
      expect(chef_run.node['stackdriver']['repo_url']).to eq('http://repo.stackdriver.com/repo/amzn-2014.03/$basearch/')
    end

    it 'create yum repo' do
      expect(chef_run).to create_yum_repository('stackdriver')
    end

    it 'install stackdriver-agent' do
      expect(chef_run).to upgrade_package('stackdriver-agent')
    end
  end

  context 'centos platform' do
    let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'centos', version: '6.6').converge(described_recipe) }

    it 'expect repo_url' do
      expect(chef_run.node['stackdriver']['repo_url']).to eq('http://repo.stackdriver.com/repo/el6/$basearch/')
    end

    it 'create yum repo' do
      expect(chef_run).to create_yum_repository('stackdriver')
    end

    it 'install stackdriver-agent' do
      expect(chef_run).to upgrade_package('stackdriver-agent')
    end
  end

  context 'ubuntu platform' do
    let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }

    it 'set repo_dist' do
      expect(chef_run.node['stackdriver']['repo_dist']).to eq('trusty')
    end

    it 'create apt repo' do
      expect(chef_run).to add_apt_repository('stackdriver')
    end

    it 'install stackdriver-agent' do
      expect(chef_run).to upgrade_package('stackdriver-agent')
    end
  end

  context 'debian platform' do
    let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'debian', version: '6.0.5').converge(described_recipe) }

    it 'set repo_dist' do
      expect(chef_run.node['stackdriver']['repo_dist']).to eq('squeeze')
    end

    it 'create apt repo' do
      expect(chef_run).to add_apt_repository('stackdriver')
    end

    it 'install stackdriver-agent' do
      expect(chef_run).to upgrade_package('stackdriver-agent')
    end
  end

  context 'general configuration' do
    let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'centos', version: '6.5').converge(described_recipe) }

    it 'create stackdriver-agent config template' do
      expect(chef_run).to create_template(chef_run.node['stackdriver']['config_path'])
    end

    it 'template should notify service' do
      template = chef_run.template(chef_run.node['stackdriver']['config_path'])
      expect(template).to notify('service[stackdriver-agent]').to(:restart)
    end
  end

  context 'action' do
    before do
      @chef_run = ChefSpec::ServerRunner.new(platform: 'amazon', version: '2015.03')
      @chef_run.node.set['stackdriver']['action'] = :install
      @chef_run.converge(described_recipe)
    end

    it 'only install package' do
      expect(@chef_run).to install_package('stackdriver-agent')
    end
  end

  context 'gen_hostid' do
    let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'amazon', version: '2015.03') }

    it 'do not execute generate hostid' do
      chef_run.converge(described_recipe)

      expect(chef_run).not_to run_execute('generate hostid')
    end

    context 'execute' do
      before do
        chef_run.node.set['stackdriver']['gen_hostid'] = true
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

  context 'tags' do
    let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'amazon', version: '2015.03') }

    it 'do not create template' do
      chef_run.converge(described_recipe)

      expect(chef_run).not_to create_template('/opt/stackdriver/extractor/etc/extractor.conf.d/tags.conf')
    end

    context 'template' do
      before do
        chef_run.node.set['stackdriver']['tags'] = {
          'test1' => '1',
          'test2' => '2'
        }
        chef_run.converge(described_recipe)
      end

      it 'create' do
        expect(chef_run).to create_template('/opt/stackdriver/extractor/etc/extractor.conf.d/tags.conf')
      end

      it 'include test1=1' do
        expect(chef_run).to render_file('/opt/stackdriver/extractor/etc/extractor.conf.d/tags.conf').with_content(/^test1=1$/)
      end
    end
  end

  context 'disable' do
    let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'amazon', version: '2015.03') }

    before do
      chef_run.node.set['stackdriver']['enable'] = false
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
      expect(chef_run).not_to create_template(chef_run.node['stackdriver']['config_path'])
    end
  end
end
