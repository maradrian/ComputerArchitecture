package NOC.TXTop

import Chisel._
import Node._
import patmos.Constants._
import NOC.TX._
import NOC.Route._

import ocp._

class TXTop(addr: Int = 0) extends Module {
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
 }
 val tx = Module(new TX())
 val lut0 = Module(new LUT_0())

 //Connect components
 tx.io.dst_addr <> lut0.io.dst_addr
 tx.io.route_out <> lut0.io.route_out

 tx.io.fromOCP <> io.fromOCP
 tx.io.TXReadyToOCP <> io.TXReadyToOCP
 tx.io.TXValidFromOCP <> io.TXValidFromOCP
 tx.io.TXReadyFromRouter <> io.TXReadyFromRouter
 tx.io.TXValidToRouter <> io.TXValidToRouter
 tx.io.packet <> io.packet

}

class TXTopTest(dut: TXTop) extends Tester(dut){
   //Test addr0
   poke(dut.io.fromOCP.M.Addr, 0xe8000001)
   poke(dut.io.fromOCP.M.Cmd, 0x1)
   poke(dut.io.fromOCP.M.Data, 0xbadcaffe) 
   peek(dut.tx.io.dst_addr)
   peek(dut.lut0.io.route_out)
   peek(dut.io.packet)

   //Test addr1
   poke(dut.io.fromOCP.M.Addr, 0xe8010001)
   poke(dut.io.fromOCP.M.Cmd, 0x1)
   poke(dut.io.fromOCP.M.Data, 0xbadcaffe) 
   peek(dut.tx.io.dst_addr)
   peek(dut.lut0.io.route_out)
   peek(dut.io.packet)

   //Test addr2
   poke(dut.io.fromOCP.M.Addr, 0xe8020001)
   poke(dut.io.fromOCP.M.Cmd, 0x1)
   poke(dut.io.fromOCP.M.Data, 0xbadcaffe) 
   peek(dut.tx.io.dst_addr)
   peek(dut.lut0.io.route_out)
   peek(dut.io.packet)

   //Test addr3
   poke(dut.io.fromOCP.M.Addr, 0xe8030001)
   poke(dut.io.fromOCP.M.Cmd, 0x1)
   poke(dut.io.fromOCP.M.Data, 0xbadcaffe) 
   peek(dut.tx.io.dst_addr)
   peek(dut.lut0.io.route_out)
   peek(dut.io.packet)

   //Test addr4
   poke(dut.io.fromOCP.M.Addr, 0xe8040001)
   poke(dut.io.fromOCP.M.Cmd, 0x1)
   poke(dut.io.fromOCP.M.Data, 0xbadcaffe) 
   peek(dut.tx.io.dst_addr)
   peek(dut.lut0.io.route_out)
   peek(dut.io.packet)

   //Test addr5
   poke(dut.io.fromOCP.M.Addr, 0xe8050001)
   poke(dut.io.fromOCP.M.Cmd, 0x1)
   poke(dut.io.fromOCP.M.Data, 0xbadcaffe) 
   peek(dut.tx.io.dst_addr)
   peek(dut.lut0.io.route_out)
   peek(dut.io.packet)

   //Test addr6
   poke(dut.io.fromOCP.M.Addr, 0xe8060001)
   poke(dut.io.fromOCP.M.Cmd, 0x1)
   poke(dut.io.fromOCP.M.Data, 0xbadcaffe) 
   peek(dut.tx.io.dst_addr)
   peek(dut.lut0.io.route_out)
   peek(dut.io.packet)

   //Test addr7
   poke(dut.io.fromOCP.M.Addr, 0xe8070001)
   poke(dut.io.fromOCP.M.Cmd, 0x1)
   poke(dut.io.fromOCP.M.Data, 0xbadcaffe) 
   peek(dut.tx.io.dst_addr)
   peek(dut.lut0.io.route_out)
   peek(dut.io.packet)

   //Test addr8
   poke(dut.io.fromOCP.M.Addr, 0xe8080001)
   poke(dut.io.fromOCP.M.Cmd, 0x1)
   poke(dut.io.fromOCP.M.Data, 0xbadcaffe) 
   peek(dut.tx.io.dst_addr)
   peek(dut.lut0.io.route_out)
   peek(dut.io.packet)  
}

object TXTopTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new TXTop())) {
        m => new TXTopTest(m)
      }
  }
}
