require('pry')
require_relative('./models/casting')
require_relative('./models/movie')
require_relative('./models/star')

Casting.delete_all
Movie.delete_all
Star.delete_all

movie1 = Movie.new({
  'title' => 'The Godfather',
  'genre' => 'drama'
 })
movie1.save

star1 = Star.new({
  'first_name' => 'Marlon',
  'last_name' => 'Brando'
  })
star1.save

casting1 = Casting.new({
  'movie_id' => movie1.id,
  'star_id' => star1.id,
  'fee' => 1000
  })
casting1.save


binding.pry
nil
