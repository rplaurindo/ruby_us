module RubyUs
  extend self

  def root_path
    File.expand_path("../..", __FILE__)
  end

  def lib_path
    File.join(root_path, "lib")
  end

  def spec_name
    File.basename __FILE__, ".rb"
  end
  private :root_path, :lib_path, :spec_name

  def timestamp
    Time.now.strftime "%y%m%d%H%M%S%L%N"
  end

  Dir[File.join(lib_path, spec_name, "**/*.rb")].each do |file|
    require file
  end

end
