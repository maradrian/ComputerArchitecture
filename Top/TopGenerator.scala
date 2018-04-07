package NOC.Top

import Chisel._
import Node._
import patmos.Constants._
import io._
import ocp._
import NOC.Route._

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
  val luts = new Array[Lut](9)
  luts(0) = Module(new LUT_0())
  luts(1) = Module(new LUT_1())  
  luts(2) = Module(new LUT_2())  
  luts(3) = Module(new LUT_3())  
  luts(4) = Module(new LUT_4())  
  luts(5) = Module(new LUT_5())  
  luts(6) = Module(new LUT_6())  
  luts(7) = Module(new LUT_7())  
  luts(8) = Module(new LUT_8())  


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
     tops(i).io.route_out := luts(i).io.route_out
     luts(i).io.dst_addr := tops(i).io.dst_addr
  }
}

class GeneratorTest(dut: TopGenerator) extends Tester(dut){
  for(i <- 0 until 9){
     poke(dut.io(i).fromProcessor.M.Cmd, 0x1)
     poke(dut.io(i).fromProcessor.M.Addr, 0xe808FFFF)
     poke(dut.io(i).fromProcessor.M.Data, 0xdeadbeef)
  }
  step(1)
  for(i <- 0 until 9){
     peek(dut.io(i).routerPacketIn)
     peek(dut.io(i).fromProcessor.S.Resp)
  }
  step(1)
  for(i <- 0 until 9){
     peek(dut.io(i).routerPacketIn)
     peek(dut.io(i).fromProcessor.S.Resp)
  }
  step(1)
  for(i <- 0 until 9){
     peek(dut.io(i).routerPacketIn)
     peek(dut.io(i).fromProcessor.S.Resp)
  }
  step(1)
  for(i <- 0 until 9){
     peek(dut.io(i).routerPacketIn)
     peek(dut.io(i).fromProcessor.S.Resp)
  }
  step(1)
  for(i <- 0 until 9){
     peek(dut.io(i).routerPacketIn)
     peek(dut.io(i).fromProcessor.S.Resp)
  }
  step(1)
  for(i <- 0 until 9){
     peek(dut.io(i).routerPacketIn)
     peek(dut.io(i).fromProcessor.S.Resp)
  }
  step(1)
  for(i <- 0 until 9){
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
