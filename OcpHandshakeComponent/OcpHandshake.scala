package NOC.OcpHandshakeComponent

import Chisel._
import Node._
import patmos.Constants._
import io._
import ocp._


class Handshake() extends CoreDevice() {
  val io2 = new Bundle{
     val TXRead = Input(Bool())
     val TXValid = Output(Bool())
  }
  val MPort2 = new OcpCoreMasterSignals(16, 32).asOutput
  val SPort2 = new OcpSlaveSignals(32).asInput

  val regMasterIn = Reg(init = MPort2)
  val regTxOut  = Reg(init = regMasterIn)
}
