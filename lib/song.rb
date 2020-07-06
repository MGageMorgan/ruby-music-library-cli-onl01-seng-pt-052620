require 'pry'

class Song
  attr_accessor :name, :artist, :genre, :filename

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    @artist = artist
    @genre = genre
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.find_by_name(name)
    Song.all.find do |song|
        song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    if Song.find_by_name(name) == nil 
        Song.create(name)
    else
        Song.find_by_name(name)
    end
  end

  def self.new_from_filename(filename)
    artist = filename.chomp(".mp3").split(" - ")[0]
    title = filename.chomp(".mp3").split(" - ")[1]
    genre = filename.chomp(".mp3").split(" - ")[2]
    new_artist = Artist.find_or_create_by_name(artist)
    new_genre = Genre.find_or_create_by_name(genre)
    new_song = Song.find_or_create_by_name(title)
    new_song = Song.new(title, new_artist, new_genre)
    new_song
  end

  def self.create_from_filename(filename)
    new_song = self.new_from_filename(filename)
    new_song.save
  end
end