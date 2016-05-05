module Losaq142
  class Main < W4NTest
    #losaq142 is sun physical host connected to a VNX array
    def setup
      @metrics=Filter["device='losaq142%'"]
    end
    #we are supposed to have 44 SAN disk all of them are tight to VNX 364
    def test_san_disks
      san=@metrics["parttype=='Disk' & isremote=='true'"].get_distinct(:part,:partsn,:device)
      assert san.size == 44, "Wrong # of SAN disk for losaq142"
      san.each do |s|
        assert_match /^60060160/, s[:partsn]
      end
    end
  end
end
