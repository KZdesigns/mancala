require_relative 'board' #=> gives access to the board class
require_relative 'player' #=> gives access to the player class

class Mancala
  def initialize(name1, name2) #=> creates a new mancala object requires to names passed in
    @player1 = Player.new(name1, 1) #=> sets player1 to the name1 passed in and sets the players side
    @player2 = Player.new(name2, 2) #=> sets player2 to the name2 passed in and sets the players side
    @board = Board.new(name1, name2) #=> creates the board and passes the two players to the board
  end

  def play #=> play method
    puts "Welcome to Mancala" #=> out puts message to player
    @board.render #=> displays the board instance variable
    current_player = @player1 #=> sets the current_player to the @player1
    until won? #=> starts looping through play until the game is won?
      take_turn(current_player) #=> pass the current_player to the take_turn method
      current_player = current_player == @player1 ? @player2 : @player1 #=> switches the current player at the end of each itteration
    end

    puts "The game is finished! #{winner_message}" #=> once the game is won the prints the winners
  end

  def take_turn(current_player) #=> method describes taking a turn
    move_result = :prompt #=> sets move results to :prompt

    until move_result == :switch #=> starts loop
      if move_result == :prompt #=> if move_results still equals :prompt
        print_indices #=> print_indices

        begin
          start_pos = current_player.prompt #=> set the start_pos equal to current_plyaer#prompt from player.rb
          start_pos -= 1 if start_pos <= 6 #=> if start_pos is less then or equal to 6 then subtract 1 from the start_pos
          @board.valid_move?(start_pos) #=> check to make sure the start_pos is valid move for the board
        rescue Exception => e
          puts e.message #=> exception handling the error
        retry #=> and retring the loop 
        end
        move_result = @board.make_move(start_pos, current_player.name) #=> set move_results to the return value of board#make_move going on a streak
      else
        move_result = @board.make_move(move_result, current_player.name) #=> moves move_results to :swtich and eventually ends the turn and loop
      end
      break if won? #=> stop the loop if the turn ends the game and a player has won
    end
  end

  def won?
     @board.one_side_empty? #=> if one side is empty game is over
  end

  def winner_message 
    winner = @board.winner #=> set winner board.winner if winner is :draw 
    if winner == :draw
      "It was a draw!" #=> prints this message
    else
      "Congrats, #{winner}!" #=> if winner does not equal :draw pring the winner
    end
  end

  def print_indices #=> prints the board indices
    puts "\nCup indices:"
    puts "12  11  10   9   8   7"
    puts " 1   2   3   4   5   6"
  end
end

if __FILE__ == $PROGRAM_NAME #=> allow you play game in console
  Mancala.new("Kyle", "Lauriane").play
end
