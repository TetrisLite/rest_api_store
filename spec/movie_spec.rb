describe "Rest API" do
  context "for movies endpoint" do
    context "HTTP Get request" do
      it 'returns all movies' do
        #get the count of all the records from the movie table in the database
        expected_number_of_movies = Movie.all.size
        #compare that with a count of whats returned from the movies api endpint '/api/movies'
        parsed_json_response = JSON.parse(RestClient.get('http://localhost:4567/api/movies'))
        actual_number_of_movies = parsed_json_response.size
        expect(expected_number_of_movies).to eql(actual_number_of_movies)
      end

      it 'returns movies by id' do
        #specify an id
        expected_id = 2
        #check the details for the id from the db
        expected_movie = Movie.find(expected_id)
        #compare that against the id from the service endpoint
        parsed_json_response = JSON.parse(RestClient.get("http://localhost:4567/api/movies/#{expected_id}"))

        expect(expected_movie.title).to eql(parsed_json_response['title'])
        expect(expected_movie.director).to eql(parsed_json_response['director'])
        expect(expected_movie.year).to eql(parsed_json_response['year'])
        expect(expected_movie.synopsis).to eql(parsed_json_response['synopsis'])

      end

      it 'returns a 404 error response for an invalid id' do
        # invalid_id = 12
        # response = RestClient.get("http://localhost:4567/api/movies/#{invalid_id}")
        # expect(response.code).to eql(500)
      end
    end

    context "HTTP Post request" do
      it "" do
        pending "not yet implemented"
      end
    end

    context "HTTP Delete request" do
      it 'deletes the movies by the given id' do
        # go the Movie table and confirm the existense of the last record
        # now store the value of that id
        movie_id = Movie.last.id
        # now make a request to the endpoint to delete by that id
        RestClient.delete("http://localhost:4567/api/movies/#{movie_id}")
        # confirm the deleted last record by using the find method on that id
        # deleted_movie_id = Movie.find(movie_id)
        # and expect to get nil response as confirmation of the delete.
        expect(Movie.find(movie_id)).to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "HTTP Put request" do
      pending "not yet implemented"
    end
  end
end
