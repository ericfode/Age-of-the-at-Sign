Tree := Renderer clone do(
     symbol := "T"
     Render := method(
	  Curses writeCharacter(symbol at(0))
     )
     wood := 100
     
     print := method(
	  symbol print
     )
)
