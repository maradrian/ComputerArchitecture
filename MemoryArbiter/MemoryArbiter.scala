package NOC.MemoryArbiter

import Chisel._
import Node._
import patmos.Constants._


class MemoryArbiter() extends Module(){
	val io = IO(new Bundle{
		//From/to OCPMemoryRead
		val dataFromOcpMemoryRead = Input(UInt(width = 32))
		val addrFromOcpMemoryRead = Input(UInt(width = 16))
		val enableFromOcpMemoryRead = Input(UInt(width = 2)) //00-idle, 01-write, 10-read, 11-invalid
		val readyToOcpMemoryRead = Output(Bool())

		//From/to RX
		val dataFromRX = Input(UInt(width = 32))
		val addrFromRX = Input(UInt(width = 16))
		val enableFromRX = Input(Bool())
		val readyToRX = Output(Bool())

		//To Memory
		val dataToMemory = Output(UInt(width = 32))
		val addrToMemory = Output(UInt(width = 16))
		val enable = Output(Bool())
		
	})

	val fromRX :: fromOCPReadMemory :: Nil = Enum(UInt(), 2)
	val stateReg = Reg(init = fromOCPReadMemory)

	io.readyToOcpMemoryRead := Bool(false)
	io.readyToRX := Bool(false)
	io.dataToMemory := UInt(0, 32)
	io.addrToMemory := UInt(0, 16)
	io.enable := Bool(false)
	

	//Firstly checking OCPReadMemory
	when(stateReg === fromOCPReadMemory){
		when(io.enableFromOcpMemoryRead === UInt(1)){		//ReadMem Write
			io.readyToOcpMemoryRead := Bool(true)
			io.dataToMemory := io.dataFromOcpMemoryRead
			io.addrToMemory := io.addrFromOcpMemoryRead
			io.enable := Bool(true)			
			
			stateReg := fromRX
		}.elsewhen(io.enableFromOcpMemoryRead === UInt(2)){	//ReadMem Read
			io.readyToOcpMemoryRead := Bool(true)
			io.addrToMemory := io.addrFromOcpMemoryRead
			io.enable := Bool(false)

			stateReg := fromRX
		}.elsewhen(io.enableFromRX){				//RX write
			io.readyToRX := Bool(true)
			io.dataToMemory := io.dataFromRX
			io.addrToMemory := io.addrFromRX
			io.enable := Bool(true)
	
			stateReg := fromOCPReadMemory	
		}		
	}

	//Firstly checking RX
	when(stateReg === fromRX){
		when(io.enableFromRX){						//RX write
			io.readyToRX := Bool(true)	
			io.dataToMemory := io.dataFromRX
			io.addrToMemory := io.addrFromRX
			io.enable := Bool(true)

			stateReg := fromOCPReadMemory
		}.elsewhen(io.enableFromOcpMemoryRead === UInt(1)){		//ReadMem Write
			io.readyToOcpMemoryRead := Bool(true)
			io.dataToMemory := io.dataFromOcpMemoryRead
			io.addrToMemory := io.addrFromOcpMemoryRead
			io.enable := Bool(true)

			stateReg := fromRX
		}.elsewhen(io.enableFromOcpMemoryRead === UInt(2)){		//ReadMem Read
			io.readyToOcpMemoryRead := Bool(true)
			io.addrToMemory := io.addrFromOcpMemoryRead
			io.enable := Bool(false)

			stateReg := fromRX
		}		
	}
	   
}

class MemoryArbiterTest(dut: MemoryArbiter) extends Tester(dut){
	/**Both OCPMemoryRead and RX ready**/
  	poke(dut.io.dataFromOcpMemoryRead, 0xbadcaffe)
	poke(dut.io.addrFromOcpMemoryRead, 0xface) 	
	poke(dut.io.enableFromOcpMemoryRead, 1)		//write

  	poke(dut.io.dataFromRX, 0xdeadbabe)
	poke(dut.io.addrFromRX, 0xdeaf) 	
	poke(dut.io.enableFromRX, true)			//write

	peek(dut.io.readyToOcpMemoryRead)
  	peek(dut.io.readyToRX)
	
	//Memory - must see OCPMemoryRead data
	peek(dut.io.dataToMemory)
  	peek(dut.io.addrToMemory)
	peek(dut.io.enable)
  	step(1)

	/**Both OCPMemoryRead and RX ready**/
	poke(dut.io.dataFromOcpMemoryRead, 0xbadcaffe)
	poke(dut.io.addrFromOcpMemoryRead, 0xface) 	
	poke(dut.io.enableFromOcpMemoryRead, 1)		//write

  	poke(dut.io.dataFromRX, 0xdeadbabe)
	poke(dut.io.addrFromRX, 0xdeaf) 	
	poke(dut.io.enableFromRX, true)			//write

	peek(dut.io.readyToOcpMemoryRead)
  	peek(dut.io.readyToRX)
	
	//Memory - must see RX data
	peek(dut.io.dataToMemory)
  	peek(dut.io.addrToMemory)
	peek(dut.io.enable)
  	step(1)

	/**OCPMemoryRead read**/
	poke(dut.io.dataFromOcpMemoryRead, 0xbadcaffe)
	poke(dut.io.addrFromOcpMemoryRead, 0xface) 	
	poke(dut.io.enableFromOcpMemoryRead, 2)		//read

  	poke(dut.io.dataFromRX, 0xdeadbabe)
	poke(dut.io.addrFromRX, 0xdeaf) 	
	poke(dut.io.enableFromRX, true)			//write

	peek(dut.io.readyToOcpMemoryRead)
  	peek(dut.io.readyToRX)

	//Memory - must see OCPMemoryRead data and zeros for dataToMemory signal
	peek(dut.io.dataToMemory)
  	peek(dut.io.addrToMemory)
	peek(dut.io.enable)
  	step(1)

	/**Neither OCPMemoryRead nor RX ready**/
	poke(dut.io.dataFromOcpMemoryRead, 0xbadcaffe)
	poke(dut.io.addrFromOcpMemoryRead, 0xface) 	
	poke(dut.io.enableFromOcpMemoryRead, 0)	

	poke(dut.io.dataFromRX, 0xdeadbabe)
	poke(dut.io.addrFromRX, 0xdeaf) 	
	poke(dut.io.enableFromRX, false)

	peek(dut.io.readyToOcpMemoryRead)
  	peek(dut.io.readyToRX)			

	//Memory - must zeros
	peek(dut.io.dataToMemory)
  	peek(dut.io.addrToMemory)
	peek(dut.io.enable)
  	step(1)
}

object MemoryArbiterTest{
  def main(args: Array[String]): Unit = {
    chiselMainTest(Array("--genHarness", "--test", "--backend", "c",
      "--compile", "--vcd", "--targetDir", "generated"),
      () => Module(new MemoryArbiter())) {
        m => new MemoryArbiterTest(m)
      }
  }
}
