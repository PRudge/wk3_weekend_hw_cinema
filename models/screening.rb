require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :film_id, :time

  def initialize( details )
    @id = details['id'].to_i if details['id']
    @film_id = details['film_id'].to_i
    @screen_time = details['screen_time']
    @max_capacity = details['max_capacity']
  end

  def save()
    sql = "INSERT INTO screenings
    ( film_id, screen_time, max_capacity ) VALUES ( $1, $2, $3 ) RETURNING id"
    values = [@film_id, @screen_time, @max_capacity]
    screening = SqlRunner.run( sql, values ).first
    @id = screening['id'].to_i
  end

  def update()
    sql = "UPDATE screenings SET ( film_id, screen_time, max_capacity ) = ( $1, $2, $3 )
    WHERE id = $4"
    values = [@film_id, @screen_time, @max_capacity, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def self.all()
    sql = "SELECT * FROM screenings"
    values = []
    screenings = SqlRunner.run(sql, values)
    return screenings.map{|screening| Screening.new(screening)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    values = []
    SqlRunner.run(sql, values)
  end
end
