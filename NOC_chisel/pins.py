
#			/************ ROUTER 0 *************/
#			//INPUT
#			val local_packet_in_0 = BITS(OUTPUT, width = packet_width)
#			val local_valid_in_0 = BITS(OUTPUT, width = 1)
#			val local_ready_out_0 = BITS(INPUT, width = 1)
#			//OUTPUT
#			val local_packet_out_0 = BITS(INPUT, width = packet_width)
#			val local_valid_out_0 = BITS(INPUT, width = 1)
#			val local_ready_in_0 = BITS(OUTPUT, width = 1)




ids = [0, 1, 2, 3, 4, 5, 6, 7, 8]

def get_noc_pins(ids):
	pins = ''
	for ident in ids:
		pins += '/************ ROUTER ' + str(ident) + ' *************/\n//INPUT\n'
		pins += 'val local_packet_in_' + str(ident) + ' = BITS(OUTPUT, width = packet_width)\n'
		pins += 'val local_valid_in_' + str(ident) + ' = BITS(OUTPUT, width = 1)\n'
		pins += 'val local_ready_out_' + str(ident) + ' = BITS(INPUT, width = 1)\n//OUTPUT\n'
		#OUTPUT
		pins += 'val local_packet_out_' + str(ident) + ' = BITS(INPUT, width = packet_width)\n'
		pins += 'val local_valid_out_' + str(ident) + ' = BITS(INPUT, width = 1)\n'
		pins += 'val local_ready_in_' + str(ident) + ' = BITS(OUTPUT, width = 1)\n'
	return pins

def get_noc_portmap(ids):
	pins = ''
	for ident in ids:
		pins += '/************ ROUTER ' + str(ident) + ' *************/\n//INPUT\n'
		pins += 'io.local_packet_in_' + str(ident) + '.setName("local_packet_in_' + str(ident) + '")\n'
		pins += 'io.local_valid_in_' + str(ident) + '.setName("local_valid_in_' + str(ident) + '")\n'
		pins += 'io.local_ready_out_' + str(ident) + '.setName("local_ready_out_' + str(ident) + '")\n//OUTPUT\n'
		#OUTPUT
		pins += 'io.local_packet_out_' + str(ident) + '.setName("local_packet_out_' + str(ident) + '")\n'
		pins += 'io.local_valid_out_' + str(ident) + '.setName("local_valid_out_' + str(ident) + '")\n'
		pins += 'io.local_ready_in_' + str(ident) + '.setName("local_ready_in_' + str(ident) + '")\n'
	return pins

def get_noc_portmap_loop(ids):
	pins = ''
	for ident in ids:
		pins += '/************ ROUTER ' + str(ident) + ' *************/\n//INPUT\n'
		pins += 'io.local_packet_in(' + str(ident) + ').setName("local_packet_in_' + str(ident) + '")\n'
		pins += 'io.local_valid_in_' + str(ident) + '.setName("local_valid_in_' + str(ident) + '")\n'
		pins += 'io.local_ready_out_' + str(ident) + '.setName("local_ready_out_' + str(ident) + '")\n//OUTPUT\n'
		#OUTPUT
		pins += 'io.local_packet_out_' + str(ident) + '.setName("local_packet_out_' + str(ident) + '")\n'
		pins += 'io.local_valid_out_' + str(ident) + '.setName("local_valid_out_' + str(ident) + '")\n'
		pins += 'io.local_ready_in_' + str(ident) + '.setName("local_ready_in_' + str(ident) + '")\n'
	return pins

print(get_noc_portmap(ids))
