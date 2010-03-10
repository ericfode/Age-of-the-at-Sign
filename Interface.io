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