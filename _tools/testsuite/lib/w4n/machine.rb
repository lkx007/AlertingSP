require 'sax-machine'

module W4NSAXMachine
  class << self
    def get_object_properties xml
      GetObjectProperties::Handler.new.parse(xml).to_metrics
    end
    def get_distinct_property_records xml,*props
      GetDistinctPropertyRecords::Handler.new.parse(xml).to_metrics(*props)
    end
  end
  module GetObjectProperties
    class Value
      include SAXMachine
      attribute :property
      value     :value
      def enrich m
        m[property.to_sym]=value
      end
    end
    class Properties
      include SAXMachine
      attribute :id
      elements :"ns2:value", as: :values, class: Value
      def to_metric
        m=Metric.new
        m[:id]=self.id
        self.values.each do |y|
          y.enrich(m)
        end
        m
      end
    end
    class Handler
      include SAXMachine
      elements :"ns2:properties", as: :properties, class: Properties
      def to_metrics
        self.properties.map &:to_metric
      end
    end
  end
  module GetDistinctPropertyRecords
    class Value
      include SAXMachine
      value :value
    end
    class Record
      include SAXMachine
      elements :"ns2:value", as: :values, class: Value
    end
    class Handler
      include SAXMachine
      elements :"ns2:record", as: :records, class: Record
      def to_metrics(*props)
        self.records.map do |x| Metric.new Hash[(props.zip x.values.map &:value)] end
      end
    end
  end
end
