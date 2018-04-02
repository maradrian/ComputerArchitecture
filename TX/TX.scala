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

	//Look-up table for the route
	val dst_addr = Output(UInt(width = 4))
	val route_out = Input(UInt(width = 15))
 }
 val unused_bits = Reg(init = Bits(0, 15))
 val cmd = Reg(init = Bits(0, 1)) //Read by default

 //Obtain destination router ID	
 io.dst_addr := io.fromOCP.M.Addr(19, 16)
 val route = Reg(init = io.route_out)

 when(io.fromOCP.M.Cmd === OcpCmd.WR){
        cmd := Bits(1)
 }.elsewhen(io.fromOCP.M.Cmd === OcpCmd.WR){
        cmd := Bits(0)
 }.otherwise{
	//Idle, do nothing
 }

 io.packet := Cat(unused_bits, cmd, route, io.fromOCP.M.Addr, io.fromOCP.M.Data)
 io.TXValidToRouter := io.TXValidFromOCP
 io.TXReadyToOCP := io.TXReadyFromRouter

 io.fromOCP.S.Resp := OcpResp.DVA //Just a default test
 io.fromOCP.S.Data := 0x00000000  //Default resp data  
}


class TXTest(dut: TX) extends Tester(dut){
   /*First test: write cmd, valid data and router is ready*/
   //Write cmd
   poke(dut.io.fromOCP.M.Cmd, 0x1) //Write => 001
   poke(dut.io.fromOCP.M.Addr, 0x1)
   poke(dut.io.fromOCP.M.Data, 0x1)

   //Valid from OCP
   poke(dut.io.TXValidFromOCP, 0x1)

   //Ready from Router
   poke(dut.io.TXReadyFromRouter, 0x1)
   step(1)
   //Accept write cmd
   peek(dut.io.fromOCP.S.Resp) //DVA
   peek(dut.io.fromOCP.S.Data) //0x00000000

   poke(dut.io.fromCore.M.Cmd, 0x1)//Write command
   poke(dut.io.fromCore.M.Addr, 0xe8000001)
   poke(dut.io.fromCore.M.Data, 0xdeadbeef)
   poke(dut.io.TXReady, true)
   peek(dut.io.TXValid)
   peek(dut.io.toTX.M)
   step(1)
   poke(dut.io.fromCore.M.Cmd, 0x0)//Write command
   poke(dut.io.TXReady, true)
   peek(dut.io.fromCore.S.Resp)
   peek(dut.io.TXValid)
   peek(dut.io.toTX.M)
   step(1)
   /*
    * In this part we let the handshake component wait for a few steps
    *
    */
   poke(dut.io.fromCore.M.Cmd, 0x0)//Null command
   poke(dut.io.TXReady, true)
   peek(dut.io.TXValid)
   step(1)
   poke(dut.io.fromCore.M.Cmd, 0x1)//Write command
   poke(dut.io.fromCore.M.Addr, 0xe8000001)
   poke(dut.io.fromCore.M.Data, 0xdeadbeef)
   poke(dut.io.TXReady, false)
   peek(dut.io.TXValid)
   step(1)
   poke(dut.io.fromCore.M.Cmd, 0x0)//Write command
   poke(dut.io.TXReady, false)
   peek(dut.io.fromCore.S.Resp)
   peek(dut.io.TXValid)
   peek(dut.io.toTX.M)
   step(1)
   poke(dut.io.fromCore.M.Cmd, 0x0)//Write command
   poke(dut.io.TXReady, false)
   peek(dut.io.fromCore.S.Resp)
   peek(dut.io.TXValid)
   peek(dut.io.toTX.M)
   step(1)
   poke(dut.io.fromCore.M.Cmd, 0x0)//Write command
   poke(dut.io.TXReady, false)
   peek(dut.io.fromCore.S.Resp)
   peek(dut.io.TXValid)
   peek(dut.io.toTX.M)
   step(1)
   poke(dut.io.fromCore.M.Cmd, 0x0)//Write command
   poke(dut.io.TXReady, true)
   peek(dut.io.fromCore.S.Resp)
   peek(dut.io.TXValid)
   peek(dut.io.toTX.M)
   step(1)
   poke(dut.io.fromCore.M.Cmd, 0x0)//Write command
   poke(dut.io.TXReady, true)
   peek(dut.io.fromCore.S.Resp)
   peek(dut.io.TXValid)
   peek(dut.io.toTX.M)
   step(1)
   /*
    * The last part of the test tests read commmand evn though we probably won`t use it
    *
    *
    */
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
