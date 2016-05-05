module VMAX
  class Device < W4NTest
    @@prefilter="source=='VMAX-Collector'"
    def test_serialnb
      assert_property_match filter: @@prefilter, property: :serialnb, regexp: /\d{12}/
    end
  end
  class Access < W4NTest
    @@prefilter="source=='VMAX-Collector' & parttype='Access'"
    def test_devices
      assert_property_match filter: @@prefilter, property: :devices, regexp: /[0-9A-F]{4},?/
    end
  end
end
