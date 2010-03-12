//First pass: at every squre add a random number then add a factor of that random number to all of the surrounding squres
//Second pass : at every square less then number LIMIT will be set to zero
//Third pass: at every squre with a number a tree will be added

ObjGen := Object clone do(
     xSize :=0
     ySize :=0
     
     map := List clone
     init := method(map = List clone)
     initMap := method(xSizeIn,ySizeIn,
	  for(indexX,0,xSizeIn,
	       map append(List clone)
	       for(indexY,0,ySizeIn,
		    map at(indexX) append(0)
	       )
	  )
	  xSize = xSizeIn
	  ySize = ySizeIn
     )
	  
     addNumberToSqr := method(number,dist,x,y,
	  for(indexX,x-dist,x+dist,
	       if(indexX < 0, indexX = 0)
	       if(indexX > xSize, indexX= xSize)
	       for(indexY,y-dist,y+dist,
		    if(indexY < 0, indexY = 0)
		    if(indexY > ySize, indexY= ySize)
		    map at(indexX) atPut(indexY,(number+ map at(indexX) at(indexY)) floor)
	       )
	  )
	  if(dist == 0
	       map at(x) atPut(y,(number+ map at(indexX) at(indexY))floor)
	  )
	  
     )
	
     print := method(
	  map foreach(indexX, itemX,
	       itemX foreach(indexY,itemY,
		    itemY print
		    " " print
		)
		"\n" print
	  )
     )
	       
     firstPass := method(factor,falloffDist,limit,
	  map foreach(indexX, itemX,
	       itemX foreach(indexY,itemY,
		    itemY = (itemY + Random value(0,10)) floor
		    if(itemY > limit,
			 for(dist,1,falloffDist,
			      Curses write("    on obj ")
			      Curses write((indexX*xSize+indexY) asSimpleString)
			      Curses write(" of ")
			      Curses write((xSize*ySize) asSimpleString)
			      Curses write("\n")
			      Curses refresh
			      Curses move(0,Curses y-1)
			      addNumberToSqr(itemY/(factor*dist),dist,indexX,indexY)
			 )
		    )
	       )
	  )
     )

     secondPass := method(limit, Obj,
 	  map foreach(indexX, itemX,
	       itemX foreach(indexY,itemY,
		    if(itemY < limit,
			 Curses write("   on obj ")
			 Curses write((indexX*xSize+indexY) asSimpleString)
			 Curses write(" of ")
			 Curses write((xSize*ySize) asSimpleString)
			 Curses write("\n")
			 Curses refresh
			 Curses move(0,Curses y-1)
			 map at(indexX) atPut(indexY,0),
			 map at(indexX) atPut(indexY,Obj clone)
		    )
	       )
	  )
     )


     InitObjGen := method(xSize,ySize,
	  initMap(xSize,ySize)
     )
     
     RunObjGen := method(factor,falloffDist,limit1,limit2,Obj,
	  Curses write("generating ObjSet\n")
	  Curses write("    on pass one\n")
	  Curses refresh
	  firstPass(factor,falloffDist,limit1)
	  Curses write("    on pass two\n")
	  Curses refresh
	  secondPass(limit2,Obj)
	  return map
     )
)
     
