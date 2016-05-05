module GenericHosts
  class Main < W4NTest
    def setup
      @metrics=Filter["datagrp='LMD-%'"]
    end
    def test_referenced_volumegroups_exist
      @metrics["parttype='FileSystem'"].get_distinct(:part,:device,:volgroup).each do |fs|
        assert_has_metrics @metrics["parttype='VolumeGroup'","device='#{fs.device}'","part='#{fs.volgroup}'"]
      end
    end
    def test_referenced_volumegroups_exist2
      fs_list=@metrics["parttype='FileSystem'"].get_distinct(:part,:device,:volgroup)
      vg_list=@metrics["parttype='VolumeGroup'"].get_distinct(:part,:device)
      fs_list.each do |fs|
        assert vg_list.find do |vg| vg.device==fs.device and vg.part == fs.volgroup end
      end
    end
  end

  class Disk < W4NTest
    @@prefilter="datagrp='LMD-%' & parttype='Disk'"
    def test_nasdisk_has_partsn
      assert_property_match filter: "#{@@prefilter} & isremote='true'", property: :partsn, regexp: /[0-9A-F]{32,40}\|?/
    end
  end
  class VolumeGroup < W4NTest
    def global_setup
      @@metrics=Filter["datagrp='LMD-%'"]
      @@vg_list=@@metrics["parttype='VolumeGroup'"].get_distinct(:part,:device)
      @@fs_list=@@metrics["parttype='FileSystem'"].get_distinct(:device,:volgroup)
      @@disk_list=@@metrics["parttype='Disk'"].get_distinct(:device,:volgroup)
    end
    def test_1
      @@fs_list.each do |fs|
        assert(@@vg_list.find do |vg| vg.device==fs.device and vg.part == fs.volgroup end)
      end
    end
    def test_2
      @@disk_list.each do |disk|
        disk.volgroup.split('|').each do |dvg|
          assert(@@vg_list.find do |vg| vg.device==disk.device and vg.part == dvg end)
        end
      end
    end
    def test_2b
      @@disk_list.explode(:volgroup).each do |disk|
        assert(@@vg_list.find do |vg| vg.device=disk.device and vg.part==disk.volgroup end)
      end
    end
    def test_2c
      #assert_xxx @@disk_list,@vg_list
    end
    def test_expand
      #assert_expand_has_names filter: "datagrp='LMD-%' & parttype='FileSystem'", expansion: [:part,:device], names: ['Capacity','CurrentUtilization','TOTO']
      #assert_expand_has_names filter: "parttype='FileSystem'", expansion: [:part,:device], names: ['Capacity','CurrentUtilization']
      assert_expand_has_property_values filter: "datagrp='LMD-%' & parttype='FileSystem'", expansion: [:part,:device], name: ['Capacity','CurrentUtilization']
      assert_expand_has_property_values filter: "parttype='FileSystem'", expansion: [:part,:device], name: ['Capacity','CurrentUtilization']
    end
  end
end
