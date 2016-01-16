require "active_record"
require_relative "../helpers/yaml_reader"

class ServiceStoreDb < ActiveRecord::Base
  extend YamlReader

  self.abstract_class = true
  self.establish_connection(get_file(:database)["ServiceStore"])
end
