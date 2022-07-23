myShapes model = [ 
                 rectangle 200 130 |> filled lightBlue
                 ,
                 grid |> scale 2 |> move (-91, -30)
                 ,
                 circle 2 |> filled yellow 
                 |> case model.pos of
                   0 -> move (-85 ,-40)
                   1 -> move (-91,-30)
                   2 -> move (-81,-30)
                   3 -> move (-71,-30)
                   4 -> move (-61,-30)
                   5 -> move (-51,-30)
                   6 -> move (-41,-30)
                   7 -> move (-31,-30)
                   8 -> move (-21,-30)
                   9 -> move (-11,-30)
                   10 -> move (-1,-30)
                   11 -> move (-1,-20)
                   12 -> move (-11,-20)
                   13 -> move (-21,-20)
                   14 -> move (-31,-20)
                   15 -> move (-41,-20)
                   16 -> move (-51,-20)
                   17 -> move (-61,-20)
                   18 -> move (-71,-20)
                   19 -> move (-81,-20)
                   20 -> move (-91,-20)
                   21 -> move (-91,-10)
                   22 -> move (-81,-10)
                   23 -> move (-71,-10)
                   24 -> move (-61,-10)
                   25 -> move (-51,-10)
                   26 -> move (-41,-10)
                   27 -> move (-31,-10)
                   28 -> move (-21,-10)
                   29 -> move (-11,-10)
                   30 -> move (-1,-10)
                   31 -> move (-1,0)
                   32 -> move (-11,0)
                   33 -> move (-21,0)
                   34 -> move (-31,0)
                   35 -> move (-41,0)
                   36 -> move (-51,0)
                   37 -> move (-61,0)
                   38 -> move (-71,0)
                   39 -> move (-81,0)
                   40 -> move (-91,0)
                   41 -> move (-91,10)
                   42 -> move (-81,10)
                   43 -> move (-71,10)
                   44 -> move (-61,10)
                   45 -> move (-51,10)
                   46 -> move (-41,10)
                   47 -> move (-31,10)
                   48 -> move (-21,10)
                   49 -> move (-11,10)
                   50 -> move (-1,10)
                   51 -> move (-1,20)
                   52 -> move (-11,20)
                   53 -> move (-21,20)
                   54 -> move (-31,20)
                   55 -> move (-41,20)
                   56 -> move (-51,20)
                   57 -> move (-61,20)
                   58 -> move (-71,20)
                   59 -> move (-81,20)
                   60 -> move (-91,20)
                   61 -> move (-91,30)
                   62 -> move (-81,30)
                   63 -> move (-71,30)
                   64 -> move (-61,30)
                   65 -> move (-51,30)
                   66 -> move (-41,30)
                   67 -> move (-31,30)
                   68 -> move (-21,30)
                   69 -> move (-11,30)
                   70 -> move (-1,30)
                   71 -> move (-1,40)
                   72 -> move (-11,40)
                   73 -> move (-21,40)
                   74 -> move (-31,40)
                   75 -> move (-41,40)
                   76 -> move (-51,40)
                   77 -> move (-61,40)
                   78 -> move (-71,40)
                   79 -> move (-81,40)
                   80 -> move (-91,40)
                   81 -> move (-91,50)
                   82 -> move (-81,50)
                   83 -> move (-71,50)
                   84 -> move (-61,50)
                   85 -> move (-51,50)
                   86 -> move (-41,50)
                   87 -> move (-31,50)
                   88 -> move (-21,50)
                   89 -> move (-11,50)
                   90 -> move (-1,50)
                   91 -> move (-1,60)
                   92 -> move (-11,60)
                   93 -> move (-21,60)
                   94 -> move (-31,60)
                   95 -> move (-41,60)
                   96 -> move (-51,60)
                   97 -> move (-61,60)
                   98 -> move (-71,60)
                   99 -> move (-81,60)
                   100 -> move (-91,60)
                   otherwise -> move (model.x,model.y)
                 
                 ,
                 case model.gamestate of 
                   Question -> group [
                       button ToRolling "Right" green |> scale 0.5 |> move (60, 30)
                       ,
                       button ToRolling "Wrong" red |> scale 0.5 |> move (100, 30)
                       ]
                       
                   Rolling -> group [
                       button ToMoving "Roll" white |> scale 0.5 |> move (80, 30)
                       ,
                       square 20 |> filled white |> move (50, 0)
                       ]
                       
                   Moving -> group [
                      -- text ("You rolled a " ++ (Debug.toString model.roll)) |> filled black |> move (-80, -50)
                       square 20 |> filled white |> move (50, 0)
                       ,
                       text (Debug.toString model.roll) |> filled black |> move (47, -4)
                       ,
                       button ToSnakeOrLadder "Next" white |> scale 0.5 |> move (80, 30)
                       ,
                       text (Debug.toString model.pos) |> filled black |> move (40, 40)
                       ]
                       
                   SnakeOrLadder -> group [
                       button ToQuestion "Next" white |> scale 0.5 |> move (80, 30)
                       ,
                       if List.member model.pos [1,4,9,21,28,51,72,80] then text "You're on a ladder!" |> filled black |> move (-80, -50) else group []
                       ,
                       if List.member model.pos [17,54,62,64,87,93,95,98] then text "You're on a snake!" |> filled black |> move (-80, -50) else group []
                       ]
                       
                       
                 ,
                 if model.pos >= 100 then text "You Won" |> filled green else group []
                 ,
                 text (Debug.toString model.gamestate) |> filled black |> move (40, -50)
                 ]

