require 'gameoflife/board'
require 'gameoflife/iteration'
require 'test/unit'

class TestIteration < Test::Unit::TestCase
	def testCountZeroNeighbors
		b = GameOfLife::Board.new 3, 3
=begin
		. . .
		. . .
        . . .
=end
		it = GameOfLife::Iteration.new b
		assert_equal 0, it.count_neighbors(1, 1)
	end
	def testCountRowNeighbors
		b = GameOfLife::Board.new 3, 3
		b[1][0] = true
		b[1][2] = true
=begin
		. . .
		x . x
        . . .
=end
		it = GameOfLife::Iteration.new b
		assert_equal 2, it.count_neighbors(1, 1)
	end
	def testCountColumnNeighbors
		b = GameOfLife::Board.new 3, 3
		b[0][1] = true
		b[2][1] = true
=begin
		. x .
		. . .
        . x .
=end
		it = GameOfLife::Iteration.new b
		assert_equal 2, it.count_neighbors(1, 1)
	end
	def testCountDiagonalNeighbors
		b = GameOfLife::Board.new 3, 3
		b[0][0] = true
		b[0][2] = true
		b[2][0] = true
		b[2][2] = true
=begin
		x . x
		. . .
        x . x
=end
		it = GameOfLife::Iteration.new b
		assert_equal 4, it.count_neighbors(1, 1)
	end
	def testUpdateZeroNeighbors
		b = GameOfLife::Board.new 3, 3
		b[1][1] = true
=begin
		. . .
		. x .
        . . .
=end
		it = GameOfLife::Iteration.new b
		it.update!
		assert ! b[1][1]
	end
	def testUpdateOneNeighbor
		b = GameOfLife::Board.new 3, 3
		b[0][1] = true
		b[1][1] = true
=begin
		. x .
		. x .
        . . .
=end
		it = GameOfLife::Iteration.new b
		it.update!
		assert ! b[1][1]
	end
	def testUpdateTwoNeighbors
		b = GameOfLife::Board.new 3, 3
		b[0][1] = true
		b[1][1] = true
		b[2][1] = true
=begin
		. x .
		. x .
        . x .
=end
		it = GameOfLife::Iteration.new b
		it.update!
		assert b[1][1]
	end
	def testUpdateFourNeighbors
		b = GameOfLife::Board.new 3, 3
		b[0][1] = true
		b[1][1] = true
		b[2][1] = true
		b[1][0] = true
		b[1][2] = true
=begin
		. x .
		x x x
        . x .
=end
		it = GameOfLife::Iteration.new b
		it.update!
		assert ! b[1][1]
	end
	def testUpdateDeadTwoNeighbors
		b = GameOfLife::Board.new 3, 3
		b[0][1] = true
		b[2][1] = true
=begin
		. x .
		. . .
        . x .
=end
		it = GameOfLife::Iteration.new b
		it.update!
		assert ! b[1][1]
	end
	def testUpdateDeadThreeNeighbors
		b = GameOfLife::Board.new 3, 3
		b[0][1] = true
		b[2][1] = true
		b[1][0] = true
=begin
		. x .
		x . .
        . x .
=end
		it = GameOfLife::Iteration.new b
		it.update!
		assert b[1][1]
	end
	def testUpdateDeadFourNeighbors
		b = GameOfLife::Board.new 3, 3
		b[0][1] = true
		b[2][1] = true
		b[1][0] = true
		b[1][2] = true
=begin
		. x .
		x . x
        . x .
=end
		it = GameOfLife::Iteration.new b
		it.update!
		assert ! b[1][1]
	end
end
