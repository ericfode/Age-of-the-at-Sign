World := Renderer clone do(
     WorldData := List clone
     init := method(
	  WorldData = List clone
     )
     SizeX := 0
     SizeY := 0
     
     Renderables := List clone
     
     RenderRenderables := method(topX,topY,lowerX,lowerY,
	  origX:= Curses x
	  origY:= Curses y
	  Renderables foreach(index,item,
	       if( item isKindOf("Renderer") and item isKindOf("Sentient"),
		    if(
			 (item PosX >= lowerX) and
			 (item PosX <= topX) and
			 (item PosY >= lowerY) and 
			 (item PosY <= topY),
			 Curses move(origX+(item PosX-lowerX),origY+(item PosY-lowerY))
			 item Render
		    )
	       )
	  )
     )
	  
     
     InitTiles := method(SizeXin,SizeYin,
	  Curses write("initiaing base tile set \n")
	  Curses refresh
	  SizeX = SizeXin
	  SizeY = SizeYin
	  for(indexY,0,SizeY,
	       WorldData append(List clone)
	       for(indexX,0, SizeX,
		    WorldData at(indexY) append(Tile clone)
	       )
	  )
     )
     //list 2 will overwrite list 1
     merge := method(list1, list2,
	  list2 foreach(index2X,item2X,
	       item2X foreach(index2Y,item2Y,
		    if(item2Y != 0,
			 list1 at(index2X) atPut(index2Y,item2Y)
		    )
	       )
	  )
     )
	  
     
     RenderTiles := method(topX, topY, lowerX, lowerY,
	  for(indexY, lowerY, topY,
	       for(indexX, lowerX, topX, 
		    WorldData at(indexY) at(indexX) Render
		//    Curses move(Curses x+1, Curses height)
	       )
	       Curses move(1,Curses y+1)
	  )  
     )
     
     Render := method(topX, topY, lowerX, lowerY,
	  if(topX> SizeX, topX = SizeX)
	  if(topY> SizeY, topY = SizeY)
	  if(lowerX<0,lowerX = 0)
	  if(lowerY<0,lowerY = 0)
	  origX:= Curses x
	  origY:= Curses y
	  RenderTiles(topX,topY,lowerX,lowerY)
	  Curses move(origX,origY)
	  RenderRenderables(topX,topY,lowerX,lowerY)
     )
     
     GenerateTerrain := method(
	  OG := ObjGen clone
	  OG InitObjGen(200,200)
	  toMerge := OG RunObjGen(8,2,5,4,Tree clone)
	  merge(WorldData,toMerge)
     )
     
     AddObject := method(Renderable,PosX,PosY,
	 Renderables append(Renderable)
     )
)