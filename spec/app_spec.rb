require "./App"

describe "#debrackafy" do
	it "should remove brackets from a given word" do
		expect(debrackafy("[Genre]")).to eq("Genre")
	end
end

describe "#grab_data_from_dir" do
	test_path = "data"
	test_array_return = Dir.entries("data").select {|f| !File.directory? f}
	it "should grab data from given path and return an array" do
		expect(grab_data_from_dir(test_path)).to eq(test_array_return)
	end
end

describe "#create_regex_format_array" do
	it "should create array of just 'Artist Name' given format 'Artist Name - Song Name [genre_name].mp3' and appropriate regex format" do
		artist_name_regex = /((.*\w*) (?=\-))/
		test_array = ["A$AP Rocky - Peso [dance].mp3"]
		expect(create_regex_format_array(artist_name_regex, test_array)).to eq(["A$AP Rocky"])
	end
end

describe "#create_objects_array" do
	it "should create an object array equal to new of items in given array" do
		test_object_type = Song
		test_name_array = ["Peso", "Mona Lisa"]
		expect(create_objects_array(test_object_type, test_name_array.length)[0]).to be_a(Song)
	end
end

describe "#create_artist_objects_hash" do
	it "should return hash with unique values for artist objects" do
		test_name_array = []
		test_name_array << "Keef" << "Fresco" << "Keef"
		expect(create_artist_objects_hash(test_name_array).keys).to eq([:Keef, :Fresco])
	end
	
end

describe "#set_name_for_object_array" do
	it "should set the name of the objects with given values of name array" do
		test_object_array = [Song.new]
		test_name_array = ["A$AP Rocky", "Kdizzle"]
		expect(set_name_for_object_array(test_object_array, test_name_array)[0].name).to eq("A$AP Rocky")
	end
end

describe "#add_genres_to_songs" do
	it "should add genre to song" do
		test_song = Song.new
		test_song.name = "Kdizzle"
		test_song_2 = Song.new
		test_song_2.name = "Kdizzle_2"
		test_genre = Genre.new
		test_genre.name = "Hard Rock"
		test_genre_2 = Genre.new
		test_genre_2.name = "Hip-Hop"
		test_song_object_array = [test_song, test_song_2]
		test_genre_objects_array = [test_genre, test_genre_2]

		expect(add_genres_to_songs(test_song_object_array,test_genre_objects_array)[0].genre.name).to eq("Hard Rock")
	end
end

describe "#add_song_to_artist" do
	it "should add song to artist" do
		test_all_songs = ["Kphilly - Kdizzle [Hard Rock]", "Kphilly_2 - Kdizzle_2 [Hip-Hop]"]
		test_song = Song.new
		test_song.name = "Kdizzle"
		test_song_2 = Song.new
		test_song_2.name = "Kdizzle_2"
		test_genre = Genre.new
		test_genre.name = "Hard Rock"
		test_genre_2 = Genre.new
		test_genre_2.name = "Hip-Hop"
		test_song_object_array = [test_song, test_song_2]
		test_genre_objects_array = [test_genre, test_genre_2]
		test_artist = Artist.new
		test_artist.name = "Kphilly"
		test_artist_2 = Artist.new
		test_artist_2.name = "Kphilly_2"
		test_artist_hash = {:"Kphilly" => test_artist, :"Kphilly_2"=> test_artist_2}

		test_song_object_array =  
		add_genres_to_songs(test_song_object_array,test_genre_objects_array)

		expect(add_song_to_artist(test_artist_hash, test_song_object_array,test_all_songs)[:"Kphilly_2"].songs[0].name).to eq("Kdizzle_2")

		expect(add_song_to_artist(test_artist_hash, test_song_object_array, test_all_songs)[:"Kphilly"].genres[0].name).to eq("Hard Rock")
	end

	# describe "#pick_artist" do
	# 	it "should return list of artist's songs and genres" do
			
	# 	end
	# end
end

