class Song

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.create_from_filename(filename)
    new_thing = new_from_filename(filename)
    @@all << new_thing
  end

  def self.new_from_filename(filename)

    divided_filename = filename.split(" - ")

    artist_name = divided_filename[0]
    song_name = divided_filename[1]
    genre_name = divided_filename[2].chomp(".mp3")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    new(song_name, artist, genre)

  end

  def self.find_by_name(name)
    all.find do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    if find_by_name(name) == nil
      create(name)
    else
      find_by_name(name)
    end
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def self.create(name)
    new_song = Song.new(name)
    new_song.save
    new_song
  end

end
