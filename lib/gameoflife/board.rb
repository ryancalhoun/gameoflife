require 'json'
module GameOfLife
	class Board
		attr_reader :rows, :cols
		def initialize(rows, cols)
			@rows, @cols = rows, cols
			@board = Array.new(rows) { Row.new cols }
		end
		def randomize!(p = 0.2)
			@rows.times {|i|
				@cols.times {|j|
					@board[i][j] = rand < p
				}
			}
		end
		def [](i)
			GameOfLife.check_bounds i, @rows
			@board[i]
		end
		def each_row
			@board.each {|row|
				yield row
			}
		end
		def to_json
			JSON.generate :board => @board.map {|row| row.to_a }
		end

		class Row
			def initialize(cols)
				@row = Array.new(cols) { false }
			end
			def [](j)
				GameOfLife.check_bounds j, @row.size
				@row[j]
			end
			def []=(j,val)
				GameOfLife.check_bounds j, @row.size
				@row[j] = val
			end
			def each_column
				@row.each {|col|
					yield col
				}
			end
			def to_a
				@row
			end
		end
	end
	def self.check_bounds(i,n)
		raise IndexError.new "index #{i} out of bounds" unless (0..n-1).include?i
	end
end
