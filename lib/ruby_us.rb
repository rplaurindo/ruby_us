module RubyUs

  Dir[File.join(lib_path, "**/*.rb")].each do |file|
    require file
  end

  private
    def root_path
      File.expand_path("../..", __FILE__)
    end

    def lib_path
      File.join(root_path, "lib")
    end

end
