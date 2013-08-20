require "chefspec"

describe "lldpd::default" do
  before do
    @chef_run = ::ChefSpec::ChefRunner.new.converge "lldpd::default"
  end

  it "installs package" do
    @chef_run.should upgrade_package "lldpd"
  end

  describe "lldpd" do

    before do
     @file = @chef_run.template "/etc/default/lldpd"
    end

    it "has proper owner" do
      expect(@file).to be_owned_by "root", "root"
    end

    it "has proper modes" do
     expect(sprintf("%o", @file.mode)).to eq "644"
    end

    it "has proper interface settings" do
      expect(@chef_run).to create_file_with_content @file.name,
        'DAEMON_ARGS="-r -I eth*"'
    end
  end
end
