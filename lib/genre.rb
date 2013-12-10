class Genre
	attr_accessor :name, :songs
	GENRES = Array.new

	def initialize
		GENRES << self
	end

	def self.all
		GENRES
	end
	
	def self.reset_genres
		GENRES.clear
	end

	def songs
		@songs ||= []
	end

	def artists
		songs.collect {|song| song.artist}.uniq
	end

	def self.check_for_genre(genre_name)
		GENRES.detect {|genre| genre.name == genre_name}
	end

	def self.list
		GENRES.sort! {|genre1, genre2| genre2.songs.count <=> genre1.songs.count}
		GENRES.each do |genre|
			puts "#{genre.name.capitalize}: #{genre.songs.count} Songs, #{genre.artists.count} Artists"
		end
		puts "There are #{GENRES.count} genres in our playlist."
	end

	def self.genre_page(user_choice)
		GENRES.each do |genre|
			if genre.name.capitalize == user_choice
				puts "#{genre.name.capitalize}"
				genre.songs.each_with_index do |song, index|
					puts " #{index+1}. #{song.artist.name} - #{song.name}"
				end
			end
		end
	end


end