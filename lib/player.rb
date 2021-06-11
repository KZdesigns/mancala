class Player
  attr_reader :name, :side #=> gives access to read these instance variables within the class

  def initialize(name, side) #=> creates a new player objeect 
    @name = name #=> sets the name of the player
    @side = side #=> sets the side of the player can be either 1 or 2
  end

  def prompt #=> recieves starting cup pos from player
    puts "#{@name}, please enter which cup you would like to start from: " #=> prompt that print to the player
    start_pos = gets.chomp.to_i #=> sets 'start_pos' to the input from the user and sets the input to an int
    if (start_pos.between?(1,6) && @side != 1 || 
        start_pos.between?(7,12) && @side != 2) #=> makes sure that the players starts on the right side if not it raises error
      raise "Not your side!"
    else
      start_pos #=> if now error returns a start_pos
    end
  end
end
