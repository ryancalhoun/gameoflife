require 'gameoflife/board'
require 'test/unit'

class TestBoard < Test::Unit::TestCase
	def setup
		@board = GameOfLife::Board.new 3, 3 
	end
	def testGetAndSet
		@board[1][2] = true
		assert @board[1][2]

		@board[1][2] = false
		assert ! @board[1][2]
	end
	def testBounds
		assert_raises(IndexError) {
			@board[42][2]
		}
		assert_raises(IndexError) {
			@board[2][99]
		}
		assert_raises(IndexError) {
			@board[2][99] = true
		}
	end
	def testToJson
		@board[1][2] = true
		assert_equal "{\"board\":[[false,false,false],[false,false,true],[false,false,false]]}", @board.to_json
	end
end
