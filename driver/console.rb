require 'gameoflife'
module Driver
	class Console
		def initialize
			h,w = `stty size`.chomp.split.map &:to_i
			@board = GameOfLife::Board.new h-1, w
			@board.randomize!
			@rules = GameOfLife::Rules.new @board
		end

		def show
			print "\033[H"
			@board.rows.times {|i|
				@board.cols.times {|j|
					print @board[i][j] ? "#" : " "
				}
				puts
			}
			print "Game Of Life [#{@board.rows}x#{@board.cols}] Iteration #{@rules.iteration}. Press Ctrl+C to stop..."
		end

		def run
			begin
				loop {
					show
					sleep 0.5
					@rules.update!
				}
			rescue Interrupt
				print "\033[#{@board.rows};1H"
				puts
				puts
			end
		end
	end
end

if $0 == __FILE__
	STDOUT.sync = true
	driver = Driver::Console.new
	driver.run
end
