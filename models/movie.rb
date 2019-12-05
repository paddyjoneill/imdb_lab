require_relative('../db/sql_runner')

class Movie

  attr_reader :id
  attr_accessor :title, :genre, :budget

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget'].to_i
  end

  def save()
    sql = "
    INSERT INTO movies (
      title, genre, budget
    )
    VALUES
    ($1, $2, $3)
    RETURNING id;
    "
    values =[@title, @genre, @budget]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "
    SELECT * FROM movies
    "
    result = SqlRunner.run(sql)
    movies = result.map{|movie| Movie.new(movie)}
    return movies
  end

  def self.delete_all()
    sql = "
    DELETE FROM movies
    "
    SqlRunner.run(sql)
  end

  def delete()
    sql = "
    DELETE FROM movies WHERE id = $1
    "
    values [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "
    UPDATE movies SET (
      title, genre, budget
    ) = (
      $1, $2, $3
    ) WHERE id = $4;
    "
    values = [@title, @genre, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def stars
    sql = "
      SELECT stars.* FROM stars
      INNER JOIN castings
      ON castings.star_id = stars.id
      WHERE movie_id = $1
      "
    values =[@id]
    results = SqlRunner.run(sql, values)
    stars = results.map { |star| Star.new(star) }
    return stars
  end

  def budget_remaining()
    sql = "
       SELECT castings.fee FROM castings
       WHERE movie_id = $1
    "
    values = [@id]
    results = SqlRunner.run(sql,values)
    fees = results.map { |fee| fee  }
    remaining_budget = @budget
    for fee in fees
      remaining_budget -= fee['fee'].to_i
    end
    return remaining_budget
  end


end
