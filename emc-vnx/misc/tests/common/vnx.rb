def test_luntagid_for_block
  luns=@metrics.filter{parttype=='LUN'}.expand{part}
  luns.each do |d|
    d.each_metric do
      assert_match /(\w)+_(\w){4}/, luntagid
    end
  end
end

def test_luntagid_for_file
  luns=@metrics.filter{parttype=='Disk'}.expand{part}
  luns.each do |d|
    d.each_metric do
      assert_match /(\w)+_(\w){4}/, luntagid
    end
  end
end


def test_devtype
  @metrics.each_metric do
    assert_equal 'Array',devtype
  end
end

def test_array_capacities
  arrays=@metrics.query{not parttype}.expand{device}
  arrays.each do |x|
    n=x.get{name}
    assert_at_least_once %w{RawCapacity ConfiguredUsable RAIDOverheadCapacity HotSpareCapacity UnusableCapacity},n
  end
end

def test_luns
  luns=@metrics.filter{parttype=='LUN'}.expand{part}
  refute_empty luns
  luns.each do |d|
    names=d.get{name}
    #assert_no_duplicates names
    assert_subset %w{Capacity ReadThroughput WriteThroughput ReadRequests WriteRequests},names
    d.each_metric do
      assert_match /raid/i, dgraid
      assert_includes ['EFD','Flash Drive','SATA','FC'],disktype
    end
  end
end
