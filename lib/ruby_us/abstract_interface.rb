module AbstractInterface

  class Interface
    def initialize constant, interface
      @constant = constant
      @interface = interface
    end

    def define_method method_name, &block
      @constant.module_eval do
        define_method method_name, &block
      end if block_given?
    end

    def define_singleton_method method_name, &block
      if block_given?
        if @constant.is_a? Class
          @constant.class_eval do
            define_singleton_method method_name, &block
          end
        elsif @constant != interface
          @constant::SingletonMethods.module_eval do
            define_method method_name, &block
          end
        end
      end
    end

  end

  class << self

    def included base
      base.extend SingletonMethods
      base.include SingletonMethods
    end

    def extended base
      base.is_a?(Module) ? base.include(self) : base.class.include(self) unless base.included_modules.include? self
    end

  end

  module SingletonMethods

    def implements interface, &block
      interface_instance = Interface.new self, interface
      interface.module_eval do
        block.call interface_instance
      end if block_given?
    end

    def needs_implement_method method_name
      interface = self.name
      define_method method_name do |*args|
        exception_message interface, method_name
      end
    end

    def needs_implement_singleton_method method_name
      self.module_eval do
        interface_name = self.name
        constant = self::SingletonMethods
        constant.module_eval do
          define_method method_name do |*args|
            singleton_exception_message interface_name, method_name
          end
        end
      end
    end

    private
      def exception_message interface, method_name
        constant = self.is_a?(Module) ? self : self.class
        raise NotImplementedError, "#{constant} needs to implement '#{method_name}' method of interface #{interface}"
      end

      def singleton_exception_message interface, method_name
        constant = self.is_a?(Module) ? self : self.class
        raise NotImplementedError, "#{constant} needs to implement '#{method_name}' singleton method of interface #{interface}"
      end

  end
end
