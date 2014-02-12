# encoding: UTF-8

require_relative 'spec_helper'

describe 'lldpd::default' do
  before do
    @chef_run = ChefSpec::Runner.new.converge 'lldpd::default'
  end

  it 'installs package' do
    @chef_run.should upgrade_package 'lldpd'
  end

  describe 'lldpd' do

    before do
      @file = @chef_run.template '/etc/default/lldpd'
    end

    it 'has proper owner' do
      expect(@file.owner).to eq 'root'
      expect(@file.group).to eq 'root'
    end

    it 'has proper modes' do
      expect(sprintf('%o', @file.mode)).to eq '644'
    end

    it 'has proper interface settings' do
      expect(@chef_run).to render_file(@file.name)
        .with_content 'DAEMON_ARGS="-r -I eth*"'
    end
  end
end
