package NOC.NIC_TEST


import Chisel._
import Node._
import patmos.Constants._
import io._
import ocp._

class NicTest(dut: top) extends Tester(dut){
  //first issue few commands from Processor to write to NIC
  for (i <- 0 to 5){
    poke(io.fromProcessor.M.Cmd, 0x1)
    poke(io.fromProcessor.M.Addr, 0xe801ffff)
    poke(io.fromProcessor.M.Data, i)
    poke(io.routerReadyOut, false)
    step(1)
    poke(io.routerReadyOut, false)
    peek(io.fromProcessor.S.Resp)
    step(1)
    poke(io.routerReadyOut, false)
    peek(io.fromProcessor.S.Resp)
    step(1)
    poke(io.routerReadyOut, true)
    peek(io.fromProcessor.S.Resp)
    step(1)
    peek(io.fromProcessor.S.Resp)
    step(1)
    peek(io.fromProcessor.S.Resp)
    step(1)
    peek(io.fromProcessor.S.Resp)
    step(1)
    peek(io.fromProcessor.S.Resp)
    step(1)
    peek(io.fromProcessor.S.Resp)
    step(1)
    peek(io.fromProcessor.S.Resp)
    step(1)
    peek(io.fromProcessor.S.Resp)
  }

  //now mix it a bit - send few commands to write to NIC and a few commands to local memory
  for (i <- 0 to 10){
    val addr = 0xe8000000
    val proc = i%
  }
  
  //now read the data from the memory since we should have something in there
  
}
