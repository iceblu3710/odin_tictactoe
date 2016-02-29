class TicTacToe
  attr_accessor :gameboard

  @@winning_scores = [7,56,448,73,146,292,84,273]

  @@score_hsh = {0 => 1, 1 => 2, 2 => 4,
         3 => 8, 4 => 16, 5 => 32,
         6 => 64, 7 => 128, 8 => 256,}

  def initialize(player1_char, player2_char)
    turn1 = rand(2)
    turn2 = 1 unless turn1 == 1
    @player1 = [player1_char, 0, turn1]
    @player2 = [player2_char, 0, turn2]
    @gameboard = []
    9.times { @gameboard << " " }
    display_board()
    greet_player()
  end

  def update_score
    @player1[1] = calculate_score(@player1[0])
    @player2[1] = calculate_score(@player2[0])
    congrats(@player1) if winner?(@player1)
    congrats(@player2) if winner?(@player2)
  end

  def congrats(player)
    display_board()
    puts "\n\n\t CONGRAGULATIONS PLAYER #{player[0]}, YOU WON!\n\n"
    exit()
  end

  def calculate_score(player_char)
    score = 0
    @gameboard.each_with_index do |char, i|
      score += @@score_hsh[i] if char == player_char
    end
    score
  end

  def winner?(player)
    @@winning_scores.each do |score|
      return true if player[1] & score == score
    end
    false
  end

  def display_board
    puts "\n\n\t TicTacToe \n\n"
    puts "  1|2|3 \t #{@gameboard[0]}|#{@gameboard[1]}|#{@gameboard[2]}"
    puts "  ------ \t ------"
    puts "  4|5|6 \t #{@gameboard[3]}|#{@gameboard[4]}|#{@gameboard[5]}"
    puts "  ------ \t ------"
    puts "  7|8|9 \t #{@gameboard[6]}|#{@gameboard[7]}|#{@gameboard[8]}"
    puts "\n"
  end

  def greet_player
    player = get_player()
    puts "\t#{player[0]}'s turn!"
  end

  def next_turn
    @player1[2],@player2[2] = @player2[2],@player1[2]
  end

  def go(spot)
    player = get_player()
    if fill_spot?(spot, player[0])
      update_score()
      next_turn()
      display_board()
      greet_player()
    end
  end

  def fill_spot?(spot, mark)
    if @gameboard[spot-1] == " " then
      @gameboard[spot-1] = mark
      return true
    else
      spot_taken()
      display_board()
      greet_player()
      return false
    end
  end

  def spot_taken
    puts "\n\n\t That spot is already taken!"
  end

  def get_player
    return @player1 if @player1[2] == 1
    return @player2 if @player2[2] == 1
    raise NoPlayerFound "Neither player's turn is set!"
  end
end

game = TicTacToe.new("X","O")

loop do
  print "Choose: "
  choice = gets.chomp.to_i
  game.go(choice)
end
