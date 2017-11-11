class Class

  def attr_accessor *vars
    @attributes ||= []
    @attributes.concat vars
    super *vars
  end

  def attr_reader *vars
    @attributes ||= []
    @attributes.concat vars
    super *vars
  end

  def attr_writer *vars
    @attributes ||= []
    @attributes.concat vars
    super *vars
  end

  def attributes
    @attributes.nil? ? self.new.instance_variables : (self.new.instance_variables | @attributes)
  end

  def extend? constant
    (ancestors - [self]).include? constant
  end

  def descendants
    ObjectSpace.each_object(Class).select do |c|
      c.extend? self
    end
  end

  def is_extended_by? constant
    descendants.include? constant
  end

end
