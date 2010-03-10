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

Sentient:= Object clone do(
     PosX:=0
     PoxY:=0
)

Updater := Object clone do(
     Update := method()
)

Curser := Object clone do(
     appendProto("Renderer")
     appendProto("Sentient")
     PosX:=10
     PosY:=10
     init := method(
	  PosX =10
	  PosY =10
     )
     symbol := "X"
     Render := method(
	  Curses writeCharacter(symbol at(0))
     )
     MoveUp := method(
	  PosY = PosY-1
     )
     MoveRight := method(
	  PosX = PosX+1
     )
     MoveLeft := method(
	  PosX = PosX-1
     )
     MoveDown := method(
	  PosY = PosY+1
     )
)

Tile := Renderer clone do(

     symbol := "."
     Render := method(
	  Curses writeCharacter(symbol at(0))
     )
)

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
	  SizeX = SizeXin
	  SizeY = SizeYin
	  for(indexY,0,SizeY,
	       WorldData append(List clone)
	       for(indexX,0, SizeX,
		    WorldData at(indexY) append(Tile clone)
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
     AddObject := method(Renderable,PosX,PosY,
	 Renderables append(Renderable)
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
     GameWorld:= World clone
     GameCurser := Curser clone
     MsgBox := MessageBox clone
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
     
     AddMessage := method(message,
	  MsgBox AddMessage(message)
     )
     
     RenderWorldFrame := method(	      
	 // MsgBox AddMessage("Rendering")
	  Curses move(1,1)
	  GameWorld Render(98,28,0,0)
     )
     
     RenderMsgBoxFrame := method(
	  Curses move(1,31)
	  MsgBox Render
     )
     
     Display := method(
	  RenderInterface
	  RenderWorldFrame
	  RenderMsgBoxFrame
	  Curses refresh
     )
     
     Update := method(
     
	  c := Curses asyncReadCharacter
	  if(c,
	       //esc
	       if(c== 27, Lobby exit)
	       
	       if(c== "a" at(0), AddMessage("Moving Left")
		    GameCurser MoveLeft)
	       if(c== "w" at(0), AddMessage("Moving Up")
		    GameCurser MoveUp)
	       if(c== "s" at(0), AddMessage("Moving Down")
		    GameCurser MoveDown)
	       if(c== "d" at(0), AddMessage("Moving Right")
		    GameCurser MoveRight)
	  )
	  Curses clear
     )
	       
     
)

   

Game := Object clone do(
     GameWorld := World clone
     GameWorld InitTiles(200,200)
     GameCurser := Curser clone
     GameCurser PosX := 10
     GameCurser PosY := 10
     
     GameWorld AddObject(GameCurser)
     GameInterface := Interface clone
     GameInterface GameWorld = GameWorld
     GameInterface GameCurser = GameCurser
     loop(
	  GameInterface Display
	  GameInterface Update
     )
)

