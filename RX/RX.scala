package NOC.RX

import Chisel._

class RX() extends Module(){
	val io = IO(new Bundle{
		val packet = Input(UInt(width = 96))
		val valid = Input(Bool())
		val dataIn = Input(UInt(width = 32))
		val dataOut = Output(UInt(width = 32))
		val addr = Output(UInt(width = 16))
		val ready = Output(Bool())
		val en = Output(Bool())
	})//true == write

	io.ready := Bool(true)
	io.en := Bool(false)
	io.dataOut := UInt(0)
	io.addr := UInt(0)

	when(io.valid === Bool(true)){
		io.dataOut := io.packet(31, 0)
		io.addr := io.packet(63, 32)
		io.en := Bool(true)
	}

}


class RXTest(dut: RX) extends Tester(dut){
  //first write some data
  poke(dut.io.valid, true)
  poke(dut.io.packet, 0x1)
  peek(dut.io.dataOut)
  peek(dut.io.addr)
  peek(dut.io.en)
  step(1)

  poke(dut.io.valid, false)
  peek(dut.io.dataOut)
  peek(dut.io.addr)
  peek(dut.io.en)
  step(2)

  poke(dut.io.valid, true)
  poke(dut.io.packet, 0x2)
  peek(dut.io.dataOut)
  peek(dut.io.addr)
  peek(dut.io.en)
  step(1)

  poke(dut.io.valid, true)
  poke(dut.io.packet, 0x3)
  peek(dut.io.dataOut)
  peek(dut.io.addr)
  peek(dut.io.en)
  step(1)

  poke(dut.io.valid, true)
  poke(dut.io.packet, 0x4)
  peek(dut.io.dataOut)
  peek(dut.io.addr)
  peek(dut.io.en)
  step(1)

  poke(dut.io.valid, false)

}

object RXTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new RX())) {
        m => new RXTest(m)
      }
  }
}