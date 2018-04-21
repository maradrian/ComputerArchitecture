package NOC.NOC_chisel

import Chisel._
import NOC.Top._
import Node._
import patmos.Constants._
import io._
import ocp._

class OCPPorts extends Bundle{
   val fromProcessor = new OcpCoreSlavePort(ADDR_WIDTH, DATA_WIDTH)
}

class Wrapper(nrCores : Int) extends Module(){
   val io = new Bundle{
	val io = Vec(nrCores, new OCPPorts())
 }

   val NoC  = Module(new NOC_chisel(96, nrCores))
   val NIs = Module(new TopGenerator(nrCores))
   
   for (i <- 0 until nrCores){
      //connect to network
      NoC.io.local_packet_in(i) <> NIs.io(i).routerPacketIn
      NoC.io.local_valid_in(i) <> NIs.io(i).routerValidIn
      NoC.io.local_ready_in(i) <> NIs.io(i).routerReadyIn
      //connect from network
      NIs.io(i).routerPacketOut <> NoC.io.local_packet_out(i)
      NIs.io(i).routerReadyOut <> NoC.io.local_ready_out(i)
      NIs.io(i).routerValidOut <> NoC.io.local_valid_out(i)
      //connection with patmos
      NIs.io(i).fromProcessor.M <> io.io(i).fromProcessor.M
      NIs.io(i).fromProcessor.S <> io.io(i).fromProcessor.S
   }
}

object Wrapper {
  def main(args: Array[String]): Unit = {
    chiselMain(Array("--backend", "v"), () => Module(new Wrapper(9)))
  }
}


class WrapperTester(dut: Wrapper) extends Tester(dut){
   //poke(dut.io(0).fromProcessor.M.Cmd, 0x01)
}

object WrapperTester {
  def main(args: Array[String]): Unit = {
    println("Generating the wrapper hardware")
    
    
    val nrCores = 9

    chiselMainTest(args, () => Module(new Wrapper(
        nrCores))){
        f => new WrapperTester(f)
    }
  }
}
