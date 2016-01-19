describe "Rest API" do

  let(:movies_endpoint) {'http://localhost:4567/api/movies'}

  context "for movies endpoint" do
    context "HTTP Get request" do
      it 'returns all movies' do
        #get the count of all the records from the movie table in the database
        expected_number_of_movies = Movie.all.size
        #compare that with a count of whats returned from the movies api endpint '/api/movies'
        parsed_json_response = JSON.parse(RestClient.get(movies_endpoint))
        actual_number_of_movies = parsed_json_response.size
        expect(expected_number_of_movies).to eql(actual_number_of_movies)
      end

      it 'returns movies by id' do
        #specify an id
        expected_id = 2
        #check the details for the id from the db
        expected_movie = Movie.find(expected_id)
        #compare that against the id from the service endpoint
        parsed_json_response = JSON.parse(RestClient.get("#{movies_endpoint}/#{expected_id}"))

        expect(expected_movie.title).to eql(parsed_json_response['title'])
        expect(expected_movie.director).to eql(parsed_json_response['director'])
        expect(expected_movie.year).to eql(parsed_json_response['year'])
        expect(expected_movie.synopsis).to eql(parsed_json_response['synopsis'])
      end

      it 'returns a 500 error response for an invalid id' do
        invalid_id = Movie.last.id + 1
        response = RestClient.get("#{movies_endpoint}/#{invalid_id}"){|response, request, result| response }
        expect(response.code).to eql(500)
      end
    end

    context "HTTP Post request" do
      it "creates a new movie" do
        params = {
          :director => "Francis #{rand(70000)}" ,
          :year => rand(1997..2016),
          :title => "The Hunger #{rand(1997..2016)} #{rand(1997..2016)}",
          :synopsis => "As the war of Panem escalates to the...."
        }

        response = RestClient.post movies_endpoint, params.to_json
        expect(response.code).to eql(201)
      end
    end

    context "HTTP Delete request" do
      it 'deletes the movies by the given id' do
        # go the Movie table and confirm the existense of the last record
        # now store the value of that id
        movie_id = Movie.last.id
        # now make a request to the endpoint to delete by that id
        RestClient.delete("#{movies_endpoint}/#{movie_id}")
        all_movie_ids = Movie.ids
        expect(all_movie_ids).to_not include movie_id
      end
    end

    context "HTTP Put request" do
      it "updates a record for a given id" do
        last_movie_id = Movie.last.id
        params = params = {
          :director => "Updated #{rand(70000)}" ,
          :year => rand(1997..2016),
          :title => "Updated The Hunger #{rand(1997..2016)} #{rand(1997..2016)}",
          :synopsis => "Updated As the war of Panem escalates to the...."
        }

        response = RestClient.put "#{movies_endpoint}/#{last_movie_id}", params.to_json
        expect(response.code).to eql(200)
        expect(response.headers[:server]).to eql('thin')
        expect(response.headers[:connection]).to eql('keep-alive')
      end
    end
  end
end
