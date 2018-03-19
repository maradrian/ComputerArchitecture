package NOC

import Chisel._

class Memory() extends Module(){
  val io = IO(new Bundle{
	val addr = Input(UInt(16.W))
	val dataIn = Input(UInt(32.W))
	val dataOut = Output(UInt(32.W))
	val enable = Input(Bool())
     })
  
  val mem = SyncReadMem(65536, UInt(32.W))
  mem.write(addr, dataIn)
  dataOut := mem.read(addr, enable)
}

class MemoryTest(dut: Memory) extends Tester(dut){
  //first write some data
  poke(dut.io.enable, false.B)
  poke(dut.io.dataIn, "h_dead_beef".asUInt(32.W))
  poke(dut.io.addr, "h_000f".asUInt(16.W))
  step(1)
  poke(dut.io.enable, false.B)
  poke(dut.io.dataIn, "h_0000_123a".asUInt(32.W))
  poke(dut.io.addr, "h_0003".asUInt(16.W))
  step(1)
  poke(dut.io.enable, false.B)
  poke(dut.io.dataIn, "h_2000_2000".asUInt(32.W))
  poke(dut.io.addr, "h_fffe".asUInt(16.W))
  step(1)
  
  //now let`s read them
  poke(dut.io.enable, true.B)
  poke(dut.io.addr, "h_000f".asUInt(16.W))
  step(1)
  poke(dut.io.enable, true.B)
  poke(dut.io.addr, "h_0003".asUInt(16.W))
  step(1)
  poke(dut.io.enable, true.B)
  poke(dut.io.addr, "h_fffe".asUInt(16.W))
}

object MemoryTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new Memory())) {
        m => new MemoryTester(m)
      }
  }
}
