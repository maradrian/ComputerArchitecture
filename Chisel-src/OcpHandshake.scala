import Chisel._
import Node._
import patmos.Constants._

import ocp._


class Handshake() extends CoreDevice() {
    val io = new Bundle() {
    	val fromEnv = new OcpCoreSlavePort(ADDR_WIDTH, DATA_WIDTH)
    	val toEnv = new OcpCoreMasterPort(ADDR_WIDTH, DATA_WIDTH)
  	}

  	val fromRegM = Reg(OcpCoreSlavePort(ADDR_WIDTH, DATA_WIDTH))
  	val fromRegTemp = Reg(OcpCoreSlavePort(ADDR_WIDTH, DATA_WIDTH))
  	val toRegS = Reg(OcpCoreMasterPort(ADDR_WIDTH, DATA_WIDTH))

  	val fromRegSResp = Reg(init = OcpResp.NULL )
  	val fromRegSData = Reg(init = Bits(0, DATA_WIDTH))

  	when(toRegS.Resp === OcpResp.DVA){
  		fromRegM := fromEnv.M
  		fromRegTemp := fromEnv.M
  	} .elsewhen(toRegS.Resp === OcpResp.NULL){
  		fromRegM := fromRegTemp
  	}


}