//goals
//make somthing to print the world
//make somthing to hold the world
//add things
use structs/Array

World: class {
     WorldData : Array<Array<Char>>
     init: func( sizeX, sizeY : Float ) {
	  WorldData new(sizeX)
	  for(line in WorldData){
	       line new(sizeY)
	  }
     }
}

Point: class {
     X, Y : Float
}

Square: class {
     Top, Bottom : Point
}


displayWorld: func(world:World, dim:Square){
     
}