class OptionSet

  attr_accessor :all, :value_map, :label_map

  def value_for(label)
    @label_map[label]
  end

  def label_for(value)
    @value_map[value]
  end


  def initialize(value_label_pairs)
    @all = value_label_pairs.map{ |value, label| Option.new(value, label) }
    @value_map = build_value_map(@all) # map of value to label
    @label_map = build_label_map(@all) # map of label to value

  end

  def build_value_map(options)
    result = {}
    options.each {|option| result[option.value] = option.label}
    result
  end

  def build_label_map(options)
    result = {}
    options.each {|option| result[option.label] = option.value}
    result
  end



end