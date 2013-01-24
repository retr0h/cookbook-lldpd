require "chefspec"

describe "lldpd::default" do
  before do
    @chef_run = ::ChefSpec::ChefRunner.new.converge "lldpd::default"
  end

  it "installs package" do
    @chef_run.should upgrade_package "lldpd"
  end
end
