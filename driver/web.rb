require 'gameoflife'
require 'socket'

s = TCPServer.new('*', 8080)
while(conn = s.accept)
	Thread.new(conn) {|conn|
		board = nil
		rules = nil
		loop {
			req = conn.gets
			m = /(\w+)\s+(([\w\-\.\/]*)\??(.*))\s+HTTP\/1\.1/.match(req)
			unless m
				conn.close
				break
			end

			method, url, path, query = m[1], m[2], m[3], m[4]
			params = Hash[query.scan(/(\w+)(?:=(\w*))?&?/).map {|k,v| [k.downcase.to_sym,v.to_s]}] if query
			line = conn.gets until line == "\r\n"

			if path == '/update'
				if board && board.rows == params[:rows].to_i && board.cols == params[:cols].to_i
					rules.update!
				else
					board = GameOfLife::Board.new params[:rows].to_i, params[:cols].to_i
					board.randomize!
					rules = GameOfLife::Rules.new board
				end	
				response = board.to_json
				conn.write "HTTP/1.1 200 OK\r\nContent-Length:#{response.size}\r\n\r\n#{response}"
			else
				file = File.join(File.dirname(__FILE__), 'web', path)
				file = File.join(file, 'index.html') if File.directory?file

				puts file

				if File.file?file
					response = File.open(file, 'r') {|f| f.read}
					conn.write "HTTP/1.1 200 OK\r\nContent-Length:#{response.size}\r\n\r\n#{response}"
				else
					conn.write "HTTP/1.1 404 Not Found\r\n\r\n"
				end
			end
		}
	}
end