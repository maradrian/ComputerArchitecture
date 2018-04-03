package NOC.NIC_TEST


import Chisel._
import Node._
import patmos.Constants._
import io._
import ocp._


class Top() extends Module(){
  val io = new Bundle{
    val fromProcessor = new OcpCoreSlavePort(ADDR_WIDTH, DATA_WIDTH)
    val routerPacketIn = Output(UInt(width = 96))
    val routerValidIn = Output(Bool())
    val routerReadyOut = Input(Bool())
    val routerPacketOut = Input(UInt(width = 96))
    val routerValidOut = Input(Bool())
    val routerReadyIn = Output(Bool()) 
  }

  val ocpHanshake = Module(new Handshake())
  val addressDecoder = Module(new AddressDecoder())
  val dataDecoder = Module(new DataDecoder())
  val ocpMemoryRead = Module(new OcpMemoryRead())
  val memory = Module(new Memory())
  val tx = Module(new TX())
  val rx = Module(new RX())
  
  //connects NIC with Patmos
  addressDecoder.io.fromPatmos <> io.fromProcessor.M   //address decoder takes OCP master signals (CMD, addr, data and MByteEns)
  dataDecoder.io.toPatmos <> io.fromProcessor.S //data decoder takes OCP slave signals(SResp, Sdata)
  
  //connecting decoders with handshake component (god this name sounds weird) and with ocpMemoryRead(1:1 on weird names)
  ocpHandshake.io.fromCore.M <> addressDecoder.io.toHandshake
  ocpMemoryRead.io.fromCore.M <> addressDecoder.io.toMemoryRead
  ocpHandshake.io.fromCore.S <> dataDecoder.io.fromHandshake 
  ocpMemoryRead.io.fromCore.S <> dataDecoder.io.fromMemoryRead
  
  //connecting ocp memory read component(again this weird name)
  memory.io.addr2 := ocpMemoryRead.io.addr
  ocpMemoryRead.io.dataIn := memory.io.dataOut2
  memory.io.enable2 := ocpMemoryRead.io.enable
  memory.io.dataIn2 := ocpMemoryRead.io.dataOut

  //connecting RX with memory
  memory.io.addr := rx.io.addr
  memory.io.dataIn := rx.io.dataOut
  rx.io.dataIn := memory.io.dataOut
  memory.io.enable := rx.io.en

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
}

