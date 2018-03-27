package NOC.Decoder

import Chisel._
import Node._
import patmos.Constants._
import io._
import ocp._


class DataDecoder() extends Module {
  val io = new Bundle{
    val toPatmos =     new OcpSlaveSignals(DATA_WIDTH).asOutput
    val fromHandshake =  new OcpSlaveSignals(DATA_WIDTH).asInput
    val fromMemoryRead = new OcpSlaveSignals(DATA_WIDTH).asInput
  }

  io.toPatmos.Resp := OcpResp.NULL
  io.toPatmos.Data := UInt(0)  

  when(io.fromHandshake.Resp === OcpResp.DVA){
    io.toPatmos.Resp := io.fromHandshake.Resp
    io.toPatmos.Data := io.fromHandshake.Data  
  }.elsewhen(io.fromMemoryRead.Resp === OcpResp.DVA){
    io.toPatmos.Resp := io.fromMemoryRead.Resp
    io.toPatmos.Data := io.fromMemoryRead.Data
  }
}

class DataDecoderTest(dut: DataDecoder) extends Tester(dut){
   //poke some empty data
   step(1)
   poke(dut.io.fromHandshake.Resp, 0x0)
   poke(dut.io.fromMemoryRead.Resp, 0x0)
   peek(dut.io.toPatmos.Resp)
   step(1)
   poke(dut.io.fromHandshake.Resp, 0x0)
   poke(dut.io.fromMemoryRead.Resp, 0x0)
   peek(dut.io.toPatmos.Resp)
   step(1)
   poke(dut.io.fromHandshake.Resp, 0x0)
   poke(dut.io.fromMemoryRead.Resp, 0x0)
   peek(dut.io.toPatmos.Resp)
   //poke from handshake
   step(1)
   poke(dut.io.fromHandshake.Resp, 0x1)
   poke(dut.io.fromHandshake.Data, 0x20002000)
   poke(dut.io.fromMemoryRead.Resp, 0x0)
   peek(dut.io.toPatmos.Resp)
   peek(dut.io.toPatmos.Data)
   step(1)
   poke(dut.io.fromHandshake.Resp, 0x1)
   poke(dut.io.fromHandshake.Data, 0x20002000)
   poke(dut.io.fromMemoryRead.Resp, 0x0)
   poke(dut.io.fromMemoryRead.Data, 0x8badf00d)
   peek(dut.io.toPatmos.Resp)
   peek(dut.io.toPatmos.Data)
   //poke from memory read
   step(1)
   poke(dut.io.fromHandshake.Resp, 0x0)
   poke(dut.io.fromMemoryRead.Data, 0xBAAAAAAD)
   poke(dut.io.fromMemoryRead.Resp, 0x1)
   peek(dut.io.toPatmos.Resp)
   peek(dut.io.toPatmos.Data)
   step(1)
   poke(dut.io.fromHandshake.Resp, 0x0)
   poke(dut.io.fromHandshake.Data, 0x20002000)
   poke(dut.io.fromMemoryRead.Resp, 0x1)
   poke(dut.io.fromMemoryRead.Data, 0x8badf00d)
   peek(dut.io.toPatmos.Resp)
   peek(dut.io.toPatmos.Data)
   //theoretical situation where you poke from both (cannot happen since processor won`t issue another command until it receives DVA)
   step(1)
   poke(dut.io.fromHandshake.Resp, 0x1)
   poke(dut.io.fromMemoryRead.Data, 0xBAAAAAAD)
   poke(dut.io.fromMemoryRead.Resp, 0x1)
   poke(dut.io.fromMemoryRead.Data, 0x8badf00d)
   peek(dut.io.toPatmos.Resp)
   peek(dut.io.toPatmos.Data)
   step(1)
   poke(dut.io.fromHandshake.Resp, 0x1)
   poke(dut.io.fromHandshake.Data, 0x20002000)
   poke(dut.io.fromMemoryRead.Resp, 0x1)
   poke(dut.io.fromMemoryRead.Data, 0x8badf00d)
   peek(dut.io.toPatmos.Resp)
   peek(dut.io.toPatmos.Data)
}

object DataDecoderTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new DataDecoder())) {
        dd => new DataDecoderTest(dd)
      }
  }
}
