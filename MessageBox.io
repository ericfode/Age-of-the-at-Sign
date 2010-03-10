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
