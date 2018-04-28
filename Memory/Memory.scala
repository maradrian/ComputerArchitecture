package NOC.Memory
 
import Chisel._
 
/*
 * Dual port memory
 * Port 1 is Read/Write
 * Port 2 is Read only
 */
class Memory() extends Module{
  val io = IO(new Bundle{
  val addr = Input(UInt(width = 16))
  val dataIn = Input(UInt(width = 32))
  val dataOut = Output(UInt(width = 32))
  val enable = Input(Bool())
  val addr2 = Input(UInt(width = 16))
  val dataIn2 = Input(UInt(width = 32))
  val dataOut2 = Output(UInt(width = 32))  
  val enable2 = Input(Bool())
 })   
   val syncMem = Mem(UInt(width=32), 8192, seqRead=true)
   
   when(io.enable === Bool(true) ) {
      syncMem(io.addr) := io.dataIn
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
  poke(dut.io.enable2, false)  
 
  //now let`s read them
commit:3dbd3c
Memory read update