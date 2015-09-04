require 'gameoflife'
module Driver
	class Console
		def initialize
			h,w = `stty size`.chomp.split.map &:to_i
			@board = GameOfLife::Board.new h-1, w
			@board.randomize!
			@iteration = GameOfLife::Iteration.new @board
		end

		def show
			print "\033[H"
			@board.rows.times {|i|
				@board.cols.times {|j|
					print @board[i][j] ? "#" : " "
				}
				puts
			}
			print "Press Ctrl+C to stop..."
		end

		def run
			begin
				loop {
					show
					sleep 0.5
					@iteration.update!
				}
			rescue Interrupt
				print "\033[#{@board.rows};1H"
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