mySquare = square 10
             |> filled pink
             |> makeTransparent 0.5  -- value between 0 and 1

myBackground = square 200 |> filled lightGreen

type Msg = Tick Float GetKeyState | ToRolling | ToMoving | ToSnakeOrLadder | ToQuestion

type GameState = Question | Rolling | Moving | SnakeOrLadder

update msg model = case msg of
                     Tick t _ -> 
                       { model | time = t }
                     
                     ToRolling -> 
                       { model | gamestate = Rolling }
                       
                     ToMoving ->
                       { model | roll = (modBy 6 (round model.time)) + 1, gamestate = Moving, pos = model.pos + (modBy 6 (round model.time) + 1) }
                     
                     ToSnakeOrLadder ->
                       { model | gamestate = SnakeOrLadder }
                       
                     ToQuestion ->
                       { model | gamestate = Question, pos = 
                       --snake transitions
                       (if model.pos == 17 then 7 else (
                       if model.pos == 54 then 34 else (
                       if model.pos == 62 then 19 else (
                       if model.pos == 64 then 60 else (
                       if model.pos == 87 then 36 else (
                       if model.pos == 93 then 73 else (
                       if model.pos == 95 then 75 else (
                       if model.pos == 98 then 79 else (
                       
                       --ladder tranitions
                       if model.pos == 1 then 38 else (
                       if model.pos == 4 then 14 else (
                       if model.pos == 9 then 31 else (
                       if model.pos == 21 then 42 else (
                       if model.pos == 28 then 84 else (
                       if model.pos == 51 then 67 else (
                       if model.pos == 72 then 91 else (
                       if model.pos == 80 then 99 else (
                       model.pos))))))))))))))))) }

init = { time = 0 , x = -85, y = -40, gamestate = Question , roll = 0 , pos = 0 }

spot colour = square 5 |> filled colour

row = group [
       spot black
       , spot white |> move (5,0)
       , spot black |> move (10,0)
       , spot white |> move (15,0)
       , spot black |> move (20,0)
       , spot white |> move (25,0)
       , spot black |> move (30,0)
       , spot white |> move (35,0)
       , spot black |> move (40,0)
       ]
       
