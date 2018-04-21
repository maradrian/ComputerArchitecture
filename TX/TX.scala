package NOC.TX

import Chisel._
import Node._
import patmos.Constants._

import ocp._

class TX() extends Module {
 val io = new Bundle{
      	//Data from OCPHandshake
      	val fromOCP = new OcpCoreSlavePort(ADDR_WIDTH, DATA_WIDTH)

      	//OCPHandshake - TX interface
      	val TXReadyToOCP = Output(Bool())
      	val TXValidFromOCP = Input(Bool())

     	//TX - Router interface
      	val TXReadyFromRouter = Input(Bool())
      	val TXValidToRouter = Output(Bool())
      	val packet = Output(UInt(width = 96))

	//Data for/from Look-up table for the route
	val dst_addr = Output(UInt(width = 4))
	val route_out = Input(UInt(width = 10))
 }
 val unused_bits = Bits(0, 21)
 val response = Bits(0, 32)

 //Read cmd by default
 val cmd_signal = Bits(width = 1) 
 cmd_signal:= Bits(0)

 //Obtain destination router ID	
 io.dst_addr := io.fromOCP.M.Addr(19, 16)

 when(io.fromOCP.M.Cmd === OcpCmd.WR){
        cmd_signal := Bits(1)
 }.elsewhen(io.fromOCP.M.Cmd === OcpCmd.RD){
        cmd_signal := Bits(0)
 }.otherwise{
	//Idle, do nothing
 }

 io.packet := Cat(unused_bits, cmd_signal, io.route_out, io.fromOCP.M.Addr, io.fromOCP.M.Data)
 io.TXValidToRouter := io.TXValidFromOCP
 io.TXReadyToOCP := io.TXReadyFromRouter

 io.fromOCP.S.Resp := OcpResp.DVA //Default DVA
 io.fromOCP.S.Data := response
}

class TXTest(dut: TX) extends Tester(dut){
   /*Write cmd, valid data, router ready*/
   poke(dut.io.fromOCP.M.Cmd, 0x1) //Write => b001
   poke(dut.io.fromOCP.M.Addr, 0xe8010001)
   poke(dut.io.fromOCP.M.Data, 0xbadcaffe)
   poke(dut.io.route_out, 0x3ff) //Simulate route for now - 10bits
   
   poke(dut.io.TXValidFromOCP, true) //Valid from OCP
   poke(dut.io.TXReadyFromRouter, true) //Ready from Router

   peek(dut.io.fromOCP.S.Resp) 
   peek(dut.io.fromOCP.S.Data)
   peek(dut.io.TXValidToRouter) 
   peek(dut.io.TXReadyToOCP) 
   peek(dut.io.dst_addr) 
   peek(dut.io.packet)
   step(1)

   /*Write cmd, NO valid data, router NOT ready*/
   poke(dut.io.fromOCP.M.Cmd, 0x1) //Write => b001
   poke(dut.io.fromOCP.M.Addr, 0xe8020002)
   poke(dut.io.fromOCP.M.Data, 0xdeadface)
   poke(dut.io.route_out, 0x2bc) //Simulate route for now - 10bits
   
   poke(dut.io.TXValidFromOCP, false) //Valid from OCP
   poke(dut.io.TXReadyFromRouter, false) //Ready from Router

   peek(dut.io.fromOCP.S.Resp) 
   peek(dut.io.fromOCP.S.Data)
   peek(dut.io.TXValidToRouter) 
   peek(dut.io.TXReadyToOCP) 
   peek(dut.io.dst_addr) 
   peek(dut.io.packet)
   step(1)

   /*Write cmd, valid data, router NOT ready*/
   poke(dut.io.fromOCP.M.Cmd, 0x1) //Write => b001
   poke(dut.io.fromOCP.M.Addr, 0xe8030003)
   poke(dut.io.fromOCP.M.Data, 0xdeafbabe)
   poke(dut.io.route_out, 0x1ad) //Simulate route for now - 10bits
   
   poke(dut.io.TXValidFromOCP, true) //Valid from OCP
   poke(dut.io.TXReadyFromRouter, false) //Ready from Router

   peek(dut.io.fromOCP.S.Resp) 
   peek(dut.io.fromOCP.S.Data)
   peek(dut.io.TXValidToRouter) 
   peek(dut.io.TXReadyToOCP) 
   peek(dut.io.dst_addr) 
   peek(dut.io.packet)
   step(1)

   /*Read cmd*/
   poke(dut.io.fromOCP.M.Cmd, 0x2) //Read => b010
   poke(dut.io.fromOCP.M.Addr, 0xe8040004)
   poke(dut.io.fromOCP.M.Data, 0xdeafbabe)
   poke(dut.io.route_out, 0x111) //Simulate route for now - 10bits
   
   poke(dut.io.TXValidFromOCP, true) //Valid from OCP
   poke(dut.io.TXReadyFromRouter, false) //Ready from Router

   peek(dut.io.fromOCP.S.Resp) 
   peek(dut.io.fromOCP.S.Data)
   peek(dut.io.TXValidToRouter) 
   peek(dut.io.TXReadyToOCP) 
   peek(dut.io.dst_addr) 
   peek(dut.io.packet)
   step(1)
}

object TXTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new TX())) {
        m => new TXTest(m)
      }
  }
}
