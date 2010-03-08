//goals
//make somthing to print the world
//make somthing to hold the world
//add things
import structs/Array
import lang/stdio

Object: abstract class {
 Render: abstract func
}

Tile: class extends Object{
     symbol : Char
     init: func(inSym : Char) { symbol = inSym}
     Render: func {symbol printf() }
}

World: class{
     WorldData : Array<Array<Object>>
     SizeX, SizeY: Int
     init: func( sizeX, sizeY : Float ) {
	  WorldData new(sizeX)
	  for(line in WorldData){
	       line new(sizeY)
	  }
	  SizeX = sizeX
	  SizeY = sizeY
	  fillWorld(Tile new('.'))
     }
     
     fillWorld: func(letter : Object){
	for(lineX in 0..SizeX){
	     for(lineY in 0..SizeY){
		    WorldData[lineX][lineY] = letter
	     }
	 }
     }
}

Point: class {
     X, Y : Float
}

Square: class {
     Top, Bottom : Point
}

Render
displayWorld: func(world:World, dim:Square){
     
}