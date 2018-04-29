package NOC.Memory

import Chisel._

/*
 * Patmos - Read/Write
 * RX - Write
 */
class Memory() extends Module{
  val io = IO(new Bundle{
  //val addr = Input(UInt(width = 16)) //DONT USE!!!
  val dataIn = Input(UInt(width = 32))
  //val dataOut = Output(UInt(width = 32)) //DONT USE!!!
  val enable = Input(Bool())
  val addr2 = Input(UInt(width = 16))
  //val dataIn2 = Input(UInt(width = 32)) //DONT USE!!!
  val dataOut2 = Output(UInt(width = 32))  
  //val enable2 = Input(Bool()) //DONT USE!!!
 })   
   val syncMem = Mem(UInt(width=32), 1024, seqRead=true)
   
   when(io.enable === Bool(true) ) {
      syncMem(io.addr2) := io.dataIn
    }/*
    when(io.enable2 === Bool(true)){
      syncMem(io.addr2) := io.dataIn2
    }*/

  // read
  //val rdAddrReg  = Reg(next = io.addr)
  val rdAddrReg2 = Reg(next = io.addr2)
  //io.dataOut  := syncMem(rdAddrReg)
  io.dataOut2 := syncMem(rdAddrReg2)
}

class MemoryTest(dut: Memory) extends Tester(dut){
  //first write some data
  poke(dut.io.enable, true)
  poke(dut.io.dataIn, 0xdeadbeef)
  poke(dut.io.addr2, 0x000f)
  step(1)
  poke(dut.io.enable, true)
  poke(dut.io.dataIn, 0x0000123a)
  poke(dut.io.addr2, 0x0003)
  step(1)
  poke(dut.io.enable, true)
  poke(dut.io.dataIn, 0x20002000)
  poke(dut.io.addr2, 0xfffe)
  step(1)

  //now let`s read them
  poke(dut.io.enable, false)
  poke(dut.io.addr2, 0x000f)
  peek(dut.io.dataOut2)
  step(1)
  poke(dut.io.enable, false)
  poke(dut.io.addr2, 0x0003)
  peek(dut.io.dataOut2)
  step(1)
  poke(dut.io.enable, false)
  poke(dut.io.addr2, 0xfffe)
  peek(dut.io.dataOut2)
  step(1)
  peek(dut.io.dataOut2)
  step(1)
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
