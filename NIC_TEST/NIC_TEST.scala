package NOC.NIC_TEST


import Chisel._
import Node._
import patmos.Constants._
import io._
import ocp._

import NOC.Top._

class NicTest(dut: Top) extends Tester(dut){
  //first issue few commands from Processor to write to NIC
  for (i <- 0 to 5){
    poke(dut.io.fromProcessor.M.Cmd, 0x1)
    poke(dut.io.fromProcessor.M.Addr, 0xe801ffff)
    poke(dut.io.fromProcessor.M.Data, i)
    poke(dut.io.routerReadyOut, false)
    step(1)
    poke(dut.io.fromProcessor.M.Cmd, 0x0)
    poke(dut.io.routerReadyOut, false)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    poke(dut.io.routerReadyOut, false)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    poke(dut.io.routerReadyOut, true)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)

    step(1)
    step(1)
  }

  var list = Array(0xe8000002,
	0xe8010002,
	0xe8020002,
	0xe8030002,
	0xe8040002,
	0xe8050002,
	0xe8060002,
	0xe8070002,
	0xe8080002,
	0xe8090002)
  //now mix it a bit - send few commands to write to NIC and a few commands to local memory
  for (i <- 0 to 9){
    val addr = list(i)
    poke(dut.io.fromProcessor.M.Cmd, 0x1)
    poke(dut.io.fromProcessor.M.Addr, addr)
    poke(dut.io.fromProcessor.M.Data, i+1)
    poke(dut.io.routerReadyOut, false)
    step(1)
    poke(dut.io.fromProcessor.M.Cmd, 0x0)
    poke(dut.io.routerReadyOut, false)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    poke(dut.io.routerReadyOut, false)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    poke(dut.io.routerReadyOut, true)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)
    step(1)
    peek(dut.io.fromProcessor.S.Resp)
    peek(dut.io.routerValidIn)

    step(1)
    step(1)
  }
  
  //now read the data from the memory since we should have something in there
  poke(dut.io.fromProcessor.M.Cmd, 0x2)
  poke(dut.io.fromProcessor.M.Addr, list(0))
  poke(dut.io.routerReadyOut, false)
  step(1)
  poke(dut.io.routerReadyOut, false)
  poke(dut.io.fromProcessor.M.Cmd, 0x0)
  peek(dut.io.fromProcessor.S.Resp)
  peek(dut.io.fromProcessor.S.Data)
  peek(dut.io.routerValidIn)
  step(1)
  poke(dut.io.routerReadyOut, false)
  peek(dut.io.fromProcessor.S.Resp)
  peek(dut.io.fromProcessor.S.Data)
  peek(dut.io.routerValidIn)
  step(1)
  poke(dut.io.routerReadyOut, true)
  peek(dut.io.fromProcessor.S.Resp)
  peek(dut.io.fromProcessor.S.Data)
  peek(dut.io.routerValidIn)
  step(1)
  peek(dut.io.fromProcessor.S.Resp)
  peek(dut.io.fromProcessor.S.Data)
  peek(dut.io.routerValidIn)
  step(1)
  step(1)
}

object NicTest{
def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new Top())) {
        nt => new NicTest(nt)
      }
  }
}
