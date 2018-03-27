package NOC.Memory

import Chisel._
import Node._
import patmos.Constants._
import io._
import ocp._


class OcpMemoryRead() extends Module {
  val io = new Bundle{
    val addr = Output(UInt(width = 16))
    val dataIn = Input(UInt(width = 32))
    val fromCore = new OcpCoreSlavePort(ADDR_WIDTH, DATA_WIDTH)
    val enable = Output(Bool())
    val dataOut = Output(UInt(width = 32))
  }
  
  val waitForCmd :: sendBackData :: writeData :: Nil = Enum(UInt(), 3)
  val stateReg = Reg(init = waitForCmd)
  val rdAddr = Reg(UInt(width = 16)) 
  val dataOutReg = Reg(UInt(width = 32)) 

  io.fromCore.S.Data := io.dataIn
  io.fromCore.S.Resp := OcpResp.NULL
  io.addr := rdAddr
  io.dataOut := dataOutReg
  io.enable := Bool(false)

  when (stateReg === waitForCmd){
     when(io.fromCore.M.Cmd === OcpCmd.RD){
        stateReg := sendBackData
	rdAddr := io.fromCore.M.Addr(15, 0)
	dataOutReg := io.fromCore.M.Data
     }
     when(io.fromCore.M.Cmd === OcpCmd.WR){
        stateReg := writeData
	rdAddr := io.fromCore.M.Addr(15, 0)
	dataOutReg := io.fromCore.M.Data
     }
  }
  when(stateReg === sendBackData){
     stateReg := waitForCmd
     io.fromCore.S.Resp := OcpResp.DVA
  }
  when(stateReg === writeData){
     stateReg := waitForCmd
     io.fromCore.S.Resp := OcpResp.DVA
     io.enable := Bool(true)
  }
}

class OcpMemoryReadTest(dut: OcpMemoryRead) extends Tester(dut){
  poke(dut.io.fromCore.M.Cmd, 0x1)
  poke(dut.io.fromCore.M.Addr, 0xe8000001)
  poke(dut.io.fromCore.M.Data, 0xdeadbeef)
  peek(dut.io.addr)
  peek(dut.io.fromCore.S.Resp)
  step(1)  
  poke(dut.io.fromCore.M.Cmd, 0x0)
  poke(dut.io.fromCore.M.Addr, 0x0)
  peek(dut.io.addr)
  peek(dut.io.fromCore.S.Resp)
  peek(dut.io.enable)
  peek(dut.io.dataOut)
  step(1)  
  poke(dut.io.fromCore.M.Cmd, 0x0)
  poke(dut.io.fromCore.M.Addr, 0x0)
  peek(dut.io.addr)
  peek(dut.io.fromCore.S.Resp)
  step(1)  
  poke(dut.io.fromCore.M.Cmd, 0x2)
  poke(dut.io.fromCore.M.Addr, 0xe8000001)
  peek(dut.io.addr)
  peek(dut.io.fromCore.S.Resp)
  step(1)
  poke(dut.io.fromCore.M.Cmd, 0x0)
  poke(dut.io.fromCore.M.Addr, 0x0)
  peek(dut.io.fromCore.S.Resp)
  peek(dut.io.addr)
  step(1)
  poke(dut.io.fromCore.M.Cmd, 0x2)
  poke(dut.io.fromCore.M.Addr, 0xe800000f)
  peek(dut.io.fromCore.S.Resp) 
  peek(dut.io.addr)
  step(1)
  poke(dut.io.fromCore.M.Cmd, 0x0)
  poke(dut.io.fromCore.M.Addr, 0x0)
  peek(dut.io.fromCore.S.Resp)
  peek(dut.io.addr)
  step(1)
  poke(dut.io.fromCore.M.Cmd, 0x0)
  poke(dut.io.fromCore.M.Addr, 0x0)
  peek(dut.io.fromCore.S.Resp)
  peek(dut.io.addr)
  step(1)    
  step(1) 
}

object OcpMemoryReadTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new OcpMemoryRead())) {
        m => new OcpMemoryReadTest(m)
      }
  }
}

class MemoryAndReadConnection() extends Module{
  val io = new Bundle{
    val fromCore = new OcpCoreSlavePort(ADDR_WIDTH, DATA_WIDTH)
    val addr = Input(UInt(width = 16))
    val dataIn = Input(UInt(width = 32))
    val dataOut = Output(UInt(width = 32))
    val enable = Input(Bool())
  }
  
  val ocpMemoryRead = Module(new OcpMemoryRead())
  val memory = Module(new Memory())
  
  memory.io.addr := io.addr
  memory.io.dataIn := io.dataIn
  io.dataOut := memory.io.dataOut
  memory.io.enable := io.enable
  memory.io.addr2 := ocpMemoryRead.io.addr
  ocpMemoryRead.io.dataIn := memory.io.dataOut2
  ocpMemoryRead.io.fromCore.M <> io.fromCore.M 
  ocpMemoryRead.io.fromCore.S <> io.fromCore.S
  memory.io.enable2 := ocpMemoryRead.io.enable
  memory.io.dataIn2 := ocpMemoryRead.io.dataOut
}

class MemoryAndReadConnectionTest(dut: MemoryAndReadConnection) extends Tester(dut){
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
  step(1)
  // now let`s issue commands from the Patmos
  poke(dut.io.fromCore.M.Cmd, 0x1)
  poke(dut.io.fromCore.M.Addr, 0xe80000ff)
  poke(dut.io.fromCore.M.Data, 0xdeadbeef)
  peek(dut.io.addr)
  peek(dut.io.fromCore.S.Resp)
  step(1)  
  poke(dut.io.fromCore.M.Cmd, 0x0)
  poke(dut.io.fromCore.M.Addr, 0x0)
  peek(dut.io.addr)
  peek(dut.io.fromCore.S.Resp)
  step(1)  
  poke(dut.io.fromCore.M.Cmd, 0x0)
  poke(dut.io.fromCore.M.Addr, 0x0)
  peek(dut.io.addr)
  peek(dut.io.fromCore.S.Resp)
  step(1)  
  poke(dut.io.fromCore.M.Cmd, 0x2)
  poke(dut.io.fromCore.M.Addr, 0xe80000ff)
  peek(dut.io.addr)
  peek(dut.io.fromCore.S.Resp)
  step(1)
  poke(dut.io.fromCore.M.Cmd, 0x0)
  poke(dut.io.fromCore.M.Addr, 0x0)
  peek(dut.io.fromCore.S.Resp)
  peek(dut.io.addr)
  peek(dut.io.fromCore.S.Data)
  step(1)
  poke(dut.io.fromCore.M.Cmd, 0x2)
  poke(dut.io.fromCore.M.Addr, 0xe800fffe)
  peek(dut.io.fromCore.S.Resp) 
  peek(dut.io.addr)
  peek(dut.io.fromCore.S.Data)
  step(1)
  poke(dut.io.fromCore.M.Cmd, 0x0)
  poke(dut.io.fromCore.M.Addr, 0x0)
  peek(dut.io.fromCore.S.Resp)
  peek(dut.io.addr)
  step(1)
  poke(dut.io.fromCore.M.Cmd, 0x0)
  poke(dut.io.fromCore.M.Addr, 0x0)
  peek(dut.io.fromCore.S.Resp)
  peek(dut.io.addr)
  peek(dut.io.fromCore.S.Data)
  step(1)    
  step(1)
}

object MemoryAndReadConnectionTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new MemoryAndReadConnection())) {
        m => new MemoryAndReadConnectionTest(m)
      }
  }
}
