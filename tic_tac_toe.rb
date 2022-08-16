# frozen_string_literal: true

WINNING_COMPS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze

# Player
class Player
  attr_reader :name

  def initialize(name, sign)
    @position = []
    @name = name
    @sign = sign.to_s
  end

  def play(board)
    puts "#{@name}'s turn, please choose a position (1 to 9) to place your sign"
    # get valid input from user
    index = nil
    loop do
      index = gets.chomp.to_i - 1
      break if index.between?(0, 8) && board.current_state[index].is_a?(Integer)

      puts 'Invalid input, please try again'
    end
    @position.push(index)
    board.update(index, @sign)
  end

  def win?
    WINNING_COMPS.each do |combo|
      return true if combo.all? { |i| @position.include?(i) }
    end
    false
  end
end

# Representing the play board with an array, each element is a title on the board
class Board
  attr_reader :current_state

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

def result_annoucement(player1, player2)
  if player1.win?
    puts "#{player1.name} wins!"
  elsif player2.win?
    puts "#{player2.name} wins!"
  else
    puts 'Draw!'
  end
end

def play_game(player1, player2, board)
  turn = 1
  until board.game_ended? || player1.win? || player2.win?
    board.display
    play_round(player1, player2, board, turn)
    turn += 1
  end
  board.display
  result_annoucement(player1, player2)
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
