class Artist

  extend Concerns::Findable

  attr_accessor :name
  attr_reader :genre

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
    songs.collect do |song|
      song.genre
    end
    .uniq
  end

  def add_song(song)
    song.artist = self unless song.artist
    @songs << song unless songs.include?(song)
  end

  def songs
    @songs
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    new_artist = Artist.new(name)
    new_artist.save
    new_artist
  end

end
