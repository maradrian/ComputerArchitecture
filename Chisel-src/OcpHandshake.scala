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
  	val toRegM = Reg(OcpCoreMasterPort(ADDR_WIDTH, DATA_WIDTH))
  	val enable_reg = Reg(next = toEnv.S)

  	val fromRegSResp = Reg(init = OcpResp.NULL )
  	val fromRegSData = Reg(init = Bits(0, DATA_WIDTH))

  	when(enable_reg.Resp === OcpResp.DVA){
  		fromRegM := fromEnv.M
  		fromRegTemp := fromEnv.M

  	} .elsewhen(enable_reg.Resp === OcpResp.NULL){
  		fromRegM := fromRegTemp

  	} .otherwise{
  		enable_reg := toEnv.S
  		fromEnv.S := toEnv.S
  	}

  	when(toEnv.S.Resp === OcpResp.DVA){
  		toEnv.M := fromRegM
  	}


}