require './lib/artist'
require './lib/genre'
require './lib/song'
require 'debugger'


class Playlister
	ARTIST_NAME_REGEX = /((.*\w*) (?=\-))/
	SONG_NAME_REGEX = /(?<=\-).*(?=\[)/
	GENRE_NAME_REGEX = /\[.*\]/

	attr_reader :artist_objects_hash, :song_objects_array, :genre_objects_hash

	def initialize
		setup
	end

	def debrackafy(word)
		word.gsub!(/\[/,"").gsub!(/\]/, "")
	end

	def grab_data_from_dir(path)
		Dir.entries(path).select {|f| !File.directory? f}
	end

	def create_regex_format_array(regex_format, values_array)
		values_array.collect do |value|
			regex_format.match(value).to_s.strip
		end
	end

	def create_objects_array(object_type, number_of_objects)
		object_array = []
		number_of_objects.times do
			object_array << object_type.new
		end
		object_array
	end

	def create_artist_objects_hash(artist_name_array)
		artist_name_hash = {}
		artist_name_array.each do |name|
			artist_name_hash[name.to_sym] = Artist.new
			artist_name_hash[name.to_sym].name = name
		end
		artist_name_hash
	end
	#Refactor these two
	def create_genre_objects_hash(genre_name_array)
		genre_name_hash = {}
		genre_name_array.each do |genre|
			genre_name_hash[genre.to_sym] = Genre.new
			genre_name_hash[genre.to_sym].name = genre
		end
		genre_name_hash
	end

	def set_name_for_object_array(object_array, name_array)
		object_array.each_with_index do |object, index|
			object.name = name_array[index]
		end
	end

	def add_genres_to_songs(song_objects_array, genre_objects_hash, all_the_songs)
		song_objects_array.each_with_index do |song, index|
			genre_name = debrackafy(GENRE_NAME_REGEX.match(all_the_songs[index])[0].strip)
			song.genre = genre_objects_hash[genre_name.to_sym]
		end
	end


	def add_song_to_artist(artist_object_hash, song_objects_array, all_the_songs)
		song_objects_array.each_with_index do |song, index|
			artist_name = ARTIST_NAME_REGEX.match(all_the_songs[index])		
			artist_object_hash[artist_name[0].strip.to_sym].add_song(song)
		end
		artist_object_hash
	end



	#Play game

	def pick_artist(artist_name, artist_objects_hash)
		puts "\n#{artist_name} - #{artist_objects_hash[artist_name.to_sym].songs.count} songs"
		artist_objects_hash[artist_name.to_sym].songs.each_with_index do |song, index|
			puts "#{index+1}. #{song.name} - #{song.genre.name}"
		end
		
	end

	def display_artists(artist_objects_hash)
		puts "There are #{artist_objects_hash.count} total artists"
		artist_objects_hash.sort.each do |artist, object|		
			puts "#{artist} - #{object.songs.count} songs"
		end 
		puts "Which Artist?"
		pick_artist(gets.chomp, artist_objects_hash)
	end

	def pick_genre(genre_name, genre_objects_hash)
		song_artist_hash = {}
		genre_objects_hash.each do |genre, object|
			song_artist_hash[genre.to_sym] ||= {}
			song_artist_hash[genre.to_sym][:songs] ||= {}

			song_artist_hash[genre.to_sym][:artists] ||= {}

			song_artist_hash[genre.to_sym][:songs] = object.songs.count
			song_artist_hash[genre.to_sym][:artists] = object.artists.count
		end #For sorting

		puts "\n#{genre_name.upcase}"	
		
		genre_objects_hash[genre_name.to_sym].artists.each_with_index do |artist, index|				
				artist.songs.each do |song|
					puts "#{index+1}: #{artist.name} - #{song.name}\n" if song.genre.name == genre_name
					
					end
			end
	end


	def display_genre(genre_objects_hash)
		puts "There are #{genre_objects_hash.count} genres"
		genre_objects_hash.each do |genre, object|
			puts "#{genre}: #{object.songs.count} Songs and #{object.artists.count} Artists"
		end 
		puts "Select genre: "
		pick_genre(gets.chomp, genre_objects_hash)
	end

	def setup
		all_the_songs = grab_data_from_dir("data")

		artist_name_array = create_regex_format_array(ARTIST_NAME_REGEX, all_the_songs)
		song_name_array = create_regex_format_array(SONG_NAME_REGEX, all_the_songs)
		genre_name_array = create_regex_format_array(GENRE_NAME_REGEX, all_the_songs)

		genre_name_array.collect do |genre|
			debrackafy(genre)
		end
		#remove the brackets from genre captured by the genre_array_regex
		
		#Step 1: Create new objects for each song, artist and genre
		@artist_objects_hash = create_artist_objects_hash(artist_name_array)
		@song_objects_array = create_objects_array(Song, song_name_array.length)
		@genre_objects_hash = create_genre_objects_hash(genre_name_array)

		#Step 2: Add name to song and genre.
		@song_objects_array = set_name_for_object_array(song_objects_array, song_name_array)

		#Step 3: Add genres to songs
		@song_objects_array = add_genres_to_songs(song_objects_array, genre_objects_hash, all_the_songs)

		#Step 4: Add song to artist
		@artist_objects_hash = add_song_to_artist(artist_objects_hash, song_objects_array, all_the_songs)

		#Parsing and object data structure complete
	end

	# puts "Welcome to the playlister app."
	# puts "Would you like to Browse by artist or genre?"
	# user_choice = gets.chomp.downcase
	# display_artists(artist_objects_hash) if user_choice == "artist"
	# display_genre(genre_objects_hash) if user_choice == "genre"
end