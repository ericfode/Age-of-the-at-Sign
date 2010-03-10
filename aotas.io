//goals
//make somthing to print the world
//make somthing to hold the world
//add things
Curses do(
     begin
     clear
)

Renderer:= Object clone do(
     Render := method()
)

Updater := Object clone do(
     Update := method()
)

Player := Object clone do(
     appendProto("Renderer")
     symbol := "@"
     Render := method(
	  Curses write(symbol) 
     )
)

Tile := Renderer clone do(
     Objects := List clone
     init := method(
	  Objects = List clone
     )
     symbol := "."
     Render := method(if(Objects size == 0,
			 Curses writeCharacter(symbol at(0)),
			 for(counter, (Objects size),0,-1,
			      if(Objects at(counter) isKindOf("Renderer"),
				   Objects at(counter) Render
				   break,
				   continue
			      )
				 
			 )
		    )
     )
     AddObject := method(item, 
		 Objects append(item)
     )
     
)

World := Renderer clone do(
     WorldData := List clone
     init := method(
	  WorldData = List clone
     )
     SizeX := 0
     SizeY := 0
     
     InitTiles := method(SizeXin,SizeYin,
	  SizeY = SizeXin
	  SizeX = SizeYin
	  for(indexX,0,SizeX,
	       WorldData append(List clone)
	       for(indexY,0, SizeY,
		    WorldData at(indexX) append(Tile clone)
	       )
	  )
     )
     Render := method(topX, topY, lowerX, lowerY,
	  if(topX> SizeX, topX = SizeX)
	  if(topY> SizeY, topY = SizeY)
	  if(lowerX<0,lowerX = 0)
	  if(lowerY<0,lowerY = 0)
	  for(indexX,lowerX, topX,
	       for(indexY, topY,lowerY,-1,
		    WorldData at(indexX) at(indexY) Render
	       )
	       Curses move(0,Curses height+1)
	  )
     )
     AddObject := method(Renderable,PosX,PosY,
	  WorldData at(PosX) at(PosY) AddObject(Renderable)
     )
)
interface := Object clone do(
     initInterface = method(
	  for(i,0,100,
	       Curses move(i,0)
	       Curses write("-")
	       Curses move(i,30)
	       Curses write("-")
	       Curses move(i,40)
	       Curses write("-")
	       
	  )
	  
	  for(i,0,40,
	       Curses move(0,i)
	       Curses write("|")
	       Curses move(100,i)
	       Curses write("|")
	  )
     )
     RenderWorldFrame := method(world,
     
     
)
     
Game := Object clone do(
     GameWorld := World clone
     GameWorld InitTiles(200,200)
     GameWorld Render(20,20,0,0)
     Curses refresh
     GameWorld AddObject(Player clone, 10, 10)
     GameWorld Render(30,40,0,0)
)
