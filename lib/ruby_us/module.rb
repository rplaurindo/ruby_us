Object.send :remove_const, :Config
Config = RbConfig


class Module

  def deconstantize
    ancestor = ancestors.first
    splitted_trail = ancestor.to_s.split("::")
    trail_name = splitted_trail.slice(0, splitted_trail.length - 1).join("::")

    const_get(trail_name) if !trail_name.empty? && self.to_s != trail_name
  end

  def defines? constant, verbose=false
    constant = constant.to_s
    # try
    begin
      true if Object.send(:const_defined?, constant)
    # catch (e)
    rescue Exception => e
      $stderr.puts "Exception recovered when trying to check if the constant \"#{constant}\" is defined: #{e}" if verbose
      false
    end unless constant.empty?
  end

  def has_constants?
    true if constants.any?
  end

  def demodulize constant
    splitted_trail = constant.to_s.split("::")
    constant = splitted_trail.last

    const_get constant if defines?(constant)
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
