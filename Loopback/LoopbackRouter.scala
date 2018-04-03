package NOC.Loopback


import Chisel._

class Loopback() extends Module(){
  val io = new Bundle{
     //TX - Router interface
     val TXReadyFromRouter = Output(Bool())
     val TXValidToRouter = Input(Bool())
     val packetIn = Input(UInt(width = 96))
     //RX - router interface
     val ready = Input(Bool())
     val packetOut = Output(UInt(width = 96))
     val valid = Output(Bool())
  }

  val waitForData :: wr :: wrAddr :: fromNIC :: Nil = Enum(UInt(), 4)//states cannot start with capital letters
  
  io.TXReadyFromRouter := Bool(true)
  io.valid := Bool(false)
  io.packetOut := UInt(0)
  val stateReg = Reg(init = waitForData)
  val dataReg = Reg(init = io.packetIn)
  val reg1 = Reg(UInt(0x0, 32))   

  when(stateReg === waitForData){
     when(io.TXValidToRouter === Bool(true)){
        io.TXReadyFromRouter := Bool(false)
	stateReg := wr
        dataReg := io.packetIn
	reg1 := io.packetIn(63, 32)
     }
  }
  when(stateReg === wr){
     io.TXReadyFromRouter := Bool(false)
     io.valid := Bool(true)
     io.packetOut := dataReg
     when(io.ready === Bool(true)){
	stateReg := wrAddr
	dataReg(95, 64):= UInt(0x0)
        dataReg(63, 32) := UInt(0x0000fffe)
        dataReg(31, 0) := reg1
     }
  }
  when(stateReg === wrAddr){
     io.TXReadyFromRouter := Bool(false)
     io.valid := Bool(true)
     io.packetOut := dataReg
     when(io.ready === Bool(true)){
	stateReg := waitForData
     }
  }
}

class LoopBackTest(dut: Loopback) extends Tester(dut){
   poke(dut.io.TXValidToRouter, 1)
   poke(dut.io.packetIn, 0xdeadbeef)
   //poke(dut.io.packetIn UInt(0xe8005354))
   poke(dut.io.ready, false)
   step(1)
   peek(dut.io.TXReadyFromRouter)
   peek(dut.io.packetOut)
   peek(dut.io.valid)
   poke(dut.io.ready, false)
   step(1)
   peek(dut.io.TXReadyFromRouter)
   peek(dut.io.packetOut)
   peek(dut.io.valid)
   poke(dut.io.ready, false)
   step(1)
   peek(dut.io.TXReadyFromRouter)
   peek(dut.io.packetOut)
   peek(dut.io.valid)
   poke(dut.io.ready,  true)
   step(1)
   peek(dut.io.TXReadyFromRouter)
   peek(dut.io.packetOut)
   peek(dut.io.valid)
   poke(dut.io.ready, false)
   step(1)
   peek(dut.io.TXReadyFromRouter)
   peek(dut.io.packetOut)
   peek(dut.io.valid)
   poke(dut.io.ready, true)
   step(1)
   peek(dut.io.TXReadyFromRouter)
   peek(dut.io.packetOut)
   peek(dut.io.valid)
   poke(dut.io.ready, true)
   step(1)
   peek(dut.io.TXReadyFromRouter)
   peek(dut.io.packetOut)
   peek(dut.io.valid)
   poke(dut.io.ready, true)
   step(1)
   step(1)
}

object LoopbackTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new Loopback())) {
        m => new LoopBackTest(m)
      }
  }
}
