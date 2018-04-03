package NOC.Route

import Chisel._

class LUT_3() extends Module(){
	val io = IO(new Bundle{
		val dst_addr = Input(UInt(width = 4))
		val route_out = Output(UInt(width = 10))
	})

	when(io.dst_addr === UInt(0)){
		io.route_out := UInt(b"0101110000")
	}.elsewhen(io.dst_addr === UInt(1)){
		io.route_out := UInt(b"1001011100")
	}.elsewhen(io.dst_addr === UInt(2)){
		io.route_out := UInt(b"1010010111")
	}.elsewhen(io.dst_addr === UInt(4)){
		io.route_out := UInt(b"1011000000")
	}.elsewhen(io.dst_addr === UInt(5)){
		io.route_out := UInt(b"1010110000")
	}.elsewhen(io.dst_addr === UInt(6)){
		io.route_out := UInt(b"0111000000")
	}.elsewhen(io.dst_addr === UInt(7)){
		io.route_out := UInt(b"1001110000")
	}.elsewhen(io.dst_addr === UInt(8)){
		io.route_out := UInt(b"1010011100")
	}
}