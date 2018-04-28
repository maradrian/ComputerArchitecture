package NOC.Top


import Chisel._
import Node._
import patmos.Constants._
import io._
import ocp._

import NOC.TX._
import NOC.RX._
import NOC.Decoder._
import NOC.Memory._
import NOC.OcpHandshakeComponent._
import NOC.TXTop._
import NOC.MemoryArbiter._

//import NOC._
class Top(val address : Int = 0) extends Module(){
  val io = new Bundle{
    val fromProcessor = new OcpCoreSlavePort(ADDR_WIDTH, DATA_WIDTH)
    val routerPacketIn = Output(UInt(width = 96))
    val routerValidIn = Output(Bool())
    val routerReadyOut = Input(Bool())
    val routerPacketOut = Input(UInt(width = 96))
    val routerValidOut = Input(Bool())
    val routerReadyIn = Output(Bool()) 
    //Data for/from Look-up table for the route
    val dst_addr = Output(UInt(width = 4))
    val route_out = Input(UInt(width = 10))
  }

  val ocpHandshake = Module(new Handshake())
  val addressDecoder = Module(new AddressDecoder(address))
  val dataDecoder = Module(new DataDecoder())
  val ocpMemoryRead = Module(new OcpMemoryRead())
  val memory = Module(new Memory())
  val tx = Module(new TX())
  val rx = Module(new RX())
  val arbiter = Module(new MemoryArbiter())
  
  //connects NIC with Patmos
  addressDecoder.io.fromPatmos <> io.fromProcessor.M   //address decoder takes OCP master signals (CMD, addr, data and MByteEns)
  dataDecoder.io.toPatmos <> io.fromProcessor.S //data decoder takes OCP slave signals(SResp, Sdata)
  
  //connecting decoders with handshake component (god this name sounds weird) and with ocpMemoryRead(1:1 on weird names)
  ocpHandshake.io.fromCore.M <> addressDecoder.io.toHandshake
  ocpMemoryRead.io.fromCore.M <> addressDecoder.io.toMemoryRead
  ocpHandshake.io.fromCore.S <> dataDecoder.io.fromHandshake 
  ocpMemoryRead.io.fromCore.S <> dataDecoder.io.fromMemoryRead

  //Connecting OcpMemoryRead with MemoryArbiter
  arbiter.io.addrFromOcpMemoryRead := ocpMemoryRead.io.addr
  ocpMemoryRead.io.dataIn := memory.io.dataOut2
  arbiter.io.enableFromOcpMemoryRead := ocpMemoryRead.io.enable
  arbiter.io.dataFromOcpMemoryRead := ocpMemoryRead.io.dataOut
  ocpMemoryRead.io.readyIn := arbiter.io.readyToOcpMemoryRead

  //Connecting RX with MemoryArbiter
  arbiter.io.addrFromRX := rx.io.addr
  arbiter.io.dataFromRX := rx.io.dataOut
  rx.io.readyIn := arbiter.io.readyToRX
  arbiter.io.enableFromRX := rx.io.en

  //Connecting MemoryArbiter with Memory
  memory.io.dataIn := arbiter.io.dataToMemory  
  memory.io.addr2 := arbiter.io.addrToMemory
  memory.io.enable := arbiter.io.enable
  

  //connecting TX with handshake
  tx.io.fromOCP.M <> ocpHandshake.io.toTX.M
  ocpHandshake.io.toTX.S <> tx.io.fromOCP.S
  tx.io.TXValidFromOCP := ocpHandshake.io.TXValid
  ocpHandshake.io.TXReady := tx.io.TXReadyToOCP

  //connecting TX with router
  tx.io.TXReadyFromRouter := io.routerReadyOut
  io.routerValidIn := tx.io.TXValidToRouter
  io.routerPacketIn := tx.io.packet
  
  //connecting RX with router
  io.routerReadyIn := rx.io.ready
  rx.io.valid := io.routerValidOut
  rx.io.packet := io.routerPacketOut 
  
  //connecting LUTs
  tx.io.route_out := io.route_out
  io.dst_addr:= tx.io.dst_addr
}

object Top {
  def main(args: Array[String]): Unit = {
    chiselMain(Array("--backend", "v"), () => Module(new Top(9)))
  }
}


