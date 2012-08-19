describe_recipe "cookbook-lldpd" do
  include ::MiniTest::Chef::Assertions
  include ::MiniTest::Chef::Context
  include ::MiniTest::Chef::Resources

  describe "package" do
    it "installs" do
      package("lldpd").must_be_installed
    end
  end
end
