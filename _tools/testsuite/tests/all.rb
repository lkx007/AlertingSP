module All
  class Device < W4NTest
    def test_has_part_has_parttype
      assert_has_properties filter: 'part', properties: [:parttype]
    end
    def test_devtype_values
      known_devtypes=["Array","Hypervisor", "Host", "FabricSwitch", "Router", "Switch", "Firewall", "VirtualMachine", "Datastore"]
      devtypes=Filter["*"].get_property(:devtype)
      assert_includes_all known_devtypes,devtypes
    end
    def test_devtype
#      assert_property_match property: :devdesc, regexp: /^.?1.3.6.*/
      assert_has_properties filter: '*', properties: [:devtype]
    end
    #devdesc should not be a sysobject id
    def test_devdesc
#      assert_property_match property: :devdesc, regexp: /^.?1.3.6.*/
      assert_has_properties filter: '*', properties: [:devdesc]
    end
    def test_must_have_device
      assert_no_metric '!device'
    end
    def test_ip
      ipre=/^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}/
      assert_property_match regexp: ipre,property: :ip
    end
    def test_no_remove_me_metric
      assert_no_metric "name='Remove%'"
    end
  end

  class Units < W4NTest 
    def test_unit_is_always_present
      assert_no_metric "!unit"
    end
    def test_throughput_in_mbs
      assert_property_match filter: "name='%Throughput'", property: :unit, regexp: /^MB\/s$/
    end
    def test_requests_in_iops
      assert_property_match filter: "name='%Requests'", property: :unit, regexp: /^IOPS$/
    end
    def test_latency_in_ms
      assert_property_match filter: "name='%Latency'", property: :unit, regexp: /^ms$/
    end
    def test_capacities_in_gb
      assert_property_match filter: "! parttype='Memory' & name='%Capacity%'", property: :unit, regexp: /^GB$/
    end
  end

  class MetricName < W4NTest
    def test_count_unit
      assert_property_match filter: "name='%Count%'",property: :unit, regexp: /^nb$/
    end
    def test_utilization_unit
      assert_property_match filter: "name='%Utilization%'",property: :unit, regexp: /^%$/
    end
    def test_uptime
      assert_property_match filter: "name='Uptime'", property: :unit, regexp: /^s$/
    end
  end
  class Availability < W4NTest
    # all +Availability+ metrics should have a +unit+
    def test_unit_exists
      assert_no_metric "name=='Availability' & !unit"
    end
    # all +Availability+ metrics should have '%' as +unit+
    def test_unit_is_percent
      assert_no_metric "name=='Availability' & unit & !(unit=='%')"
    end
  end
 end
