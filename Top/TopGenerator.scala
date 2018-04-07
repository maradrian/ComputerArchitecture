package NOC.Top

import Chisel._
import Node._
import patmos.Constants._
import io._
import ocp._

class Ports() extends Bundle{
  val fromProcessor = new OcpCoreSlavePort(ADDR_WIDTH, DATA_WIDTH)
  val routerPacketIn = Output(UInt(width = 96))
  val routerValidIn = Output(Bool())
  val routerReadyOut = Input(Bool())
  val routerPacketOut = Input(UInt(width = 96))
  val routerValidOut = Input(Bool())
  val routerReadyIn = Output(Bool())   
}

class TopGenerator(nrCores: Int) extends Module(){
  val io = Vec(nrCores, new Ports())
  val tops = new Array[Top](nrCores)  

  for (i <- 0 until nrCores){
     tops(i) = Module(new Top(i))
     tops(i).io.fromProcessor.M <> io(i).fromProcessor.M 
     tops(i).io.fromProcessor.S <> io(i).fromProcessor.S
     tops(i).io.routerReadyOut := io(i).routerReadyOut
     tops(i).io.routerPacketOut := io(i).routerPacketOut
     tops(i).io.routerValidOut := io(i).routerValidOut
     io(i).routerPacketIn := tops(i).io.routerPacketIn
     io(i).routerValidIn := tops(i).io.routerValidIn
     io(i).routerReadyIn := tops(i).io.routerReadyIn
  }
}

class GeneratorTest(dut: TopGenerator) extends Tester(dut){
  for(i <- 0 until 8){
     poke(dut.io(i).fromProcessor.M.Cmd, 0x1)
     poke(dut.io(i).fromProcessor.M.Addr, 0xe808FFFF)
     poke(dut.io(i).fromProcessor.M.Data, 0xdeadbeef)
  }
  step(1)
  for(i <- 0 until 8){
     peek(dut.io(i).routerPacketIn)
     peek(dut.io(i).fromProcessor.S.Resp)
  }
  step(1)
  for(i <- 0 until 8){
     peek(dut.io(i).routerPacketIn)
     peek(dut.io(i).fromProcessor.S.Resp)
  }
  step(1)
  for(i <- 0 until 8){
     peek(dut.io(i).routerPacketIn)
     peek(dut.io(i).fromProcessor.S.Resp)
  }
  step(1)
  for(i <- 0 until 8){
     peek(dut.io(i).routerPacketIn)
     peek(dut.io(i).fromProcessor.S.Resp)
  }
  step(1)
  for(i <- 0 until 8){
     peek(dut.io(i).routerPacketIn)
     peek(dut.io(i).fromProcessor.S.Resp)
  }
  step(1)
  for(i <- 0 until 8){
     peek(dut.io(i).routerPacketIn)
     peek(dut.io(i).fromProcessor.S.Resp)
  }
  step(1)
  for(i <- 0 until 8){
     peek(dut.io(i).routerPacketIn)
     peek(dut.io(i).fromProcessor.S.Resp)
  }
  step(6)
}

object GeneratorTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new TopGenerator(9))) {
        m => new GeneratorTest(m)
      }
  }
}
