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
      Module.const_get self
    else
      demodulized = self.split("::").last
      Module.const_get(demodulized) if Module.defines?(demodulized)
    end
  end

end
