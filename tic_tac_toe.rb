# frozen_string_literal: true

WINNING_COMPS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze

# Player
class Player
  def initialize(name, sign)
    @position = []
    @name = name
    @sign = sign.to_s
  end

  def play(board)
    puts 'Choose a position (1 to 9) to place your sign'
    index = gets.chomp.to_i
    @position.push[index - 1]
    board.update(index - 1, @sign)
  end

  def win?
    WINNING_COMPS.any? { |comp| comp == @position }
  end
end

# Representing the play board with an array, each element is a title on the board
class Board
  def initialize
    @current_state = Array.new(9)
    @current_state = @current_state.each_index.map { |index| index + 1 }
  end

  def game_ended?
    @current_state.none?(Integer)
  end

  def update(index, sign)
    @current_state[index] = sign
  end

  def display
    @current_state.each_with_index do |value, index|
      display_position = index + 1
      if display_position % 3 != 0
        print " #{value} |"
      else
        print " #{value} \n"
      end
    end
  end
end

def play_round(player1, player2, board, turn)
  turn.odd? ? player1.play(board) : player2.play(board)
end

def play_game(player1, player2, board)
  turn = 1
  while !board.game_ended? && !(player1.win? || player2.win?)
    board.display
    play_round(player1, player2, board, turn)
    turn += 1
  end
end

board = Board.new
puts "Enter player1' name: "
name = gets.chomp
p1 = Player.new(name, 'x')
p p1
puts "Enter player2's name"
name = gets.chomp
p2 = Player.new(name, 'o')
p p2
play_game(p1, p2, board)
