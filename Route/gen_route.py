


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
eastP = 'east_packet_out'
southP = 'south_packet_out'
eastR = 'east_ready_in'
southR = 'south_ready_in'
mType = ': packet_m_type;'
sType = ': packet_s_type;\n'

def getFancyIndex(i):
	if i == 0:
		return '(0)(0)'
	elif i == 1:
		return '(0)(1)'
	elif i == 2:
		return '(0)(2)'
	elif i == 3:
		return '(1)(0)'
	elif i == 4:
		return '(1)(1)'
	elif i == 5:
		return '(1)(2)'
	elif i == 6:
		return '(2)(0)'
	elif i == 7:
		return '(2)(1)'
	elif i == 8:
		return '(2)(2)'

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

def get_north_in(i):
	if i in x_row1:
		return '_' + str(i+6)
	else:
		return '_' + str(i-3)

def get_west_in(i):
	if i in y_col1:
		return '_' + str(i+2)
	else:
		return '_' + str(i-1)



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

def generate_signals():
	i = 0
	while i < 9:
		print('signal ' + eastP + '_' + str(i) + ', ' + southP + '_' + str(i) + mType)
		print('signal ' + eastR + '_' + str(i) + ', ' + southR + '_' + str(i) + sType)
		i+=1

def gen_portmap():
	i = 0
	while i < 9:
		print('\trouter'+str(i)+': router PORT MAP(\n\tclk => clk, rst => reset,')
		print('\t\trouter_north_packet_in => ' + southP + get_north_in(i) + ',')
		print('\t\trouter_north_ready_out => ' + southR + get_north_in(i) + ',')
		print('\t\trouter_east_packet_out => ' + eastP + '_' + str(i) + ',')
		print('\t\trouter_east_ready_in => ' + eastR + '_' + str(i) + ',')
		print('\t\trouter_south_packet_out => ' + southP + '_' + str(i) + ',')
		print('\t\trouter_south_ready_in => ' + southR + '_' + str(i) + ',')
		print('\t\trouter_west_packet_in => ' + eastP + get_west_in(i) + ',')
		print('\t\trouter_west_ready_out => ' + eastR + get_west_in(i) + ',')
		print('\t\trouter_local_packet_in => local_packet_in' + getFancyIndex(i) + ',')
		print('\t\trouter_local_ready_out => local_ready_out' + getFancyIndex(i) + ',')
		print('\t\trouter_local_packet_out => local_packet_out' + getFancyIndex(i) + ',')
		print('\t\trouter_local_ready_in => local_ready_in' + getFancyIndex(i))
		print('\t);\n\n')

		i+=1

gen_portmap()
