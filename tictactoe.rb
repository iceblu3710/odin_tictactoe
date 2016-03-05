class TicTacToe
  attr_accessor :gameboard

  WINNING_SCORES = [7,56,448,73,146,292,84,273]

  SCORE_HASH = {0 => 1, 1 => 2, 2 => 4,
         3 => 8, 4 => 16, 5 => 32,
         6 => 64, 7 => 128, 8 => 256}

  class Player
    attr_reader   :mark
    attr_accessor :score
    attr_accessor :turn

    def initialize(player_mark)
      @mark = player_mark
      @score = 0
      @turn = 0
    end
  end

  def initialize(player1_char, player2_char)
    @player1 = Player.new(player1_char)
    @player2 = Player.new(player2_char)
    set_turn()
    @gameboard = []
    9.times { @gameboard << " " }
    display_board()
    greet_player()
  end

  def set_turn()
    @player1.turn = rand(2)
    @player2.turn = 1 unless @player1.turn == 1
  end

  def update_score
    @player1.score = calculate_score(@player1.mark)
    @player2.score = calculate_score(@player2.mark)
    congrats(@player1.mark) if winner?(@player1.score)
    congrats(@player2.mark) if winner?(@player2.score)
  end

  def congrats(player)
    display_board()
    puts "\n\n\t CONGRAGULATIONS PLAYER #{player}, YOU WON!\n\n"
    exit()
  end

  def calculate_score(mark)
    score = 0
    @gameboard.each_with_index do |char, i|
      score += SCORE_HASH[i] if char == mark
    end
    score
  end

  def winner?(player_score)
    WINNING_SCORES.each do |score|
      return true if player_score & score == score
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
    player_mark = get_player()
    puts "\t#{player_mark}'s turn!"
  end

  def next_turn
    @player1.turn, @player2.turn = @player2.turn, @player1.turn
  end

  def go(spot)
    player_mark = get_player()
    if fill_spot?(spot, player_mark)
      update_score()
      next_turn()
      display_board()
      greet_player()
    end
  end

  def fill_spot?(spot, player_mark)
    if @gameboard[spot-1] == " " then
      @gameboard[spot-1] = player_mark
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
    return @player1.mark if @player1.turn == 1
    return @player2.mark if @player2.turn == 1
    raise NoPlayerFound "Neither player's turn is set!"
  end
end

game = TicTacToe.new("X","O")

loop do
  print "Choose: "
  choice = gets.chomp.to_i
  game.go(choice)
end
