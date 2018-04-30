package NOC.RX

import Chisel._
import NOC.RouterEmulator._

class RX() extends Module(){
	val io = IO(new Bundle{
		val packet = Input(UInt(width = 96))
		val valid = Input(Bool())
		val dataIn = Input(UInt(width = 32))
		val dataOut = Output(UInt(width = 32))
		val addr = Output(UInt(width = 16))
		val ready = Output(Bool())
		val readyIn = Input(Bool())
		val en = Output(Bool())
	})//true == write
	val unused_bits = Bits(0, 2)
	


	io.ready := io.readyIn
	io.en := Bool(false)
	io.dataOut := UInt(0)
	io.addr := UInt(0)

	when(io.valid === Bool(true)){
		io.dataOut := io.packet(31, 0)
		io.addr := Cat(unused_bits, io.packet(47, 34))
		io.en := Bool(true)
	}

}

class RXTop() extends Module(){
	val io = IO(new Bundle{
		val start = Input(Bool())
		val ready = Output(Bool())
		val dataOut = Output(UInt(width = 32))
		val addr = Output(UInt(width = 16))
		val en = Output(Bool())
		val dataIn = Output(UInt(width = 96))
		val validIn = Output(Bool())
	})
	//----------- Use this just for testing ---------------
	val rout = Module(new RouterEmulator())
	val rx = Module(new RX())
	val what = io.start

	rout.io.readyIn := rx.io.ready
	rout.io.start := what
	io.ready := rx.io.ready

	rx.io.valid := rout.io.validOut
	rx.io.packet := rout.io.packetOut
	io.dataOut := rx.io.dataOut
	io.addr := rx.io.addr
	io.en := rx.io.en

	//-----------------------------------------------------
}


class RXTest(dut: RXTop) extends Tester(dut){
  //first write some data
  poke(dut.io.start, true)
  peek(dut.io.dataOut)
  peek(dut.io.addr)
  peek(dut.io.en)
  step(1)

  poke(dut.io.start, false)
  peek(dut.io.dataOut)
  peek(dut.io.addr)
  peek(dut.io.en)
  step(2)

  poke(dut.io.start, true)
  peek(dut.io.dataOut)
  peek(dut.io.addr)
  peek(dut.io.en)
  step(1)

  peek(dut.io.dataOut)
  peek(dut.io.addr)
  peek(dut.io.en)
  step(1)

  poke(dut.io.start, false)
  peek(dut.io.dataOut)
  peek(dut.io.addr)
  peek(dut.io.en)
  step(1)

  poke(dut.io.start, true)
  peek(dut.io.dataOut)
  peek(dut.io.addr)
  peek(dut.io.en)
  step(1)

  poke(dut.io.start, false)

}

object RXTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new RXTop())) {
        m => new RXTest(m)
      }
  }
}
