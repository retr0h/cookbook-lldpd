# encoding: UTF-8

require_relative 'spec_helper'

describe 'lldpd::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'installs package' do
    expect(chef_run).to upgrade_package 'lldpd'
  end

  context 'lldpd default file' do
    let(:file) { chef_run.template '/etc/default/lldpd' }

    it 'has proper owner' do
      expect(file.owner).to eq 'root'
      expect(file.group).to eq 'root'
    end

    it 'has proper modes' do
      expect(format('%o', file.mode)).to eq '644'
    end

    it 'has proper interface settings' do
      expect(chef_run).to render_file(file.name)
        .with_content 'DAEMON_ARGS="-r -I eth*"'
    end
  end
end
