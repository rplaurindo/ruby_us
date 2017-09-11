class Float

  def format
    self % 1 === 0 ? self.to_i : self
  end

end
