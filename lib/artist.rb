class Artist
	attr_accessor :name, :songs
	ARTISTS = Array.new

	def initialize
		ARTISTS << self
		@songs = []
	end

	def self.count
		ARTISTS.count
	end

	def self.reset_artists
		ARTISTS.clear
	end

	def self.all
		ARTISTS
	end

	def songs_count
		songs.count
	end

	def add_song(song)
		songs << song
		song.artist = self
	end

	def genres
		songs.collect {|song| song.genre}.uniq
	end

	def self.check_for_artist(artist_name)
		ARTISTS.detect {|artist| artist.name == artist_name}
	end

	def self.list
		ARTISTS.each_with_index do |artist, index|
			puts "#{index+1}. #{artist.name} - #{artist.songs_count} songs"
		end
		puts "There are #{ARTISTS.count} artists in our playlist."
	end

	def self.artist_page(user_choice)
		ARTISTS.each do |artist|
			if artist.name == user_choice
				puts " #{artist.name} - #{artist.songs_count} songs"
				artist.songs.each_with_index do |song,index|
					puts " #{index+1}. #{song.name} - #{song.genre.name.capitalize}"
				end
			end
		end
	end


end

