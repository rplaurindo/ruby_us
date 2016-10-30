Object.send :remove_const, :Config
Config = RbConfig


class Module

  def demodulize
    splitted_trail = self.to_s.split("::")
    constant = splitted_trail.last

    const_get constant if defines?(constant)
  end
  private :demodulize

  def defines? constant, verbose=false
    splitted_trail = constant.split("::")
    trail_name = splitted_trail.first

    # try
    begin
      trail = Module.const_get(trail_name) if Object.send(:const_defined?, trail_name)
      splitted_trail.slice(1, splitted_trail.length - 1).each do |constant_name|
        trail = trail.send(:const_defined?, constant_name) ? trail.const_get(constant_name) : nil
      end
      true if trail
    # catch (e)
    rescue Exception => e
      $stderr.puts "Exception recovered when trying to check if the constant \"#{constant}\" is defined: #{e}" if verbose
    end unless constant.empty?
  end

  def deconstantize
    ancestor = ancestors.first
    splitted_trail = ancestor.to_s.split("::")
    trail_name = splitted_trail.slice(0, splitted_trail.length - 1).join("::")

    const_get(trail_name) if !trail_name.empty? && self.to_s != trail_name
  end

  def has_constants?
    true if constants.any?
  end

  def nestings counted=[], &block
    trail = self.to_s
    collected = []

    constants.each do |const_name|
      const_name = const_name.to_s
      const_for_try = "#{trail}::#{const_name}"
      constant = const_for_try.constantize

      begin
        constant_sym = constant.to_s.to_sym
        if constant && !counted.include?(constant_sym)
          counted << constant_sym

          if (constant.is_a?(Module) || constant.is_a?(Class))
            value = block_given? ? block.call(constant) : constant
            collected << value if value
            collected.concat constant.nestings(counted, &block) if constant.has_constants?
          end
        end
      rescue Exception
      end

    end

    collected
  end

end
