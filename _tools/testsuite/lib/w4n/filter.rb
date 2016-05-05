require 'set'

class Filter < Set
  @@prefilter=nil
  def self.client= c
    @@client=c
  end
  def self.prefilter= p
    @@prefilter=p
  end
  def [] *x
    self.class.new self+x
  end
  def to_filter_string
    @fs||=self['#APG:ALL'][@@prefilter].to_s.encode xml: :text
  end
  def to_s
    self.map(&:to_s).reject(&:empty?).inject do |x,y| "#{x} & (#{y})" end || ''
  end
  def message *props
    "<tns:filter>#{to_filter_string}</tns:filter>\n"+props.map do |x| "<tns:property>#{x}</tns:property>" end.join("\n")
  end
  def count
    @@client.call(:get_object_count,message:message).xpath('//ns2:count').first.text.to_i
  end
  def available_properties
    @@client.call(:get_available_properties,message:message).xpath('//ns2:property/@name').map &:value
  end
  def get_property prop
    get_distinct(prop).map(&prop)
  end
  def get_all
    props=available_properties
    get *props
  end
  def get_distinct *props
    xml=@@client.call(:get_distinct_property_records,message:message(*props)).to_xml
    W4NSAXMachine.get_distinct_property_records(xml,*props)
  end
  def get *props
    xml=@@client.call(:get_object_properties,message:message(*props)).to_xml
    W4NSAXMachine.get_object_properties xml
  end
end
