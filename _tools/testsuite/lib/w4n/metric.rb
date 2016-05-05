require 'ostruct'

class Metric < OpenStruct
  def explode property,separator='|'
    self[property].split(separator).map do |np|
      n=self.clone
      n[property]=np
      n
    end
  end
end

class Array
  def explode property,separator='|'
    self.map do |e| e.explode property,separator end.flatten
  end
  def expand_on *properties
    self.group_by do |m|
      properties.map do |p|
        m[p]
      end
    end.reject do |k|
      k.include? nil
    end.values
  end
end
