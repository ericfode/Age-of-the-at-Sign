Tile := Renderer clone do(

     symbol := "."
     Render := method(
	  Curses writeCharacter(symbol at(0))
     )
)
