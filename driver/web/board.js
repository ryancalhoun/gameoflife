var board = function() {
	var rows = Math.floor($(window).height() / 10);
	var cols = Math.floor($(window).width() / 10);

	$('#rows').html(rows);
	$('#cols').html(cols);

	var table = $('#board');
	var data = [];

	var it = $('#iteration');

	for(var i = 0; i < rows; ++i)
	{
		var table_row = $("<tr></tr>");
		var data_row = [];
		table.append(table_row);
		data.push(data_row);
		for(var j = 0; j < cols; ++j)
		{
			var table_cell = $("<div class=\"cell dead\"></div>");
			var table_col = $("<td></td>");
			table_col.append(table_cell);
			table_row.append(table_col);
			data_row.push(table_cell);
		}
	}

	var draw = function(b) {
		it.html(b.iteration);
		for(var i = 0; i < b.board.length; ++i)
		{
			var board_row = b.board[i];
			var data_row = data[i];
			for(var j = 0; j < board_row.length; ++j)
			{
				if(board_row[j])
					data_row[j].removeClass("dead").addClass("alive");
				else
					data_row[j].removeClass("alive").addClass("dead");
			}
		}

		setTimeout(update, 500);
	};

	var update = function() {
		$.ajax({
			url : "/update?rows=" + rows + "&cols=" + cols,
			dataType : 'json'
		}).done(draw);
	};

	update();
}();

