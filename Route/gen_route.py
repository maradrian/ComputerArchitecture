


ids = [0, 1, 2, 3, 4, 5, 6, 7, 8]

x_row1 = [0, 1, 2]
x_row2 = [3, 4, 5]
x_row3 = [6, 7, 8]

y_col1 = [0, 3, 6]
y_col2 = [1, 4, 7]
y_col3 = [2, 5, 8]

x_axis = '10'
y_axis = '01'
local = '11'
package = 'package NOC.Route\n'

def get_next(currRout, row): #returns the next node in the specified row/column
	i = 0
	next_id = currRout
	for ident in row:
		if ident == currRout:
			if i < len(row) - 1:
				next_id = row[i+1]
				return next_id
			else:
				next_id = row[0]
				return next_id
		i+=1


#returns the route in string format e.g. '1010001011'
def get_route(src, dest, ids, x_row1, x_row2, x_row3, y_col1, y_col2, y_col3): 
	route = ''
	currentRout = src
	while currentRout != dest:
		if currentRout in x_row1 and dest in x_row1:
			route += x_axis
			currentRout = get_next(currentRout, x_row1)
		elif currentRout in x_row2 and dest in x_row2:
			route += x_axis
			currentRout = get_next(currentRout, x_row2)
		elif currentRout in x_row3 and dest in x_row3:
			route += x_axis
			currentRout = get_next(currentRout, x_row3)
		elif currentRout in y_col1 and dest in y_col1:
			route += y_axis
			currentRout = get_next(currentRout, y_col1)
		elif currentRout in y_col2 and dest in y_col2:
			route += y_axis
			currentRout = get_next(currentRout, y_col2)
		elif currentRout in y_col3 and dest in y_col3:
			route += y_axis
			currentRout = get_next(currentRout, y_col3)
		else:
			route += x_axis
			if currentRout in x_row1:
				currentRout = get_next(currentRout, x_row1)
			elif currentRout in x_row2:
				currentRout = get_next(currentRout, x_row2)
			else:
				currentRout = get_next(currentRout, x_row3)
	route += '11'
	while len(route) < 10:
		route += '0'
	return route


def generate_luts(ids, row1, row2, row3, col1, col2, col3):
	i = 0
	for lut in ids:
		file = open('LUT_' + str(lut) + '.scala', 'w+')
		file.write(package)
		file.write('\nimport Chisel._\n')
		file.write('\nclass LUT_' + str(lut) + '() extends Module(){\n')
		file.write('\tval io = IO(new Bundle{\n')
		file.write('\t\tval dst_addr = Input(UInt(width = 4))\n')
		file.write('\t\tval route_out = Output(UInt(width = 10))\n\t})\n\n')
		file.write('\twhen(io.dst_addr === UInt(0)){\n')
		if(lut == 0):
			route = '0000000000'
		else:
			route = get_route(lut, 0, ids, row1, row2, row3, col1, col2, col3)
		file.write('\t\tio.route_out := UInt(\"b'+route+'\")\n')
		file.write('\t}')
		for dest in ids:
			if dest == 0 or dest == lut:
				continue
			file.write('.elsewhen(io.dst_addr === UInt(' + str(dest) + ')){\n')
			file.write('\t\tio.route_out := UInt(\"b'+get_route(lut, dest, ids, row1, row2, row3, col1, col2, col3)+'\")\n')
			file.write('\t}')
		
                file.write('.otherwise{\n')
		file.write('\t\tio.route_out := UInt(\"b0000000000\")\n')
		file.write('\t}')
		file.write('\n}')
generate_luts(ids, x_row1, x_row2, x_row3, y_col1, y_col2, y_col3)
