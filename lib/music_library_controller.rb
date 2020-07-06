require "pry"
class MusicLibraryController
  attr_accessor :path
  @@list_array = []

  def initialize(path="./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"  

    while (input = gets.chomp) != 'exit'
      puts input
    end      
  end

  def list_songs
    @@list_array.clear
    Song.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
      puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
      temp_array = []
      temp_array.push(i)
      temp_array.push(s.artist.name)
      temp_array.push(s.name)
      temp_array.push(s.genre.name)
      @@list_array << temp_array
    end
  end

  def list_artists
    Artist.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
      puts "#{i}. #{s.name}"
    end
  end

  def list_genres
    Genre.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
      puts "#{i}. #{s.name}"
    end
  end

  def list_songs_by_artist
    input = gets.chomp
    puts "Please enter the name of an artist:"

    Artist.all.each do |artist|
      if artist.name == input
        artist.songs.sort do |a, b| 
          a.name <=> b.name
        end.each.with_index(1) do |s, i|
          puts "#{i}. #{s.name} - #{s.genre.name}"
        end
      end
    end
  end

  def list_songs_by_genre
    input = gets.chomp
    puts "Please enter the name of a genre:"

    Genre.all.each do |genre|
      if genre.name == input
        genre.songs.sort do |a, b| 
          a.name <=> b.name
        end.each.with_index(1) do |s, i|
          puts "#{i}. #{s.artist.name} - #{s.name}"
        end
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    list_songs
    input = gets.chomp

    fixed_input = input.to_i - 1
    song_name = @@list_array[fixed_input][2]
    artist_name = @@list_array[fixed_input][1]
    puts "Playing #{song_name} by #{artist_name}"

    # if Song.count <= fixed_input
    #   puts "Playing #{song_name} by #{artist_name}"
    # else
    #   puts "Invalid number entered"
    # end
  end
end