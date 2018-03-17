package NOC

import Chisel._
import Node._
import patmos.Constants._

import ocp._


class Handshake() extends CoreDevice() {
    /*val io = new Bundle() {
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
  	}*/
	
	/*
	 *  OCP device waits for command. If command is WR, then write the data into dataR, if it is read command, reads the data from the register
	 */
	//states for our state machine
	val states :: WAIT_CMD :: REPLY :: WRITE = Enum(UInt(), 32)
	val dataR = Reg(init = Bits(32, DATA_WIDTH))
	val stateReg = Reg(init = states)	

	io.ocp.S.Data := dataR
	io.ocp.S.Resp := OcpResp.NULL
	
	//Waiting state
	when(stateReg === WAIT_CMD){
	  when(io.ocp.M.Cmd === OcpCmd.RD){
	    stateReg := REPLY
	  }.elsewhen(io.ocp.M.Cmd === OcpCmd.WR){
	    stateReg := WRITE
	  }
	  //In the reply state we simply issue OcpResp.DVA, data is already in the io.ocp.S.Data
	}.elsewhen(stateReg === REPLY){
	  io.ocp.S.Resp := OcpResp.DVA
	  stateReg := WAIT_CMD
	  //Writes data to the register
	}.elsewhen(stateReg === WRITE){
	  io.ocp.S.Resp := OcpResp.DVA
	  dataR := io.ocp.M.Data
	  stateReg := WAIT_CMD
	}
}