grid = group [
       spot white
       , text "Start" |> filled red |> scale 0.2 |> move (-2.3,-1)
       , row |> move (5, 0)
       , row |> move (0, 5)
       , spot white |> move (45, 5)
       , row |> move (5, 10)
       , spot white |> move (0, 10)
       , row |> move (0, 15)
       , spot white |> move (45, 15)
       , row |> move (5, 20)
       , spot white |> move (0, 20)
       , row |> move (0, 25)
       , spot white |> move (45, 25)
       , row |> move (5, 30)
       , spot white |> move (0, 30)
       , row |> move (0, 35)
       , spot white |> move (45, 35)
       , row |> move (5, 40)
       , spot white |> move (0, 40)
       , row |> move (0, 45)
       , spot white |> move (45, 45)
       , text "Fin" |> filled white |> scale 0.2 |> move (-2, 44)
       
       --snakes
       , rect 12 1 |> filled lightGreen |> rotate (degrees 65) |> move (7, 40)
       , rect 10 1 |> filled lightGreen |> rotate (degrees 90) |> move (26, 40)
       , rect 27 1 |> filled lightGreen |> rotate (degrees 70) |> move (25, 27)
       , rect 10 1 |> filled lightGreen |> rotate (degrees 90) |> move (30, 20)
       , rect 10 1 |> filled lightGreen |> rotate (degrees 90) |> move (35, 40)
       , rect 25 1 |> filled lightGreen |> rotate (degrees 90) |> move (5, 18)
       , rect 15 1 |> filled lightGreen |> rotate (degrees -20) |> move (22, 2)
       , rect 15 1 |> filled lightGreen |> rotate (degrees 20) |> move (8, 27)
       
       --ladders
       , rect 12 1 |> filled lightBrown |> rotate (degrees 75) |> move (3, 40)
       , rect 12 1 |> filled lightBrown |> rotate (degrees 65) |> move (42, 41)
       , rect 15 1 |> filled lightBrown |> rotate (degrees 22) |> move (23, 1)
       , rect 15 1 |> filled lightBrown |> rotate (degrees 80) |> move (42, 8)
       , rect 15 1 |> filled lightBrown |> rotate (degrees 60) |> move (5, 8)
       , rect 10 1 |> filled lightBrown |> rotate (degrees 75) |> move (2.5, 15)
       , rect 15 1 |> filled lightBrown |> rotate (degrees -20) |> move (37, 27)
       , rect 35 1 |> filled lightBrown |> rotate (degrees -55) |> move (25, 25)
       
       --space numbers
       , text "5" |> filled red |> scale 0.2 |> move (18, 0)
       , text "10" |> filled red |> scale 0.2 |> move (43, 0)
       , text "15" |> filled red |> scale 0.2 |> move (23, 5)
       , text "20" |> filled red |> scale 0.2 |> move (-2, 5)
       , text "25" |> filled red |> scale 0.2 |> move (18, 10)
       , text "30" |> filled red |> scale 0.2 |> move (43, 10)
       , text "35" |> filled red |> scale 0.2 |> move (23, 15)
       , text "40" |> filled red |> scale 0.2 |> move (-2, 15)
       , text "45" |> filled red |> scale 0.2 |> move (18, 20)
       , text "50" |> filled red |> scale 0.2 |> move (43, 20)
       , text "55" |> filled red |> scale 0.2 |> move (23, 25)
       , text "60" |> filled red |> scale 0.2 |> move (-2, 25)
       , text "65" |> filled red |> scale 0.2 |> move (18, 30)
       , text "70" |> filled red |> scale 0.2 |> move (43, 30)
       , text "75" |> filled red |> scale 0.2 |> move (23, 35)
       , text "80" |> filled red |> scale 0.2 |> move (-2, 35)
       , text "85" |> filled red |> scale 0.2 |> move (18, 40)
       , text "90" |> filled red |> scale 0.2 |> move (43, 40)
       , text "95" |> filled red |> scale 0.2 |> move (23, 45)
       
       ]
       
button msg tex col = group [roundedRect 70 15 2
                          |> filled col
                      , text tex
                          |> filled black
                          |> scale 0.8
                          |> move (-30, -5)
                      ] |> move (-60, 0)
                        |> notifyTap msg
