
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


