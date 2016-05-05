module VMware
  class Hypervisor < W4NTest
    @@prefilter="devtype=='Hypervisor'"
    def test_serialnb
      assert_property_match filter: @@prefilter, property: :serialnb, regexp: /\d{12}/
    end
    def test_kpsubnet
      assert_property_match filter: @@prefilter, property: :kpsubnet, regexp: /^((?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}\|?)+/
    end
    def test_vkpip
      assert_property_match filter: @@prefilter, property: :vkpip, regexp: /^((?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}\|?)+/
    end
  end

  class VirtualMachine < W4NTest
    @@prefilter="devtype=='VirtualMachine'"
    def test_devices
      assert_property_match filter: @@prefilter, property: :devices, regexp: /[0-9A-F]{4},?/
    end
    def test_vm_link_to_datastore
      ds_list=Filter["devtype=='Datastore'"].get_distinct(:device)
      vm_list=Filter["devtype=='VirtualMachine'"].get_distinct(:device,:datastor)
      vm_list.explode(:datastor).each do |vm|
        assert(ds_list.find { |ds| ds.device=vm.datastor }, "Failed to VM:#{vm.device} to datastore #{vm.datastor}")
      end
    end
  end

  class Datastore < W4NTest
    @@prefilter="devtype=='Datastore'"
    def test_has_esx
      assert_property_match filter: @@prefilter, property: :esx, regexp: /(\w+)\|?/
    end
    def test_vmfs_has_partsn
      assert_property_match filter: "#{@@prefilter} & type=='VMFS'", property: :partsn, regexp: /[0-9A-E]{1,40}\|?/
    end
    def test_datastore_link_to_esx
      ds_list=Filter["devtype=='Datastore'"].get_distinct(:device,:esx)
      esx_list=Filter["devtype=='Hypervisor'"].get_distinct(:device)
      ds_list.explode(:esx).each do |ds|
        assert(esx_list.find { |esx| esx.device=ds.esx }, "Failed to Datastore:#{ds.device} to Hypervisor:#{ds.esx}")
      end
    end
  end
end
