
Game := Object clone do(

     GameWorld := World clone
     GameWorld InitTiles(200,200)
     GameWorld GenerateTerrain
     GameCurser := Curser clone
     GameCurser PosX := 10
     GameCurser PosY := 10

     
     StartLoop:= method(
	  GameWorld AddObject(GameCurser)
	  GameInterface := Interface clone
	  GameInterface GameWorld = GameWorld
	  GameInterface GameCurser = GameCurser
	  loop(
	       GameInterface Display
	       System sleep(0.03)
	       GameInterface Update
	  )
     )
)