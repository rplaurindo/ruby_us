class String

  def present?
    empty? ? false : true
  end

  def snikize
    self.gsub(/::/, '/')
    .gsub(/([a-z\d])([A-Z])/, '\1_\2')
    .downcase
  end

  def constantize
    if Module.defines?(self)
      Module.send(:const_get, self)
    else
      demodulized = Module.demodulize(self).to_s
      Module.send(:const_get, demodulized) if Module.defines?(demodulized)
    end
  end

end
