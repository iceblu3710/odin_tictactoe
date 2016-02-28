class TicTacToe
  attr_accessor :gameboard
  attr_accessor :player1
  attr_accessor :player2

  @@winning_scores = [7,56,448,73,146,292,84,273]

  @@score_hsh = {0 => 1, 1 => 2, 2 => 4,
         3 => 8, 4 => 16, 5 => 32,
         6 => 64, 7 => 128, 8 => 256,}

  def initialize(player1_char, player2_char)
    @player1 = [player1_char, 0]
    @player2 = [player2_char, 0]
    @gameboard = []
    9.times { @gameboard << " " }
  end

  def update_score
    player1[1] = calculate_score(player1[0])
    puts "Chicken dinner #{player1[0]}!" if winner?(player1)
    player2[1] = calculate_score(player2[0])
    puts "Chicken dinner #{player2[0]}!" if winner?(player2)
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
    puts "#{@gameboard[0]}|#{@gameboard[1]}|#{@gameboard[2]}"
    puts "------"
    puts "#{@gameboard[3]}|#{@gameboard[4]}|#{@gameboard[5]}"
    puts "------"
    puts "#{@gameboard[6]}|#{@gameboard[7]}|#{@gameboard[8]}"
    puts " "
    puts "Player 1: #{player1[0]}, Player 2: #{player2[0]}"
  end
end

game = TicTacToe.new("X","O")
game.display_board
