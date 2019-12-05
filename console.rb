require('pry')
require_relative('./models/casting')
require_relative('./models/movie')
require_relative('./models/star')

movie1 = Movie.new({
  'title' => 'The Godfather',
  'genre' => 'drama'
 })

star1 = Star.new({
  'first_name' => 'Marlon',
  'last_name' => 'Brando'
  })

casting1 = Casting.new({
  'movie_id' => movie1.id,
  'star_id' => star1.id,
  'fee' => 1000
  })


binding.pry
nil
