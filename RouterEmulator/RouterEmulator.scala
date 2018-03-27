package NOC.RouterEmulator

import Chisel._

class RouterEmulator() extends Module(){
	val io = IO(new Bundle{
    val start = Input(Bool())
    val ready = Input(Bool())
    val packetOut = Output(UInt(width = 96))
    val valid = Output(Bool())
	})//true == write

  val countReg = Reg(init = UInt(0, 32))
  io.packetOut := UInt(0)
  io.valid := Bool(false)

  when(io.start === Bool(true)){
    countReg := countReg + UInt(1)
    io.packetOut(31, 0) := countReg
    io.packetOut(63, 32) := countReg
    io.valid := Bool(true)
  }

}