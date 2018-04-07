package NOC.Route

import Chisel._

abstract class Lut() extends Module(){
   val io = IO(new Bundle{
		val dst_addr = Input(UInt(width = 4))
		val route_out = Output(UInt(width = 10))
   })
}
