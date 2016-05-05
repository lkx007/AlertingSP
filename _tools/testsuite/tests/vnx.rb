module VNX
  class Block < W4NTest
    def setup
      @@prefilter="source='VNX%' & datatype='Block'"
    end
    def test_serialnb
      assert_property_match filter: @@prefilter, property: :serialnb, regexp: /APM\d{11}/
    end
  end
end
