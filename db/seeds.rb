require 'open-uri'
require 'json'

puts "Cleaning database..."
Movie.destroy_all if Rails.env.development?
List.destroy_all if Rails.env.development?
Bookmark.destroy_all if Rails.env.development?

def create_lists
  puts "creating lists..."
  list_names = ["My watch list", "Must-watch classics", "Favourites", "Movies for holidays", "Ones I missed"]
  lists = list_names.map do |list_name|
    List.create!(name: list_name)
  end
  puts "Finished creating lists!"
  lists # Return the array of list records
end

def fetch_movies(url)
  puts "Fetching movies from API..."
  url = 'https://tmdb.lewagon.com/movie/top_rated'
  movies_serialized = URI.open(url).read
  JSON.parse(movies_serialized)
end

def create_movies(movies_data)
  puts "creating movies..."
  movies_data['results'].each do |movie|
    Movie.create!(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
      rating: movie['vote_average']
    )
  end
  puts "Finished!"
end


# assign the fetch to a variable
movies_data = fetch_movies('https://tmdb.lewagon.com/movie/top_rated')
create_movies(movies_data)
lists = create_lists # Capturing the lists returned by create_lists
movies = Movie.all
# create bookmarks for each list
puts "Creating bookmarks..."
number_of_movies_per_list = 3

lists.each_with_index do |list, index|
  # Selecting a range of movies based on the current index
  # This creates a range that does not overlap with other lists
  movie_subset = movies.drop(index * number_of_movies_per_list).first(number_of_movies_per_list)

  movie_subset.each do |movie|
    Bookmark.create!(list: list, movie: movie, comment: "Great movie!") # Creates a bookmark for each movie in the list
  end
end
puts "Finished creating bookmarks!"
