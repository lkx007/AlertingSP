module Storage
  class Luns< W4NTest
    def setup
      @@prefilter="parttype='LUN'"
    end
    def test_thick_lun_has_spindles
      #assert_property_match filter: "parttype='LUN' & dgstype='Thick'", property: :spindles, regexp: /\|?([0-9A-F]{2}){1,2}\|?/
      #assert_property_match filter: "parttype='LUN' & dgstype='Thick'", property: :spindles, regexp: /\d{2}\|?/
      assert_property_match filter: "#{@@prefilter} & dgstype='Thick'", property: :spindles, regexp: /\|?[0-9A-F]{2,4}\|?/
    end
    def test_partsn
      assert_property_match filter: @@prefilter, property: :partsn, regexp: /[0-9A-F]{32,40}\|?/
    end
    #bare minimal properties a LUN must have (no matter of the technology)
    def test_must_have_properties
      assert_has_properties filter: @@prefilter, properties: ['svclevel', 'ismapped', 'ismasked', 'disksize', 'dgraid', 'dgtype', 'purpose']
    end
    def test_purpose
      assert_property_match filter: @@prefilter, property: :purpose, regexp: /System Resource|Remote Replica|Local Replica|Pool Contributor|Primary/
    end
    def test_raid
      assert_property_match filter: @@prefilter, property: :dgraid, regexp: /raid/i
    end
    #luntagid must be present everywhere
    def test_luntagid
      assert_property_match filter: @@prefilter, property: :luntagid, regexp: /(\w)+_(\w){4}/
    end
    #mapped & masked are always 0 or 1
    def test_mapped_masked
      assert_property_match filter: @@prefilter, property: :ismapped, list: %w{0 1}
      assert_property_match filter: @@prefilter, property: :ismasked, list: %w{0 1}
    end
    #Pre-defined service level
    def test_svclevel_list
      svclevels=Filter[@@prefilter].get_distinct(:svclevel).map(&:svclevel)
      svclevels.each do |i|
        assert ['Platinum', 'Silver', 'Bronze', 'System Resource','FAST VP','Other','Pool Contributor', 'Gold'].include?(i) , "Service Level #{i} is unknown"
      end
    end
    def test_dgstype
      assert_property_match filter: @@prefilter, property: :dgstype, list: %w{Thick Thin Snap}
    end
    def test_svclevel_straight
     assert_property_match filter: @@prefilter, property: :svclevel, regexp: /Platinum|Silver|Bronze|System Resource|FAST VP|Other|Pool Contributor|Gold/
    end
    #To be flagged as used a LUN must be mapped & masked
    def test_isused
       luns=Filter["#{@@prefilter} & dgstype='Thick'"].get_distinct(:device,:part,:isused,:ismasked,:ismapped)     
       res=luns.select do |lun|
         lun.isused.to_i != (lun.ismapped.to_i & lun.ismasked.to_i)
       end
       assert_empty res
    end
  end
end
