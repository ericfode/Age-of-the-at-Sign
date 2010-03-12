Tree := Renderer clone do(
     symbol := "T"
     Render := method(
	  Curses setForegroundGreen
	  Curses writeCharacter(symbol at(0))
	  Curses setForegroundBlack
     )
     wood := 100
     
     print := method(
	  symbol print
     )
)
