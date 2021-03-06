get "/api/movies" do
  format_response(Movie.all, request.accept)
end

get "/api/movies/:id" do
  # puts "before param"
  # puts params[:id]
  # puts "params over"
  movie ||= Movie.find(params[:id]) || halt(404)
  format_response(movie, request.accept)
end

post "/api/movies" do
  body = JSON.parse(request.body.read)
  movie ||= Movie.create(
    title: body["title"],
    director: body["director"],
    year: body["year"],
    synopsis: body["synopsis"]
  )
  status(201)
  format_response(movie, request.accept)
end

put "/api/movies/:id" do
  body = JSON.parse(request.body.read)
  movie ||= Movie.find_by(id: params[:id]) || halt(404)
  halt(500) unless movie.update(
    director: body["director"],
    title: body["title"],
    year: body["year"],
    synopsis: body["synopsis"]
  )
  format_response(movie, request.accept)
end

delete "/api/movies/:id" do

  movie ||= Movie.find_by(id: params[:id]) || halt(404)
  halt(500) unless movie.destroy
end
