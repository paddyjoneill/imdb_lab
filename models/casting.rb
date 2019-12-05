require_relative('../db/sql_runner')

class Casting

  attr_reader :id
  attr_accessor :movie_id, :star_id, :fee

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id'].to_i
    @star_id = options['star_id'].to_i
    @fee = options['fee'].to_i
  end

  def save()
    sql = "
    INSERT INTO castings (
      movie_id, star_id, fee
    )
    VALUES
    ($1, $2, $3)
    RETURNING id;
    "
    values =[@movie_id, @star_id, @fee]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "
    SELECT * FROM castings
    "
    result = SqlRunner.run(sql)
    castings = result.map{|casting| Casting.new(casting)}
    return castings
  end

  def self.delete_all()
    sql = "
    DELETE FROM castings
    "
    SqlRunner.run(sql)
  end

end
