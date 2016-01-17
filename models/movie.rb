require_relative '../connections/service_store_db.rb'

class Movie < ServiceStoreDb
  self.primary_key = :id
end
