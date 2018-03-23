package NOC.Memory

import Chisel._
import Node._
import patmos.Constants._
import io._
import ocp._

class OcpMemoryRead() extends CoreDevice() {
  val io2 = new Bundle{
     val addr = Output(UInt(width = 16))
     val dataIn = Input(UInt(width = 32)) 
  }
  
  
  val WaitForCmd :: issueAddress :: sendBackData :: Nil = Enum(UInt(), 3)
  val stateReg = Reg(init = 
}
