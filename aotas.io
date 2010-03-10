//goals
//make somthing to print the world
//make somthing to hold the world
//add things
Curses do(
     begin
     clear
)

Lobby exit := method(Curses end; System exit)

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
			 Curses writeCharafcter(symbol at(0)),
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
	  SizeX = SizeXin
	  SizeY = SizeYin
	  for(indexY,0,SizeY,
	       WorldData append(List clone)
	       for(indexX,0, SizeX,
		    WorldData at(indexY) append(Tile clone)
	       )
	  )
     )
     Render := method(topX, topY, lowerX, lowerY,
	  if(topX> SizeX, topX = SizeX)
	  if(topY> SizeY, topY = SizeY)
	  if(lowerX<0,lowerX = 0)
	  if(lowerY<0,lowerY = 0)
	  
	  for(indexY,topY, lowerY,
	       for(indexX, lowerX, upperX, 
		    WorldData at(indexY) at(indexX) Render
		    Curses write("!")
		//    Curses move(Curses x+1, Curses height)
	       )
	       Curses move(1,Curses y-1)
	  )
     )
     AddObject := method(Renderable,PosX,PosY,
	  WorldData at(PosX) at(PosY) AddObject(Renderable)
     )
)

MessageBox := Renderer clone do(
     Messages := List clone
     maxLen := 9
     
     Render := method(
	 startingX := Curses x
	 startingY := Curses y
	 Messages foreach(index, item,
	       if(index < maxLen,
		    Curses move(startingX,startingY+index)
		    Curses write(item asSimpleString)
	       )
	  )
     )
     
     AddMessage:= method(message,
	  Messages prepend(message)
     )
)

Interface := Object clone do(
     ViewportX:=100
     ViewportY:=40
     MessageBoxX:=98
     MessageBoxY:=9
     WorldBoxX:=98
     WorldBoxY:=28
     MsgBox := MessageBox clone
     GameWorld:= World clone
     GameWorld InitTiles(200,200)
     RenderInterface := method(
	  for(i,0,ViewportX,
	       Curses move(i,0)
	       Curses write("-")
	       Curses move(i,30)
	       Curses write("-")
	       Curses move(i,ViewportY)
	       Curses write("-")
	       
	  )
	  
	  for(i,0,ViewportY,
	       Curses move(0,i)
	       Curses write("|")
	       Curses move(ViewportX,i)
	       Curses write("|")
	  )

     )
     
     RenderWorldFrame := method()
     
     Display := method(
	  RenderInterface
	       MsgBox AddMessage("Rendering")
	       Curses move(1,1)
	       GameWorld Render(98,28,0,0)
	  Curses move(1,31)
	  MsgBox Render
	  Curses refresh
     )
     Update := method(
	  c := Curses asyncReadCharacter
	  if(c,
	       //esc
	       if(c== 27, Lobby exit)
	  )
	  Curses clear
     )
	       
     
)

   

Game := Object clone do(
     GameWorld := World clone
     GameWorld InitTiles(200,200)
     GameInterface := Interface clone
     loop(
	  GameInterface Display
	  GameInterface Update
	  System sleep(0.05)
     )
)

