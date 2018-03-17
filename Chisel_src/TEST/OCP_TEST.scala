/*
 * Simple testbench supposed to pour some OCP signals to our NIC.
 * This one tests writing the address, data and response and then also reading the data.
 * ports master: MCmd, MAddr, MData, MByteEn
 * ports slave: SData, SResp
 */
package NOC.TEST

import Chisel._
import ocp._
import patmos.Constants._

/*// Constants for MCmd
object OcpCmd {
  val IDLE = Bits("b000")
  val WR   = Bits("b001")
  val RD   = Bits("b010")
//  val RDEX = Bits("b011")
//  val RDL  = Bits("b100")
//  val WRNP = Bits("b101")
//  val WRC  = Bits("b110")
//  val BCST = Bits("b111")
}

// Constants for SResp
object OcpResp {
  val NULL = Bits("b00")
  val DVA  = Bits("b01")
  val FAIL = Bits("b10")
  val ERR  = Bits("b11")
}*/

class OCP_TEST(dut: Handshake) extends Tester(dut) {
  //issues command to write the data
  poke(dut.io.ocp.M.Cmd, OcpCmd.WR)
  poke(dut.io.ocp.M.Data, UInt(15))
  poke(dut.io.ocp.M.Addr, "he8000003")
  //sleeps for one clock cycle
  step(1)
  //peeks data valid responseo
  peek(dut.io.ocp.S.Resp, OcpResp.DVA)
  //sleeps one clock cycle
  step(1)
  //issues command to read the data
  poke(dut.io.ocp.M.Cmd, OcpCmd.RD)
  poke(dut.io.ocp.M.Addr, "he8000003")
  //sleeps one clock cycle
  step(1)
  //peeks for data valid response and data
  peek(dut.io.ocp.S.Data, UInt(15))
  peek(dut.io.ocp.S.Resp, OcpResp.DVA)
}

object OCP_TEST{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
	"--compile", "--vcd", "--targetDir", "generated"),
	() => Module(new Handshake())){
	  c => new OCP_TEST(c)
	}
  }
}
