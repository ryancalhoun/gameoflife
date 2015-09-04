module GameOfLife
	class Iteration
		def initialize(board)
			@board = board
		end
		def update!
			@board.rows.times {|i|
				@board.cols.times {|j|
					# ...
				}
			}
		end

		def count_neighbors(i, j)
			count = 0
			range = lambda {|x,n| [x-1,0].max..[x+1,n-1].min}
			range[i,@board.rows].each {|ii|
				range[j,@board.cols].each {|jj|
					next if i == ii and j == jj
					count += 1 if @board[ii][jj]
				}
			}
			count	
		end
	end
end
