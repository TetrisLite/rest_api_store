get "/api/movies" do
  format_response(Movie.all, request.accept)
end

get "/api/movies/:id" do
  movie ||= Movie.find(params[:id]) || halt(404)
  format_response(movie, request.accept)
end

post "/api/movies" do

end

put "/api/movies/:id" do

end

delete "/api/movies/:id" do

end
