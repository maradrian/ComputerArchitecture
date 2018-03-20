package NOC.Memory

import Chisel._

class Memory() extends Module(){
  val io = IO(new Bundle{
	val addr = Input(UInt(width = 16))
	val dataIn = Input(UInt(width = 32))
	val dataOut = Output(UInt(width = 32))
	val enable = Input(Bool())
     })
   val syncMem = Mem(UInt(width=32), 65536, seqRead=true)
   
    when(io.enable === Bool(true) ) {
      syncMem(io.addr) := io.dataIn

  }

  // read
  val rdAddrReg = Reg(next = io.addr)
  io.dataOut := syncMem(rdAddrReg)
}

class MemoryTest(dut: Memory) extends Tester(dut){
  //first write some data
  poke(dut.io.enable, true)
  poke(dut.io.dataIn, 0xdeadbeef)
  poke(dut.io.addr, 0x000f)
  step(1)
  poke(dut.io.enable, true)
  poke(dut.io.dataIn, 0x0000123a)
  poke(dut.io.addr, 0x0003)
  step(1)
  poke(dut.io.enable, true)
  poke(dut.io.dataIn, 0x20002000)
  poke(dut.io.addr, 0xfffe)
  step(1)
  
  //now let`s read them
  poke(dut.io.enable, false)
  poke(dut.io.addr, 0x000f)
  step(1)
  poke(dut.io.enable, false)
  poke(dut.io.addr, 0x0003)
  step(1)
  poke(dut.io.enable, false)
  poke(dut.io.addr, 0xfffe)
}

object MemoryTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new Memory())) {
        m => new MemoryTest(m)
      }
  }
}