require 'gameoflife/board'
require 'test/unit'

class TestBoard < Test::Unit::TestCase
	def setup
		@board = GameOfLife::Board.new 10, 20
	end
	def testGetAndSet
		@board[4][11] = true
		assert @board[4][11]

		@board[4][11] = false
		assert ! @board[4][11]
	end
	def testBounds
		assert_raises(IndexError) {
			@board[42][3]
		}
		assert_raises(IndexError) {
			@board[4][99]
		}
		assert_raises(IndexError) {
			@board[4][99] = true
		}
	end
end
