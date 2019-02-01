require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( details )
    @id = details['id'].to_i if details['id']
    @name = details['name']
    @funds = details['funds'].to_f
  end

  # Get the films for a specific customer
  def films()
    sql = "SELECT films.*
      FROM films
      INNER JOIN tickets
      ON tickets.film_id = films.id
      WHERE tickets.customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    result = film_data.map{|film| Film.new(film)}
    return result
  end

  def save()
    sql = "INSERT INTO customers
    ( name, funds ) VALUES ( $1, $2 ) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET ( name, funds ) = ( $1, $2 ) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #Basic extension code not necessary?
  # def buytickets()
  #   films = self.films()
  #   film_price = films.map{|film| film.price}
  #   total_cost = film_price.sum
  #   @funds -= total_cost
  # end
  #
  # # can get same thing from just calling films from console
  # def check_num_films
  #   films = self.films()
  #   return films.length
  # end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    return customers.map{|customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end
end
