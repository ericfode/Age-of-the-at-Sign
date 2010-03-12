
Curser := Object clone do(
     appendProto("Renderer")
     appendProto("Sentient")
     PosX:=10
     PosY:=10
     ///NEEDS TO BE SET OUT SIDE OF THE CLASSS
     MaxX:= 200
     MaxY := 200
     init := method(
	  MaxX =200
	  MaxY =200
	  PosX =10
	  PosY =10
     )
     symbol := "X"
     Render := method(
	  Curses writeCharacter(symbol at(0))
     )
     MoveUp := method(
	  if(PosY>0,
	  PosY = PosY-1)
     )
     MoveRight := method(
	  if(PosX<MaxX,
	  PosX = PosX+1
	  )
     )
     MoveLeft := method(
     	  if(PosX>0,
	  PosX = PosX-1)
     )
     MoveDown := method(
	  if(PosY<MaxY,
	  PosY = PosY+1
	  )
     )
)


