require_relative '../connections/service_store_db.rb'

class Movie < ServiceStoreDb
  self.primary_key = :id
end

Movie.all.each do |movie|
  p movie.title
end
