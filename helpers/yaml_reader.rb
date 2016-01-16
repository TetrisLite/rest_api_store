require 'yaml'

module YamlReader
  def get_file(filename)
    yaml_path = File.expand_path("../config/", __dir__)
    path_to_yaml = File.join(yaml_path,"#{filename.to_s}.yml" )
    YAML.load_file(path_to_yaml)
  end
end
