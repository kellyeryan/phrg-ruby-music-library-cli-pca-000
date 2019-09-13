class MusicLibraryController

  attr_accessor :path

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

    input = ''
    input = gets.chomp.downcase while input != 'exit'

    if "list songs"
        list_songs
    if "list artists"
        list_artists
    if "list genres"
        list_genres
    if "list artist"
        list_songs_by_artist
    if "list genre"
        list_songs_by_genre
    if "play song"
        play_song
              end
            end
          end
        end
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = ''
    input = gets.chomp.to_i

    if (1..Song.all.length).include?(input)

      song = Song.all.sort {|a, b| a.name <=> b.name }.fetch(input - 1).name

      artist = Song.all.sort {|a, b| a.name <=> b.name }.fetch(input - 1).artist.name

      puts "Playing #{song} by #{artist}"

    end
  end

  def list_songs_by_genre

    puts "Please enter the name of a genre:"
    input = ''
    input = gets.chomp
    if genre = Genre.find_by_name(input)
    genre.songs.sort {|a, b| a.name <=> b.name }.each_with_index do |g, index|
      puts "#{index + 1}. #{g.artist.name} - #{g.name}"
      end
    end
  end

  def list_songs_by_artist

    puts "Please enter the name of an artist:"
    input = ''
    input = gets.chomp
    if artist = Artist.find_by_name(input)
    artist.songs.sort {|a, b| a.name <=> b.name }.each_with_index do |s, index|
      puts "#{index + 1}. #{s.name} - #{s.genre.name}"
      end
    end
  end

  def list_genres
    Genre.all.sort {|a, b| a.name <=> b.name }.each_with_index do |c, index|
      puts "#{index + 1}. #{c.name}"
    end
  end

  def list_songs
    Song.all.sort {|a, b| a.name <=> b.name }.each_with_index do |c, index|
      puts "#{index + 1}. #{c.artist.name} - #{c.name} - #{c.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort { |a, b| a.name <=> b.name}.each_with_index do |c, index|
      puts "#{index + 1}. #{c.name}"
    end
  end
end
