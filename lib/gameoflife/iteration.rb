module GameOfLife
	class Iteration
		def initialize(board)
			@board = board
		end
		def update!
			updates = {}
			@board.rows.times {|i|
				@board.cols.times {|j|
					n = count_neighbors i, j

					if @board[i][j]
						(updates[i]||= {})[j] = false if n < 2 || n > 3
					else
						(updates[i]||= {})[j] = true if n == 3
					end
				}
			}
			updates.each {|i,col|
				col.each {|j,val|
					@board[i][j] = val
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
