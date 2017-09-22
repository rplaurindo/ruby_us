class Class

  def extend? constant
    (ancestors - [self]).include? constant
  end

  def descendants
    ObjectSpace.each_object(Class).select do |cls|
      cls.extend? self
    end
  end

  def extended_by? constant
    descendants.include? constant
  end

end
