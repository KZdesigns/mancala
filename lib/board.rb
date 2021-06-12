class Board
  attr_accessor :cups #=> gives read and write abilities to this instance variable

  def initialize(name1, name2) #=> establishes a new instance of BOARD
    @name1 = name1 #=> sets player1 
    @name2 = name2 #=> sets player2
    @cups = Array.new(14) { Array.new } #=> creates 14 empty cups, each cup is an empty array
    place_stones #=> helper method to place 4 stones in all the starting cups
  end

  def place_stones #=> helper method to initialize to place starting stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, i| #=> loops through each cup, and the index
      next if i == 6 || i == 13 #=> if its cup 6 or 13 skip because those are the points cups
      4.times do #=> put a :stone in a cup 4 times
        cup << :stone #=> shuvel in a :stone into a cup
      end
    end
  end

  def valid_move?(start_pos) #=> check to make sure the starting move is value
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 12 #=> start_pos needs to be between inddicies 0 - 12 Not using 13 because its a points cup
    raise "Starting cup is empty" if @cups[start_pos].empty? #=> also the cup cannot be empty!
  end

  def make_move(start_pos, current_player_name) #=> method for makeing a move 
    stones = @cups[start_pos] #=> picks up the stones in the start cup
    @cups[start_pos] = [] #=> sets starting cup to emppty

    cup_idx = start_pos #=> variable to track the moves around the board will increment as stones are placed
    until stones.empty? #=> until we dont have any more stones in our hand
      cup_idx += 1 #=> move the next cup
      
      cup_idx = 0 if cup_idx > 13 #=> if cup_index is larger then greater then 13 reset cup index 0 this way it keeps going about the board indicies 0 - 13

      if cup_idx == 6 #=> if cup_idx is at 6 and the current player is player1 put a stone in the points cup
        @cups[6] << stones.pop if current_player_name == @name1
      elsif cup_idx == 13 #=> if cup_idx is 13 and the current player is player2 put a stone in the points cup
        @cups[13] << stones.pop if current_player_name == @name2
      else
        @cups[cup_idx] << stones.pop #=> otherwise pop a stone in the the cup
      end
    end

    render #=> rend the board
    next_turn(cup_idx) #=> pass the ending cup_idx to next turn
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 || ending_cup_idx == 13 #=> ending cup is points cup return :prompt go again
      :prompt
    elsif @cups[ending_cup_idx].count == 1 #=> swtich turns because player landed on an empty cup
      :switch
    else
      ending_cup_idx #=> if not ending on points cup or empty cup this returns a new starting cup
    end  
  end

  def render #=> renders the board 
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty? #=> checks to see if any of the sides are empty
    @cups.take(6).all? { |cup| cup.empty? } ||
    @cups[7..12].all? { |cup| cup.empty? }
  end

  def winner #=> determining winner
    player1_count = @cups[6].count #=> takes a count of player1 points cup
    player2_count = @cups[13].count #=> takes a count of player2 points cup 

    if player1_count == player2_count #=> if player1 count equals player2 counts return :draw
      :draw
    else
      player1_count > player2_count ? @name1 : @name2 #=> returns a winner passed on the count of the points cup
    end
  end
end
