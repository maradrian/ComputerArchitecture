package NOC.Loopback


import Chisel._
import NOC.Top._
import Node._
import patmos.Constants._
import io._
import ocp._

class TestInterfaces() extends Module(){
   val io = new Bundle{
	val fromProcessor = new OcpCoreSlavePort(ADDR_WIDTH, DATA_WIDTH)
   }

   /*val io = new Bundle{
    val fromProcessor = new OcpCoreSlavePort(ADDR_WIDTH, DATA_WIDTH)
    val routerPacketIn = Output(UInt(width = 96))
    val routerValidIn = Output(Bool())
    val routerReadyOut = Input(Bool())
    val routerPacketOut = Input(UInt(width = 96))
    val routerValidOut = Input(Bool())
    val routerReadyIn = Output(Bool()) 
  }*/

  /*
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
  */

   val NIC = Module(new Top())
   val loopback = Module(new Loopback())
   
   NIC.io.fromProcessor.M <> io.fromProcessor.M
   NIC.io.fromProcessor.S <> io.fromProcessor.S

   loopback.io.TXValidToRouter := NIC.io.routerValidIn
   loopback.io.packetIn := NIC.io.routerPacketIn
   loopback.io.ready := NIC.io.routerReadyIn

   NIC.io.routerReadyOut := loopback.io.TXReadyFromRouter
   NIC.io.routerPacketOut := loopback.io.packetOut
   NIC.io.routerValidOut := loopback.io.valid
}

class NICLoopbackTest(dut: TestInterfaces) extends Tester(dut){
   poke(dut.io.fromProcessor.M.Cmd, 0x0)
   step(1)
   step(1)
   poke(dut.io.fromProcessor.M.Cmd, 0x1)
   poke(dut.io.fromProcessor.M.Addr, 0xe8019430)
   poke(dut.io.fromProcessor.M.Data, 0xdeadbeef)
   step(1)
   poke(dut.io.fromProcessor.M.Cmd, 0x0)
   while(peek(dut.io.fromProcessor.S.Resp) == 0x0){
      peek(dut.io.fromProcessor.S.Resp)
      step(1)
   }
   peek(dut.io.fromProcessor.S.Resp)
   step(10)
   poke(dut.io.fromProcessor.M.Cmd, 0x2)
   poke(dut.io.fromProcessor.M.Addr, 0xe8009430)
   step(1)
   poke(dut.io.fromProcessor.M.Cmd, 0x0)
   while(peek(dut.io.fromProcessor.S.Resp) == 0x0){
      peek(dut.io.fromProcessor.S.Resp)
      step(1)
   }
   peek(dut.io.fromProcessor.S.Resp)
   peek(dut.io.fromProcessor.S.Data)
   step(1)
   step(1)
}

object NICLoopbackTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new TestInterfaces())) {
        m => new NICLoopbackTest(m)
      }
  }
}
