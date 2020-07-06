class Genre
  extend Concerns::Findable

  attr_accessor :name, :artist, :name

  def initialize(name)
      @name = name
      @@all << self
  end
  
  @@all = []
  
  def self.all
      @@all
  end

  def self.destroy_all
      @@all.clear
  end

  def self.create(name)
      genre = Genre.new(name)
      genre.save
      genre
  end

  def save
      @@all << self
  end

  def songs
      Song.all.select {|song| song.genre == self}
  end

  def artists
      songs.collect {|song| song.artist}.uniq
  end
end