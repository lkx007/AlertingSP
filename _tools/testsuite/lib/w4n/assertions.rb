module Minitest::W4NAssertions
  # checks no metric matches +filter+
  def assert_no_metric *filter
    assert_n_metrics 0,*filter
  end
  # checks +n+ metrics match +filter+
  def assert_n_metrics n,*filter
    c=Filter[*filter].count
    assert_equal n,c,"Count mismatch for #{filter}"
  end
  # checks there are metrics matching +filter+
  def assert_has_metrics *filter
    c=Filter[*filter].count
    assert c>0,"No metrics exist for #{filter}"
  end
  def assert_property_match regexp: nil, property: nil,filter: nil, list: nil
    raise ArgumentError,"Can't use both list and regexp" if list and regexp
    properties=Filter[*[property.to_s,filter].compact].get_property(property)
    test=regexp ? proc {|x| regexp.match x} : proc {|x| list.include? x}
    non_matching=properties.reject &test
    assert_empty non_matching,"Some '#{property}' properties do not match #{(regexp||list).inspect} (#{non_matching.size} out of #{properties.size})"
  end
  # checks that metrics matching +filter+ have all the properties listed in +properties+
  def assert_has_properties filter: nil, properties: []
    all=Filter[*filter].count
    with=Filter[*[filter,*(properties.map &:to_s)]].count
    assert all==with,"Some metrics for \"#{filter}\" have no #{properties} (#{all-with} out of #{all})"
  end
  # checks all elements in +cands+ are included in +list+
  def assert_includes_all list,cands
    baddies=cands.reject do |cand|
      list.include? cand
    end
    assert baddies.empty?,"#{baddies} not in #{list}"
  end
  def assert_expand_has_names filter: nil, expansion: nil, names: nil
    ex=Filter[*filter].get_all.expand_on *expansion
    errors=ex.map do |l|
      n=l.map &:name
      missing=names-n
      missing.empty? ? nil : [missing,expansion.map do |x| l.first[x] end]
    end.compact
    msg=[
      "Missing names for #{filter} expanded on #{expansion}:",
      "Name(s) | Expansion values",
      *errors.map do |e| [*e.first,'|',*e.last.map do |x| "\"#{x}\"" end].join ' ' end
    ].join "\n"
    assert errors.empty?,msg
  end
  def assert_expand_has_property_values filter: nil, expansion: nil, **prop_hash
    ex=Filter[*filter].get_all.expand_on *expansion
    errors=ex.map do |l|
      prop_hash.each_pair.map do |k,v|
        n=l.map &k
        missing=v-n
        missing.empty? ? nil : [k,missing,Hash[expansion.map {|x| [x,l.first[x]]}]]
      end
    end.flatten(1).compact
    msg=[
      "Missing property values for #{filter} expanded on #{expansion} (#{errors.size} errors for #{ex.size} expansions):",
      *errors.map do |e| "Missing: %s=%s for: %s" % e end
    ].join "\n"
    assert errors.empty?,msg
  end
end
