package NOC.Decoder

import Chisel._
import Node._
import patmos.Constants._
import io._
import ocp._

class AddressDecoder(val address : Int = 0) extends Module{
  val io = new Bundle{
     val fromPatmos   =  new OcpMasterSignals(ADDR_WIDTH, DATA_WIDTH).asInput
     val toHandshake  = new OcpMasterSignals(ADDR_WIDTH, DATA_WIDTH).asOutput
     val toMemoryRead = new OcpMasterSignals(ADDR_WIDTH, DATA_WIDTH).asOutput
  }

  io.toHandshake.Cmd := OcpCmd.IDLE
  io.toMemoryRead.Cmd := OcpCmd.IDLE
  io.toHandshake.Addr := UInt(0)
  io.toMemoryRead.Addr := UInt(0)
  io.toHandshake.Data := UInt(0)
  io.toMemoryRead.Data := UInt(0)

  when(io.fromPatmos.Addr(19, 16) === UInt(address)){
     io.toMemoryRead.Cmd := io.fromPatmos.Cmd
     io.toMemoryRead.Addr := io.fromPatmos.Addr
     io.toMemoryRead.Data := io.fromPatmos.Data
  }.otherwise{
     io.toHandshake.Cmd := io.fromPatmos.Cmd
     io.toHandshake.Addr := io.fromPatmos.Addr
     io.toHandshake.Data := io.fromPatmos.Data
  }
}

class AddressDecoderTest(dut: AddressDecoder) extends Tester(dut){
  //first poke no data
  step(1)
  poke(dut.io.fromPatmos.Cmd, 0x0)
  poke(dut.io.fromPatmos.Addr, 0x0)
  poke(dut.io.fromPatmos.Data, 0x0)
  peek(dut.io.toHandshake.Cmd)
  peek(dut.io.toHandshake.Addr)
  peek(dut.io.toHandshake.Data)
  peek(dut.io.toMemoryRead.Cmd)
  peek(dut.io.toMemoryRead.Addr)
  peek(dut.io.toMemoryRead.Data)
  step(1)
  poke(dut.io.fromPatmos.Cmd, 0x0)
  poke(dut.io.fromPatmos.Addr, 0x0)
  poke(dut.io.fromPatmos.Data, 0x0)
  peek(dut.io.toHandshake.Cmd)
  peek(dut.io.toHandshake.Addr)
  peek(dut.io.toHandshake.Data)
  peek(dut.io.toMemoryRead.Cmd)
  peek(dut.io.toMemoryRead.Addr)
  peek(dut.io.toMemoryRead.Data)
  step(1)
  poke(dut.io.fromPatmos.Cmd, 0x0)
  poke(dut.io.fromPatmos.Addr, 0x0)
  poke(dut.io.fromPatmos.Data, 0x0)  
  peek(dut.io.toHandshake.Cmd)
  peek(dut.io.toHandshake.Addr)
  peek(dut.io.toHandshake.Data)
  peek(dut.io.toMemoryRead.Cmd)
  peek(dut.io.toMemoryRead.Addr)
  peek(dut.io.toMemoryRead.Data)
  //poke data to the handshake
  step(1)
  poke(dut.io.fromPatmos.Cmd, 0x1)
  poke(dut.io.fromPatmos.Addr, 0xe801fabc)
  poke(dut.io.fromPatmos.Data, 0xBAAAAAAD)
  peek(dut.io.toHandshake.Cmd)
  peek(dut.io.toHandshake.Addr)
  peek(dut.io.toHandshake.Data)
  peek(dut.io.toMemoryRead.Cmd)
  peek(dut.io.toMemoryRead.Addr)
  peek(dut.io.toMemoryRead.Data)
  step(1)
  poke(dut.io.fromPatmos.Cmd, 0x2)
  poke(dut.io.fromPatmos.Addr, 0xe803fabc)
  poke(dut.io.fromPatmos.Data, 0xdeadbeef)  
  peek(dut.io.toHandshake.Cmd)
  peek(dut.io.toHandshake.Addr)
  peek(dut.io.toHandshake.Data)
  peek(dut.io.toMemoryRead.Cmd)
  peek(dut.io.toMemoryRead.Addr)
  peek(dut.io.toMemoryRead.Data)
  //poke data to the memory
  step(1)
  poke(dut.io.fromPatmos.Cmd, 0x1)
  poke(dut.io.fromPatmos.Addr, 0xe800fabc)
  poke(dut.io.fromPatmos.Data, 0xBAAAAAAD)
  peek(dut.io.toHandshake.Cmd)
  peek(dut.io.toHandshake.Addr)
  peek(dut.io.toHandshake.Data)
  peek(dut.io.toMemoryRead.Cmd)
  peek(dut.io.toMemoryRead.Addr)
  peek(dut.io.toMemoryRead.Data)
  step(1)
  poke(dut.io.fromPatmos.Cmd, 0x2)
  poke(dut.io.fromPatmos.Addr, 0xe8000abc)
  poke(dut.io.fromPatmos.Data, 0xdeadbeef)  
  peek(dut.io.toHandshake.Cmd)
  peek(dut.io.toHandshake.Addr)
  peek(dut.io.toHandshake.Data)
  peek(dut.io.toMemoryRead.Cmd)
  peek(dut.io.toMemoryRead.Addr)
  peek(dut.io.toMemoryRead.Data)
}

object AddressDecoderTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new AddressDecoder())) {
        ad => new AddressDecoderTest(ad)
      }
  }
}
