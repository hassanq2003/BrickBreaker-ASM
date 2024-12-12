.386
.model flat, stdcall
.stack 4096
include Irvine32.inc  
include macros.inc
includelib Winmm.lib
.data
Print_brick PROTO, x:BYTE, y:BYTE, textcolor:DWORD
move PROTO, x:byte, y:byte, direction:byte
Check_Collision_LeveL_1_Row_3  PROTO, Level_Blocks: Ptr DWORD ,Ball_X :byte ,Ball_Y : byte
Check_Collision_LeveL_1_Row_2  PROTO, Level_Blocks: Ptr DWORD ,Ball_X :byte ,Ball_Y : byte
Check_Collision_LeveL_1_Row_1  PROTO, Level_Blocks: Ptr DWORD ,Ball_X :byte ,Ball_Y : byte
move_slider PROTO,lb:byte,rb:byte,sprite: ptr byte,sprited:ptr byte,size_:byte
remove_block PROTO,block_present:PTR DWORD,x :BYTE,y :BYTE
print_score PROTO,score:DWORD,x:BYTE,y:BYTE
print_num PROTO,xPos:BYTE,yPoS:BYTE
print_hearts PROTO,y:BYTE,health:DWORD
Gray_block PROTO,block_present:PTR DWORD,x_ :BYTE,y_ :BYTE
Special_Block PROTO Block_Index: byte,Block_Row:byte
print_information PROTO,POSITIONX:BYTE,POSITIONY:BYTE
Upon_One_Hit PROTO, x_: byte,y_:byte
reset PROTO,ad:PTR BYTE,blocks:DWORD,to_replace:DWORD
reset_3 PROTO,ad:PTR BYTE,blocks:DWORD,to_replace:DWORD
Slider_Collision PROTO,siz_:byte

PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD

deviceConnect BYTE "DeviceDisconnect",0
click byte "press_click.wav",0
starting_ byte "starting.wav",0
lost_ byte "game_level_completed.wav",0
breaking byte "breaking.wav",0
;------------------ Scoring ----------------

paused DWORD 0


buffer byte 200 dup(0ah),0    ; Buffer to hold file data
filename byte "topscores.txt", 0 ; File name (null-terminated string)
filehandle DWORD 0           ; Variable to store the file handle
buffer2 Byte 20 dup(" ")

bytes_ DWORD 0
Demi_string byte 19 DUP (' '),0ah,0
Name_ byte 16 Dup (' '),0
Score_ DWORD  0
pscore_ DWORD 0
ten_score DWORD 0
Level_ byte 0



print_score PROTO,score:DWORD,x:BYTE,y:BYTE
print_num PROTO,Num_X:BYTE,Num_Y:BYTE
one byte "  .   ",0
    byte "  |   ",0
    byte "  |   ",0
    byte "  |   ",0
    byte "  |   ",0
    byte "  |   ",0
    byte "  '   ",0


two byte " ---- ",0
    byte "     |",0
    byte "     |",0
    byte " ---- ",0
    byte "|     ",0
    byte "|     ",0
    byte " ---- ",0


thr byte " ---- ",0
    byte "     |",0
    byte "     |",0
    byte " ---- ",0
    byte "     |",0
    byte "     |",0
    byte " ---- ",0

fur byte ".    .",0
    byte "|    |",0
    byte "|    |",0
    byte "'----|",0
    byte "     |",0
    byte "     |",0
    byte "     '",0

fiv byte " ---- ",0
    byte "|     ",0
    byte "|     ",0
    byte " ---- ",0
    byte "     |",0
    byte "     |",0
    byte " ---- ",0

six byte " ---- ",0
    byte "|     ",0
    byte "|     ",0
    byte "|---- ",0
    byte "|    |",0
    byte "|    |",0
    byte " ---- ",0

sev byte " ---- ",0
    byte "     |",0
    byte "     |",0
    byte " ----|",0
    byte "     |",0
    byte "     |",0
    byte "     '",0

eig byte ".----.",0
    byte "|    |",0
    byte "|    |",0
    byte "|----|",0
    byte "|    |",0
    byte "|    |",0
    byte "'----'",0

nin byte " ---- ",0
    byte "|    |",0
    byte "|    |",0
    byte " ----|",0
    byte "     |",0
    byte "     |",0
    byte "     '",0

zer byte " ---- ",0
    byte "|    |",0
    byte "|    |",0
    byte "|    |",0
    byte "|    |",0
    byte "|    |",0
    byte " ---- ",0

;-------------------------- Hearts for life -----------------------------------------
three_health byte " *** ***    *** ***    *** ***    ",0ah
             byte "*********  *********  *********   ",0ah
             byte "*********  *********  *********   ",0ah
             byte " *******    *******    *******    ",0ah
             byte "   ***        ***        ***      ",0ah
             byte "    *          *          *       ",0ah,0

two_health   byte " *** ***    *** ***               ",0ah
             byte "*********  *********              ",0ah
             byte "*********  *********              ",0ah
             byte " *******    *******               ",0ah
             byte "   ***        ***                 ",0ah
             byte "    *          *                  ",0ah,0 

one_health   byte " *** ***                          ",0ah
             byte "*********                         ",0ah
             byte "*********                         ",0ah
             byte " *******                          ",0ah
             byte "   ***                            ",0ah
             byte "    *                             ",0ah,0 

no_health    byte "                                  ",0ah
             byte "                                  ",0ah
             byte "                                  ",0ah
             byte "                                  ",0ah
             byte "                                  ",0ah
             byte "                                  ",0ah,0 




;-------------------------------------------------------------------------------------
           

title_1 byte"                             $$$$$$$\   $$$$$$$\   $$$$$$$$  $$$$$$$  $$ |   $$/                          ",13,10
      byte "                             $$  __$$\  $$  __$$\  \_$$  _| $$ ____   $$ |  $$/                           ",13,10
      byte "                             $$ |  $$ | $$ |  $$ |   $$ |   $$|       $$ | $$/                            ",13,10
      byte "                             $$$$$$$  | $$$$$$$  |   $$ |   $$|       $$$$$$/                             ",13,10
      byte "                             $$  __$$<  $$  __$$<    $$ |   $$|       $$  _$\                             ",13,10
      byte "                             $$ |  $$ | $$ |  $$ |   $$ |   $$|       $$ | \$\                            ",13,10
      byte "                             $$$$$$$$ | $$ |  $$ | $$$$$$\  $$$$$$$$  $$ |  \$\                           ",13,10
      byte "                             \______ /  \__|  \__| \______|  \______  \__|   \_\                          ",13,10
      byte "                                                                                                          ",13,10 
      byte "                                                                                                          ",13,10,0

title_2 byte "                    $$$$$$$\   $$$$$$$\   $$$$$$$$$ $$$$$$$$\  $$ |   $$/ $$$$$$$\  $$$$$$$\     ",13,10
      byte "                    $$  __$$\  $$  __$$\  $$  ____/ $$  ___$$\ $$ |  $$/  $$  ____/ $$  __$$\    ",13,10
      byte "                    $$ |  $$ | $$ |  $$ | $$ |      $$ |   $$| $$ | $$/   $$ |      $$ |  $$ |   ",13,10
      byte "                    $$$$$$$$ | $$$$$$$  | $$$$$$$$$ $$$$$$$$&| $$$$$$/    $$$$$$$$$ $$$$$$$  |   ",13,10
      byte "                    $$  __$$<  $$  __$$<  $$ |      $$  ___$$| $$  _$\    $$ |      $$  __$$<    ",13,10
      byte "                    $$ |  $$ | $$ |  $$ | $$ |      $$ |   $$| $$ | \$\   $$ |      $$ |  $$ |   ",13,10
      byte "                    $$$$$$$$ | $$ |  $$ | $$$$$$$$$ $$ |   $$| $$ |  \$\  $$$$$$$$$ $$ |  $$ |   ",13,10
      byte "                    \______ /  \__|  \__| \______ / \__|   \_| \__|   \_\ \______ / \__|  \__|   ",13,10,0
           

press_button byte "Press any button to continue.......",0



start_button byte "   ______    _______    _______     _______    _______                     ",0ah
		     byte "  |  ____|  |__   __|  |  ___  |   | ----- \  |__   __|                    ",0ah
			 byte "  | |____      | |     | |___| |   | |   / /     | |                       ",0ah
			 byte "  |_____ |     | |     |  ___  |   |  --- /      | |                       ",0ah
			 byte "       | |     | |     | |   | |   |  --- \      | |                       ",0ah
			 byte "   ____| |     | |     | |   | |   | |   \ \     | |                       ",0ah
			 byte "  |______|     |_|     |_|   |_|   |_|    \_\    |_|                       ",0ah,0

score_button byte "   ______     _______   ________    ______     _______                     ",0ah
			 byte "  |  ____|   / ______| |  ____  |  |  ___ \   | ______|                    ",0ah
			 byte "  | |____   | |        | |    | |  | |___| \  | |_____                     ",0ah
			 byte "  |_____ |  | |        | |    | |  |  __  /   | ______|                    ",0ah
			 byte "       | |  | |        | |    | |  | |  \ \   | |                          ",0ah
			 byte "   ____| |  | |______  | |____| |  | |   \ \  | |_____                     ",0ah
			 byte "  |______|   \_______| |________|  |_|    \_\ |_______|                    ",0ah,0

exit_button  byte "   _______    __     __   _________    _________                            ",0ah
		     byte "  | ______|   \ \   / /  |___   ___|  |___   ___|                              ",0ah
			 byte "  | |_____     \ \_/ /       | |          | |                                  ",0ah
			 byte "  | ______|     | _ |        | |          | |                                  ",0ah
			 byte "  | |          / / \ \       | |          | |                                  ",0ah
			 byte "  | |______   / /   \ \   ___| |___       | |                                  ",0ah
			 byte "  |_______|  /_/     \_\ |_________|      |_|                                  ",0ah,0


game_name    byte "BRICK BREAKER",0
made_by      byte "HASSAN QURESHI && MUHAMMAD IRFAN",0
roll_numbers byte "23i3029 && 23i3065",0

chosen byte 1



level1_ byte   "                   $$|       $$$$$$$$$ $$|      |$| $$$$$$$$$  $$|                     $$|",0ah
        byte   "                   $$|       $$  ____/ $$|      |$| $$  ____/  $$|                     $$|",0ah
        byte   "                   $$|       $$ |      $$|      |$| $$ |       $$|                     $$|",0ah 
        byte   "                   $$|       $$$$$$$$$  $$\     /$| $$$$$$$$$  $$|                     $$|",0ah
        byte   "                   $$|       $$ |        $$\   /$/  $$ |       $$|                     $$|",0ah
        byte   "                   $$|       $$ |         $$\_/$/   $$ |       $$|                     $$|",0ah
        byte   "                   $$$$$$$$$ $$$$$$$$$     $$$$/    $$$$$$$$$  $$$$$$$$$               $$|",0ah
        byte   "                    \_______ \______ /      \_/     \______ /   \_______               $$|",0ah
        byte   "                                                                          ",0ah,0

level2_ byte   "                  $$|       $$$$$$$$$ $$|      |$| $$$$$$$$$  $$|                  $$|  $$|",0ah
        byte   "                  $$|       $$  ____/ $$|      |$| $$  ____/  $$|                  $$|  $$|",0ah
        byte   "                  $$|       $$ |      $$|      |$| $$ |       $$|                  $$|  $$|",0ah
        byte   "                  $$|       $$$$$$$$$  $$\     /$| $$$$$$$$$  $$|                  $$|  $$|",0ah
        byte   "                  $$|       $$ |        $$\   /$/  $$ |       $$|                  $$|  $$|",0ah
        byte   "                  $$|       $$ |         $$\_/$/   $$ |       $$|                  $$|  $$|",0ah
        byte   "                  $$$$$$$$$ $$$$$$$$$     $$$$/    $$$$$$$$$  $$$$$$$$$            $$|  $$|",0ah
        byte   "                   \_______ \______ /      \_/     \______ /   \_______            $$|  $$|",0ah
        byte   "                                                                           ",0ah,0

level3_ byte   "                  $$|       $$$$$$$$$ $$|      |$| $$$$$$$$$  $$|               $$|  $$|  $$|",0ah
        byte   "                  $$|       $$  ____/ $$|      |$| $$  ____/  $$|               $$|  $$|  $$|",0ah
        byte   "                  $$|       $$ |      $$|      |$| $$ |       $$|               $$|  $$|  $$|",0ah
        byte   "                  $$|       $$$$$$$$$  $$\     /$| $$$$$$$$$  $$|               $$|  $$|  $$|",0ah
        byte   "                  $$|       $$ |        $$\   /$/  $$ |       $$|               $$|  $$|  $$|",0ah
        byte   "                  $$|       $$ |         $$\_/$/   $$ |       $$|               $$|  $$|  $$|",0ah
        byte   "                  $$$$$$$$$ $$$$$$$$$     $$$$/    $$$$$$$$$  $$$$$$$$$         $$|  $$|  $$|",0ah
        byte   "                   \_______ \______ /      \_/     \______ /   \_______         $$|  $$|  $$|",0ah,0



;-----------------------------------------------------------------------------------------------









won_  byte     "               \$$\      /$$/   $$$$$$$\    $$|     $$|         $$|         $$|   $$$$$$$\    $$ \      $$|",0ah
      byte     "                \$$\    /$$/   $$ |    $\   $$|     $$|         $$|         $$|  $$ |    $\   $$ $\     $$|",0ah
      byte     "                 \$$\__/$$/    $$ |    $$|  $$|     $$|         $$|         $$|  $$ |    $$|  $$ $$\    $$|",0ah
      byte     "                  \$$  $$/     $$ |    $$|  $$|     $$|         $$|   ___   $$|  $$ |    $$|  $$ |$$\   $$|",0ah
      byte     "                   \$$$$/      $$ |    $$|  $$|     $$|         $$|  /$$$\  $$|  $$ |    $$|  $$ | $$\  $$|",0ah
      byte     "                    |$$|       $$ |    $$|  $$|     $$|         $$|_/$$$$$\_$$|  $$ |    $$|  $$ |  $$\ $$|",0ah
      byte     "                    |$$|       $$ |    $$|  $$|     $$|         $$ $$ ___ $ $$|  $$ |    $$|  $$ |   $$\$$|",0ah
      byte     "                    |$$|       $$$$$$$$$/   $$$$$$$$$$|         $$$$ /   \ $$$|  $$$$$$$$$ /  $$ |    $ $$|",0ah
      byte     "                    |__|       \______ /     \_______/           \__/     \__/    \______ /   \__|     ___|",0ah,0


















    xChar byte "X", 0   ; The "X" we want to print
    space_line byte "                                    ",0
    Is_Colliding DWORD 0
    xPos byte 12   ; The x position of the "X"
    yPos byte 14 ; The y position of the "X"
    xVelocity byte 1
    yVelocity byte -1
    direction_ byte 2


    Health_ byte 3
    
    ; Temp variables here 
    Demi_ DWORD 0  ;for counting blocks in Special function 
    Checker_ DWORD 0
    Block_ DWORD 0
    


 ;Boundaries Variable Level 1
 Right_Wall byte 69
 Left_Wall byte 0
 Upper_Wall byte 0
 Down_Wall byte 20


slider_speed DWORD 1000
slider_p byte  "____________",0
slider_pp byte "_________",0

Size_P byte lengthof slider_p
slider_pd byte "                               ",0
slider_pos byte 10
left_boundary byte 0
right_boundary byte 70

; Define variables here


;----------------------------------- Level 3 -----------------------------------------

Array_4 DWORD 50 DUP (0)
level3_blocks_present DWORD 3,3,3,3,3,3,3
                      DWORD 3,3,3,3,3,3,3
                      DWORD 3,3,3,3,3,3,3
                      DWORD 3,3,3,5,3,3,3
                      DWORD 4,3,3,3,3,3,4
                      DWORD 3,5,3,3,3,3,3
                  








Array_5 DWORD 50 DUP (0)

;--------------- Level 1 MAP ----------------------------------------
level1_row_1 DWORD 0,10,20,30,40,50,60
level1_row_2 DWORD 0,10,20,30,40,50,60
level1_row_3 DWORD 0,10,20,30,40,50,60


Array_ DWORD 50 DUP (0)


level1_blocks_present DWORD 1,1,1,1,1,1,1
					  DWORD 1,1,1,1,1,1,1
					  DWORD 1,1,1,1,1,1,1

Array_2 DWORD 50 DUP (0)

  ;----------------- Level 2 MAP -------------------------------------


level2_row_4 DWORD 0,10,20,30,40,50,60
level2_row_5 DWORD 0,10,20,30,40,50,60
level2_row_6 DWORD 0,10,20,30,40,50,60

level2_blocks_present DWORD 2,2,2,2,2,2,2
                      DWORD 2,2,2,2,2,2,2
                      DWORD 2,2,2,2,2,2,2
                      DWORD 2,2,2,2,2,2,2
                      DWORD 2,2,2,2,2,2,2
                      DWORD 2,2,2,2,2,2,2

Array_3 DWORD 50 DUP (0)



	
   ;---------------------------------------------------------------- Main Function ---------------------------------------------------------------------------------------------------
  

.code
main PROC



call starting_screen





;------------- Printing the name -----------------------------
mwrite"Name: "
mov eax,yellow+(black*16)
call settextcolor
mov edx,offset Name_
mov ecx,lengthof Name_
call readstring
mov dl,95
mov dh,1
call gotoxy
mov edx,offset Name_
call writestring


mov eax,white+(black*16)
call settextcolor

call instructions

invoke print_information,76,10
starting:
;call File_handling

call clrscr
mov score_,0
mov paused,0
mov xPos,12   ; The x position of the "X"
mov yPos,14 ; The y position of the "X"
mov slider_pos,10
mov health_,3
call start_menu
cmp chosen,1
je selecting_levels
cmp chosen,2
je highscores
cmp chosen,3
je end_

selecting_levels:
call choose_level

mov Level_,al
cmp al,1
je Level_1
cmp al,2
je Level_2
cmp al,3
je Level_3
highscores:
call clrscr
call Print_File
call readchar 

jmp starting


end_:
INVOKE PlaySound, OFFSET starting_, NULL, 0
ret

;------------------------------- LeveL 1 --------------------------------------------------------------------




Level_1:
invoke print_hearts,23,Health_
invoke print_score,Score_,90,3
mov eax,1


call print_level1


mov dl,0
mov dh,27
call Gotoxy




Repeat_:

mov paused,0
invoke Slider_Collision,lengthof slider_p

call Die_
cmp Health_,0
je Write_Score

Skip_:
mov ecx,9990000
Iterator_:
loop Iterator_
mov al,0
mov ecx,slider_speed
timer_:
INVOKE move_slider,left_boundary,right_boundary,offset slider_p,offset slider_pd,sizeof slider_p
loop timer_
INVOKE move, xPos, yPos, direction_
cmp paused,1
jne keep_going
keep_calling:
call readchar

cmp al,'q'
je Write_Score
cmp al,'p'
jne keep_calling
keep_going:
call Collision_Block_Up
call Collision_Block_Down
call Collision_Block_Right
call Collision_Block_Left


call Check_Winner_Level_1
cmp Checker_,1
je Display_Won


jmp Repeat_




Display_Won:
call you_won
mov Checker_,0


Write_Score:
invoke reset,offset level1_blocks_present,21,1
pushad
call File_handling
popad
mov eax,0

jmp starting









;----------------------------------- LeveL 2 -----------------------------------------------

Level_2:

call Print_Level_2
invoke print_hearts,23,Health_
invoke print_score,Score_,90,3
mov eax,1




mov dl,0
mov dh,27
call Gotoxy


Repeat_2:



cmp yPos,14
jle Skip_2


invoke Slider_Collision,lengthof slider_pp

call Die_

cmp Health_,0
je Write_Score_2


Skip_2:
mov ecx,9900000
Iterator_2:
loop Iterator_2
mov ecx,400
timer_2:
INVOKE move_slider,left_boundary,right_boundary,offset slider_pp,offset slider_pd,sizeof slider_pp
cmp paused,1
jne keep_going2
keep_calling2:
call readchar
cmp al,'q'
je Write_Score_2
cmp al,'p'
jne keep_calling2
keep_going2:
loop timer_2
INVOKE move, xPos, yPos, direction_
call Collision_Block_Left_2 
call Collision_Block_Right_2
call Collision_Block_Right_2
call Collision_Block_Down_2
call Collision_Block_Down_2
call Collision_Block_Up_2
call Collision_Block_Up_2


call Check_Winner_Level_2
cmp Checker_,1
je Display_Won_2
jmp Repeat_2

jmp starting

Display_Won_2:
call you_won
mov Checker_,0


Write_Score_2:
invoke reset,offset level2_blocks_present,42,2
call File_handling
jmp starting





;-------------------------------------------- Level 3 ----------------------------------------------------------------------------------



Level_3:
;----------------------------- Pre setters for level 2 -------------------------------------------
call Print_Level_2

invoke print_hearts,23,Health_
invoke print_score,Score_,90,3
mov eax,1



mov dl,0
mov dh,27
call Gotoxy


Repeat_3:




cmp yPos,14
jle Skip_3
invoke Slider_Collision,lengthof slider_pp

call Die_
cmp Health_,0
je Write_Score_3


Skip_3:
mov ecx,9900000
Iterator_3:
loop Iterator_3
mov ecx,300
timer_3:

INVOKE move_slider,left_boundary,right_boundary,offset slider_pp,offset slider_pd,sizeof slider_pp
cmp paused,1
jne keep_going3
keep_calling3:
call readchar

cmp al,'q'
je Write_Score_3
cmp al,'p'
jne keep_calling3
keep_going3:

loop timer_3
INVOKE move, xPos, yPos, direction_

call Collision_Block_Right_3
call Collision_Block_Left_3
call Collision_Block_Down_3
call Collision_Block_Up_3


call Check_Winner
cmp Checker_,1
je Display_Won_3

jmp Repeat_3
jmp starting

Display_Won_3:
call you_won
mov Checker_,0


Write_Score_3:
invoke reset_3,offset level3_blocks_present,42,3
call File_handling
jmp starting



jmp starting

ret
main ENDP

;------------------------------------------------------ Functions -----------------------------------------------------------------------------------------------


remove_block PROC,block_present:PTR DWORD,x :BYTE,y :BYTE


add Score_,10
invoke print_score,Score_,90,3


;setting block to zero
movzx eax,y
mov ebx,28
mul ebx
mov edx,eax

movzx eax,x
shl eax,2
add edx,eax



mov esi,block_present
add esi,edx
;setting block to destroyed
mov eax,0
mov [esi],eax


mov eax,black+(black*16)

call SetTextColor

mov al,x
mov bl,10
mul bl
mov dh,y
mov dl,al
call Gotoxy

mov ecx,10
mov al," "

iterator_:
call WriteChar
loop iterator_
mov eax,white+(black*16)
call setTextColor
ret
remove_block ENDP







Print_level1 PROC

call Print_level1_row1
call Print_level1_row2
call Print_level1_row3

ret
Print_level1 ENDP



Print_level1_row1 PROC
;print the first row of bricks
local temp:DWORD,color:DWORD
mov edi,offset level1_blocks_present
;move in red color
mov color,44h

mov ecx,7
mov temp,ecx
mov esi,offset level1_row_1

repeater_:



cmp color,44h
je red_colour
jmp yellow_colour

red_colour:
;change to yellow color
mov color, 34h
jmp continue_
yellow_colour:
;change to red color
mov color, 44h
jmp continue_


continue_:
mov eax,color
mov ecx,[esi]
mov edx,[edi]
cmp edx,0
je broken
INVOKE Print_brick ,cl, 0, eax
broken:
add edi,4
add esi,4
dec temp
cmp temp,0
jne repeater_



ret
Print_level1_row1 ENDP





Print_level1_row2 PROC

local temp:DWORD,color:DWORD
mov edi,offset level1_blocks_present
add edi,28
;move in yellow color
mov color,34h

mov ecx,7
mov temp,ecx
mov esi,offset level1_row_1
add esi,28

repeater_:



cmp color,yellow+(yellow*16)
je yellow_colour
jmp green_colour

yellow_colour:
;change to green color
mov color, 59h
jmp continue_
green_colour:
;change to yellow color on yellow background
mov edx,yellow+(yellow*16)
mov color,edx
jmp continue_


continue_:
mov eax,color
mov ecx,[esi]
mov edx,[edi]
cmp edx,0
je broken
INVOKE Print_brick ,cl, 1, eax
broken:
add edi,4
add esi,4
dec temp
cmp temp,0
jne repeater_



ret
Print_level1_row2 ENDP

Print_level1_row3 PROC
;print the first row of bricks
local temp:DWORD,color:DWORD
mov edi,offset level1_blocks_present
add edi,56
;move in yellow color
mov color,34h

mov ecx,7
mov temp,ecx
mov esi,offset level1_row_1
add esi,56

repeater_:



cmp color,green+(green*16)
je green_colour
jmp brown_colour

brown_colour:

mov color, green+(green*16)
jmp continue_
green_colour:

mov color,brown+(brown*16)
jmp continue_


continue_:
mov eax,color
mov ecx,[esi]
mov edx,[edi]
cmp edx,0
je broken
INVOKE Print_brick ,cl, 2, eax
broken:
add edi,4
add esi,4
dec temp
cmp temp,0
jne repeater_



ret
Print_level1_row3 ENDP

;a procedure that takes in x and y axis coordinates and prints a space at that location
Print_brick PROC, x:BYTE, y:BYTE, textcolor:DWORD
	local temp:DWORD
	
	mov ecx,10 ;counter
	mov temp, ecx
	
	mov eax,textcolor
    	call SetTextColor


	repeater_:
	;move in x and y coordinates
    		mov dl, x
    		mov dh, y
    		call GotoXY
			mov al,' '
    		call WriteChar
			inc x
			dec temp
			cmp temp,0
	jne repeater_
;RESET COLOR BACK TO NORMAL
;WHITE ON BLACKBACKGROUND
	mov eax,0Fh
    	call SetTextColor

ret
Print_brick ENDP


;---------------------- Ball Movement -------------------------------------------------------

remove_Previous_Position PROC, x:byte, y:byte
    ;this procedure prints space at given axis
    ;move axis to dl and dh
    ;dh shows the row
    ;dl shows the column
    mov dl, x
    mov dh, y
    
    call Gotoxy
    ;print space
    mov al, ' '
    call WriteChar
    ret
remove_Previous_Position ENDP

move_New_Position PROC,x:byte, y:byte
    ;this procedure print * at new position
    ;move axis to dl and dh
    mov dl, x
    mov dh, y
    call Gotoxy
    ;print *
    mov al, 'o'
    call WriteChar
    mov dl,0
    mov dh,0
    call Gotoxy
    ret
move_New_Position ENDP

;---------------- Move Function ---------------------

move PROC, x:byte, y:byte, direction:byte

INVOKE remove_Previous_Position,xPos,yPos
mov eax,green+(black*16)
call SetTextColor

call Collision_Wall_Left
call Collision_Wall_Right
call Collision_Wall_Above
; Collision_Wall_Below
mov al,xVelocity
mov bl,yVelocity
add xPos,al
add yPos,bl
INVOKE move_New_Position,xPos,yPos

end_fun:
mov eax,white+(black*16)
call SetTextColor
mov dl,0
mov dh,0
call Gotoxy

ret
move ENDP


;----------------------- Collision Wall left-----------------------------------

Collision_Wall_Left PROC
mov al,xVelocity
mov bl,xPos
cmp bl,0
jne end_fun
cmp al,-1
jne end_fun
mov xVelocity,1


end_fun:
ret
Collision_Wall_Left ENDP

;----------------------- Collision Wall Right-----------------------------------

Collision_Wall_Right PROC
mov al,xVelocity
mov bl,xPos
mov cl,Right_Wall
cmp bl,cl
jne end_fun
cmp al,1
jne end_fun
mov xVelocity,-1



end_fun:
ret
Collision_Wall_Right ENDP



;----------------------Collision Wall Below-------------------------------------

Collision_Wall_Below PROC
mov al,yVelocity
mov bl,yPos
mov cl,Down_Wall
cmp bl,cl
jne end_fun
cmp al,1
jne end_fun
mov yVelocity,-1



end_fun:
ret
Collision_Wall_Below ENDP



;----------------------Collision Wall Above-------------------------------------

Collision_Wall_Above PROC
mov al,yVelocity
mov bl,yPos

cmp bl,0
jne end_fun
cmp al,-1
jne end_fun
mov yVelocity,1



end_fun:
ret
Collision_Wall_Above ENDP


;------------------- Collision block left-------------------

Collision_Block_Left PROC
local X:byte ,Y:byte,Block_Row:byte ,Block_Index:byte

mov al,xVelocity
cmp al,-1
jne end_fun
mov al,yPos
mov Y,al
cmp yPos,2
jg end_fun
cmp yPos,0
jl end_fun


mov al,xPos
mov X,al

mov edx,0
dec X
mov bl,10
mov al,X
div bl

mov X,al
mov Block_Index,al


mov al,Y
mov Block_Row,al
mov bl,28
imul bl

mov Y,al

mov al,X
mov bl,4
imul bl
mov X,al

add Y,al
mov eax,0
mov al,Y

mov esi,offset level1_blocks_present
add esi,eax

mov ebx,[esi]
cmp ebx,0
je end_fun

mov eax,0
mov xVelocity,1
mov [esi],eax
Invoke remove_block,offset level1_blocks_present,Block_Index,Block_Row




end_fun:

ret

Collision_Block_Left ENDP


;------------------- Collision block Right -------------------

Collision_Block_Right PROC
local X:byte ,Y:byte,Block_Row:byte ,Block_Index:byte

mov al,xVelocity
cmp al,1
jne end_fun
mov al,yPos
mov Y,al
cmp yPos,2
jg end_fun
cmp yPos,0
jl end_fun


mov al,xPos
mov X,al

mov edx,0
inc X
mov bl,10
mov al,X
div bl

mov X,al
mov Block_Index,al


mov al,Y
mov Block_Row,al
mov bl,28
imul bl

mov Y,al

mov al,X
mov bl,4
imul bl
mov X,al

add Y,al
mov eax,0
mov al,Y

mov esi,offset level1_blocks_present
add esi,eax

mov ebx,[esi]
cmp ebx,0
je end_fun

mov eax,0
mov xVelocity,-1
mov [esi],eax
Invoke remove_block,offset level1_blocks_present,Block_Index,Block_Row




end_fun:

ret

Collision_Block_Right ENDP




;------------------- Collision block Upper -------------------

Collision_Block_Up PROC

local X:byte ,Y:byte,Block_Row:byte ,Block_Index:byte

mov al,yVelocity
cmp al,-1
jne end_fun
mov al,yPos
mov Y,al
cmp yPos,3
jg end_fun

cmp yPos,0
jle end_fun


mov al,xPos
mov X,al

mov edx,0

mov bl,10
mov al,X
div bl

mov X,al
mov Block_Index,al


mov al,yPos
dec al
mov Block_Row,al

mov bl,28
imul bl

mov Y,al

mov al,X
mov bl,4
imul bl
mov X,al

add Y,al
mov eax,0
mov al,Y

mov esi,offset level1_blocks_present
add esi,eax

mov ebx,[esi]
cmp ebx,0
je end_fun

mov eax,0
mov [esi],eax
mov yVelocity,1
Invoke remove_block,offset level1_blocks_present,Block_Index,Block_Row




end_fun:

ret

Collision_Block_Up ENDP




;------------------- Collision block Down-------------------

Collision_Block_Down PROC

local X:byte ,Y:byte,Block_Row:byte ,Block_Index:byte

mov al,yVelocity
cmp al,1
jne end_fun
mov al,yPos
mov Y,al
cmp yPos,3
jg end_fun



mov al,xPos
mov X,al

mov edx,0

mov bl,10
mov al,X
div bl

mov X,al
mov Block_Index,al


mov al,yPos
inc al 
mov Block_Row,al

mov bl,28
imul bl

mov Y,al

mov al,X
mov bl,4
imul bl
mov X,al

add Y,al
mov eax,0
mov al,Y

mov esi,offset level1_blocks_present
add esi,eax

mov ebx,[esi]
cmp ebx,0
je end_fun

mov eax,0

mov yVelocity,1
mov [esi],eax
Invoke remove_block,offset level1_blocks_present,Block_Index,Block_Row




end_fun:

ret

Collision_Block_Down ENDP



;------------------------- Slider Code -------------------------------------------


move_slider PROC,lb:byte,rb:byte,sprite: ptr byte,sprited:ptr byte,size_:byte

Call ReadKey

cmp al,'j'

je move_left
cmp al,'k'

je move_right
cmp al,'p'
jne kk
mov paused,1
kk:
jmp end_fun

move_right:
mov al,slider_pos
mov bl,rb

sub bl,size_
cmp al,bl
je end_fun
mov dh,20
mov dl,slider_pos
call Gotoxy
mov edx,sprited
call WriteString
inc slider_pos
jmp continue_



move_left:

cmp slider_pos,0
je end_fun
mov dh,20
mov dl,slider_pos
call Gotoxy
mov edx,sprited
call WriteString
dec slider_pos


continue_:
mov dh,20
mov dl,slider_pos
call Gotoxy
mov edx,sprite

call settextcolor
call WriteString

call settextcolor
mov edx,0
call Gotoxy


end_fun:
ret

move_slider ENDP

;------------------------------ Slider Collision -------------------------------------

Slider_Collision PROC,siz_:byte
local Size_:byte


cmp yPos,20
jne Finish_

mov al,siz_
sub al,1
mov bl,slider_pos

mov cl,bl
add cl,al


cmp yVelocity,1
jne Finish_

cmp xPos,bl
jl Finish_



cmp xPos,cl
jg Finish_


add bl,2
cmp xPos,bl
jle Diagonal_Left


sub cl,2
cmp xPos,cl
jge Diagonal_Right



mov yVelocity,-1
mov xVelocity,0

jmp Finish_

Diagonal_Left:
mov yVelocity,-1
mov xVelocity,-1
jmp Finish_


Diagonal_Right:
mov yVelocity,-1
mov xVelocity,1






Finish_:
ret



Slider_Collision ENDP

;----------------------- Death ---------------------------------

Die_ PROC

cmp yPos,21
jl _Finish_

dec Health_
INVOKE PlaySound, OFFSET breaking, NULL, 0
 invoke print_hearts,23,Health_


mov dl,xPos
mov dh,yPos
call gotoxy
mov al,' '
call WriteChar
mov dl,slider_pos
mov dh,20
call gotoxy
mov edx,offset slider_pd
call writestring
mov edx,0
call gotoxy
 mov slider_pos,30
 mov xPos,30
 mov yPos,6 
 mov  xVelocity,0
 mov yVelocity ,1
;mov slider_pos, 10



_Finish_:
ret 


Die_ ENDP 

;------------------------------ Scoring --------------------------



print_score PROC,score:DWORD,x:BYTE,y:BYTE
;score is present in score.it is max three digits seperate the numbers
mov eax,score
mov edx,0
mov ebx,100
div ebx

call choose_num
INVOKE print_num,x,y
add x,7
;extracting 10s
mov eax,score
mov edx,0
mov ebx,100
div ebx
mov eax,edx
mov edx,0
mov ebx,10
div ebx
call choose_num
INVOKE print_num,x,y
add x,7
;extracting 1s
mov eax,score
mov edx,0
mov ebx,10
div ebx
mov eax,edx
call choose_num
INVOKE print_num,x,y


ret 
print_score ENDP



choose_num PROC
;al already contains a number
;move address in edx
cmp al,1
je one_
cmp al,2
je two_
cmp al,3
je three_
cmp al,4
je four_
cmp al,5
je five_
cmp al,6
je six_
cmp al,7
je seven_
cmp al,8
je eight_
cmp al,9
je nine_
cmp al,0
je zero_
jmp end_fun
one_:
mov edx,offset one
jmp end_fun
two_:
mov edx,offset two
jmp end_fun
three_:
mov edx,offset thr
jmp end_fun
four_:
mov edx,offset fur
jmp end_fun
five_:
mov edx,offset fiv
jmp end_fun
six_:
mov edx,offset six
jmp end_fun
seven_:
mov edx,offset sev
jmp end_fun
eight_:
mov edx,offset eig
jmp end_fun
nine_:
mov edx,offset nin
jmp end_fun
zero_:
mov edx,offset zer
jmp end_fun
end_fun:
ret
choose_num ENDP



print_num PROC,Num_X:BYTE,Num_Y:BYTE



mov eax,green+(black*16)
call Settextcolor

mov ecx,edx
mov dl,Num_X
mov dh,Num_Y
call gotoxy
mov edx,ecx
call Writestring

add ecx,7
mov dl,Num_X
inc Num_Y
mov dh,Num_Y

call gotoxy
mov edx,ecx
call Writestring

add ecx,7
mov dl,Num_X
inc Num_Y
mov dh,Num_Y

call gotoxy
mov edx,ecx
call Writestring

add ecx,7
mov dl,Num_X
inc Num_Y
mov dh,Num_Y

call gotoxy
mov edx,ecx
call Writestring

add ecx,7
mov dl,Num_X
inc Num_Y
mov dh,Num_Y

call gotoxy
mov edx,ecx
call Writestring

add ecx,7
mov dl,Num_X
inc Num_Y
mov dh,Num_Y

call gotoxy
mov edx,ecx
call Writestring

add ecx,7
mov dl,Num_X
inc Num_Y
mov dh,Num_Y

call gotoxy
mov edx,ecx
call Writestring

mov eax,white+(black*16)
call Settextcolor
mov edx,0
call gotoxy



ret
print_num ENDP

;-------------------------------------- Printing lifes -------------------------------------


print_hearts PROC,y:BYTE,health:DWORD

cmp health,0 
je zero_
cmp health,1
je one_
cmp health,2
je two_
cmp health,3
je three_
mov eax,white+(black*16)
call settextcolor
ret

three_:
mov eax,red+(black*16)
    call settextcolor

mov edx,offset three_health
jmp end_fun
two_:
mov eax,lightblue+(black*16)
 call settextcolor
mov edx,offset two_health
jmp end_fun
one_:
mov eax,yellow+(black*16)
 call settextcolor
mov edx,offset one_health
jmp end_fun
zero_:
mov edx,offset no_health
jmp end_fun
end_fun:
mov ecx,edx

mov edx,0
mov dh,y
mov dl,0
call gotoxy
mov edx,ecx
call writestring
mov edx,0
call gotoxy
mov eax,white+(black*16)
call settextcolor
ret
print_hearts ENDP

;----------------------------------------------------------------------------- Level 2 ----------------------------------------------------------------------------------------------

Print_Level_2 PROC


call print_level1
call Print_level2_row4 
call Print_level2_row5
call Print_level2_row6



Print_Level_2 ENDP

Print_level2_row4 PROC
;print the first row of bricks
local temp:DWORD,color:DWORD
mov edi,offset level2_blocks_present
add edi,84
;move in red color
mov color,44h

mov ecx,7
mov temp,ecx
mov esi,offset level2_row_4

repeater_:



cmp color,44h
je red_colour
jmp yellow_colour

red_colour:
;change to yellow color
mov color, 34h
jmp continue_
yellow_colour:
;change to red color
mov color, 44h
jmp continue_


continue_:
mov eax,color
mov ecx,[esi]
mov edx,[edi]
cmp edx,0
je broken
INVOKE Print_brick ,cl, 3, eax
broken:
add edi,4
add esi,4
dec temp
cmp temp,0
jne repeater_



ret
Print_level2_row4 ENDP





Print_level2_row5 PROC

local temp:DWORD,color:DWORD
mov edi,offset level2_blocks_present
add edi,112
;move in yellow color
mov color,34h

mov ecx,7
mov temp,ecx
mov esi,offset level2_row_5


repeater_:



cmp color,yellow+(yellow*16)
je yellow_colour
jmp green_colour

yellow_colour:
;change to green color
mov color, 59h
jmp continue_
green_colour:
;change to yellow color on yellow background
mov edx,yellow+(yellow*16)
mov color,edx
jmp continue_


continue_:
mov eax,color
mov ecx,[esi]
mov edx,[edi]
cmp edx,0
je broken
INVOKE Print_brick ,cl, 4, eax
broken:
add edi,4
add esi,4
dec temp
cmp temp,0
jne repeater_



ret
Print_level2_row5 ENDP




Print_level2_row6 PROC

local temp:DWORD,color:DWORD
mov edi,offset level2_blocks_present
add edi,140
;move in yellow color
mov color,34h

mov ecx,7
mov temp,ecx
mov esi,offset level2_row_6


repeater_:




cmp color,red+(red*16)
je green_colour
jmp brown_colour

brown_colour:

mov color, red+(red*16)
jmp continue_
green_colour:

mov color,yellow+(yellow*16)
jmp continue_


continue_:
mov eax,color
mov ecx,[esi]
mov edx,[edi]
cmp edx,0
je broken
INVOKE Print_brick ,cl, 5, eax
broken:
add edi,4
add esi,4
dec temp
cmp temp,0
jne repeater_




ret
Print_level2_row6 ENDP






;------------------- Collision block left-------------------

Collision_Block_Left_2 PROC
local X:byte ,Y:byte,Block_Row:byte ,Block_Index:byte

mov al,xVelocity
cmp al,-1
jne end_fun
mov al,yPos
mov Y,al
cmp yPos,5
jg end_fun
cmp yPos,0
je end_fun


mov al,xPos
mov X,al

mov edx,0
dec X
mov bl,10
mov al,X
div bl

mov X,al
mov Block_Index,al


mov al,Y
mov Block_Row,al
mov bl,28
imul bl

mov Y,al

mov al,X
mov bl,4
imul bl
mov X,al

add Y,al
mov eax,0
mov al,Y

mov esi,offset level2_blocks_present
add esi,eax

mov ebx,[esi]
cmp ebx,0
je end_fun


cmp ebx,2
je Made_Gray
jmp Remove_



Made_Gray:
mov xVelocity,1
invoke Gray_block,offset level2_blocks_present,Block_Index,Block_Row
jmp end_fun

Remove_:
mov xVelocity,1
Invoke remove_block,offset level2_blocks_present,Block_Index,Block_Row




end_fun:

ret

Collision_Block_Left_2 ENDP


;------------------- Collision block Right -------------------

Collision_Block_Right_2 PROC
local X:byte ,Y:byte,Block_Row:byte ,Block_Index:byte

mov al,xVelocity
cmp al,1
jne end_fun
mov al,yPos
mov Y,al
cmp yPos,5
jg end_fun
cmp yPos,0
je end_fun


mov al,xPos
mov X,al

mov edx,0
inc X
mov bl,10
mov al,X
div bl

mov X,al
mov Block_Index,al


mov al,Y
mov Block_Row,al
mov bl,28
imul bl

mov Y,al

mov al,X
mov bl,4
imul bl
mov X,al

add Y,al
mov eax,0
mov al,Y

mov esi,offset level2_blocks_present
add esi,eax

mov ebx,[esi]

cmp ebx,0
je end_fun

cmp ebx,2
je Made_Gray
jmp Remove_



Made_Gray:
mov xVelocity,-1
invoke Gray_block,offset level2_blocks_present,Block_Index,Block_Row
jmp end_fun

Remove_:
mov xVelocity,-1
Invoke remove_block,offset level2_blocks_present,Block_Index,Block_Row



end_fun:

ret

Collision_Block_Right_2 ENDP

;------------------- Collision block Upper -------------------

Collision_Block_Up_2 PROC

local X:byte ,Y:byte,Block_Row:byte ,Block_Index:byte

mov al,yVelocity
cmp al,-1
jne end_fun
mov al,yPos
mov Y,al
cmp yPos,6
jg end_fun

cmp yPos,0
je end_fun


mov al,xPos
mov X,al

mov edx,0

mov bl,10
mov al,X
div bl

mov X,al
mov Block_Index,al


mov al,yPos
dec al
mov Block_Row,al

mov bl,28
imul bl

mov Y,al


mov al,X
mov bl,4
imul bl
mov X,al

add Y,al
mov eax,0
mov al,Y

mov esi,offset level2_blocks_present
add esi,eax

mov ebx,[esi]
cmp ebx,0
je end_fun


cmp ebx,2
je Made_Gray
jmp Remove_


Made_Gray:
mov yVelocity,1
invoke Gray_block,offset level2_blocks_present,Block_Index,Block_Row
jmp end_fun

Remove_:
mov yVelocity,1
Invoke remove_block,offset level2_blocks_present,Block_Index,Block_Row





end_fun:

ret

Collision_Block_Up_2 ENDP






;------------------- Collision block Down-------------------

Collision_Block_Down_2 PROC

local X:byte ,Y:byte,Block_Row:byte ,Block_Index:byte

mov al,yVelocity
cmp al,1
jne end_fun
mov al,yPos
mov Y,al
cmp yPos,6
jge end_fun



mov al,xPos
mov X,al

mov edx,0

mov bl,10
mov al,X
div bl

mov X,al
mov Block_Index,al


mov al,yPos
inc al
mov Block_Row,al

mov bl,28
imul bl

mov Y,al

mov al,X
mov bl,4
imul bl
mov X,al

add Y,al
mov eax,0
mov al,Y

mov esi,offset level2_blocks_present
add esi,eax

mov ebx,[esi]




cmp ebx,0
je end_fun

cmp ebx,2
je Made_Gray
jmp Remove_



Made_Gray:
mov yVelocity,-1
invoke Gray_block,offset level2_blocks_present,Block_Index,Block_Row
jmp end_fun

Remove_:
mov yVelocity,-1
Invoke remove_block,offset level2_blocks_present,Block_Index,Block_Row




end_fun:

ret

Collision_Block_Down_2 ENDP




;------------------------------- One hit Gray Block --------------------------------------------




Gray_block PROC,block_present:PTR DWORD,x_ :BYTE,y_ :BYTE


add Score_,5
invoke print_score,Score_,90,3


;setting block to zero
movzx eax,y_
mov ebx,28
mul ebx
mov edx,eax

movzx eax,x_
shl eax,2
add edx,eax



mov esi,block_present
add esi,edx
;setting block to destroyed
mov eax,1
mov [esi],eax


mov eax,white+(white*16)

call SetTextColor

mov al,x_
mov bl,10
mul bl
mov dh,y_
mov dl,al
call Gotoxy

mov ecx,10
mov al," "

iterator_:
call WriteChar
loop iterator_
mov eax,white+(black*16)
call setTextColor
ret
Gray_block ENDP



;---------------------------------------- Level 3 -----------------------------------------------------------------------

;---------------------- Remove  Random Blocks -----------------------------------------


;------------------------------- ------------------------------------------

Upon_One_Hit PROC, x_: byte,y_:byte

movzx eax,y_
mov ebx,28
mul ebx
mov edx,eax

movzx eax,x_
shl eax,2
add edx,eax




mov eax,blue+(blue*16)

call SetTextColor

mov al,x_
mov bl,10
mul bl
mov dh,y_
mov dl,al
call Gotoxy

mov ecx,10
mov al," "

iterator_:
call WriteChar
loop iterator_
mov eax,white+(black*16)
call setTextColor
ret



Upon_One_Hit ENDP
;------------------------------------------ Remove 5 blocks -------------------------------------------------------------

Special_Block PROC Block_Index: byte,Block_Row:byte
local X_:byte ,Y_:byte,Count_:DWORD ,Demi: DWORD 

mov Count_,0
Invoke remove_block,offset level3_blocks_present,Block_Index,Block_Row
call Check_Blocks_Destroying



Iterator_:

call Randomize
mov eax,5      ; for generating the random row              
call RandomRange 
mov Y_,al

mov eax,0
call Randomize
mov eax,7        ; for generating Random Column 
call RandomRange 
mov X_,al


                     ; generating the address for accessing 2D Array 
movzx eax,Y_
mov ebx,28
mul ebx
mov edx,eax

movzx eax,X_
shl eax,2
add edx,eax

mov esi,offset level3_blocks_present
add esi,edx
mov eax,[esi]
cmp eax,0
jg Remove_Block_

jmp Iterator_

Remove_Block_:
Invoke remove_block,offset level3_blocks_present,X_,Y_
add Count_,1
mov eax,Demi_
cmp Count_,eax
jl Iterator_


Finish_:
mov Demi_,0
ret 


Special_Block ENDP



;------------------------------------ Collisions -----------------------


;------------------- Collision block Upper -------------------

Collision_Block_Up_3 PROC

local X:byte ,Y:byte,Block_Row:byte ,Block_Index:byte

mov al,yVelocity
cmp al,-1
jne end_fun
mov al,yPos
mov Y,al
cmp yPos,6
jg end_fun

cmp yPos,0
jle end_fun


mov al,xPos
mov X,al

mov edx,0

mov bl,10
mov al,X
div bl

mov X,al
mov Block_Index,al


mov al,yPos
dec al
mov Block_Row,al

mov bl,28
imul bl

mov Y,al


mov al,X
mov bl,4
imul bl
mov X,al

add Y,al
mov eax,0
mov al,Y

mov esi,offset level3_blocks_present
add esi,eax

mov ebx,[esi]


cmp ebx,0
je end_fun


cmp ebx,5
je Special_


cmp ebx,4
je Fixed_


cmp ebx,3
je Adjust_

cmp ebx,2
je Made_Gray
jmp Remove_



Special_:
mov yVelocity,1
invoke Special_Block,Block_Index,Block_Row
jmp end_fun


Fixed_:
mov yVelocity,1
jmp end_fun


Adjust_:
mov yVelocity,1
dec ebx
mov [esi],ebx
invoke Upon_One_Hit,Block_Index,Block_Row
jmp end_fun

Made_Gray:
mov yVelocity,1
invoke Gray_block,offset level3_blocks_present,Block_Index,Block_Row
jmp end_fun

Remove_:
mov yVelocity,1
Invoke remove_block,offset level3_blocks_present,Block_Index,Block_Row


end_fun:

ret

Collision_Block_Up_3 ENDP




;------------------- Collision block Down-------------------

Collision_Block_Down_3 PROC

local X:byte ,Y:byte,Block_Row:byte ,Block_Index:byte



mov al,yVelocity
cmp al,1
jne end_fun
mov al,yPos
mov Y,al
cmp yPos,6
jge end_fun



mov al,xPos
mov X,al

mov edx,0

mov bl,10
mov al,X
div bl

mov X,al
mov Block_Index,al


mov al,yPos
inc al
mov Block_Row,al

mov bl,28
imul bl

mov Y,al

mov al,X
mov bl,4
imul bl
mov X,al

add Y,al
mov eax,0
mov al,Y

mov esi,offset level3_blocks_present
add esi,eax

mov ebx,[esi]




cmp ebx,0
je end_fun


cmp ebx,5
je Special_


cmp ebx,4
je Fixed_


cmp ebx,3
je Adjust_

cmp ebx,2
je Made_Gray
jmp Remove_



Special_:
mov yVelocity,-1
invoke Special_Block,Block_Index,Block_Row
jmp end_fun


Fixed_:
mov yVelocity,-1
jmp end_fun


Adjust_:
mov yVelocity,-1
dec ebx
mov [esi],ebx
invoke Upon_One_Hit,Block_Index,Block_Row
jmp end_fun

Made_Gray:
mov yVelocity,-1
invoke Gray_block,offset level3_blocks_present,Block_Index,Block_Row
jmp end_fun

Remove_:
mov yVelocity,-1
Invoke remove_block,offset level3_blocks_present,Block_Index,Block_Row


end_fun:

ret

Collision_Block_Down_3 ENDP




;------------------------------ Colllision Right --------------------------------------------------


Collision_Block_Right_3 PROC
local X:byte ,Y:byte,Block_Row:byte ,Block_Index:byte

mov al,xVelocity
cmp al,1
jne end_fun
mov al,yPos
mov Y,al
cmp yPos,5
jg end_fun
cmp yPos,0
je end_fun


mov al,xPos
mov X,al

mov edx,0
inc X
mov bl,10
mov al,X
div bl

mov X,al
mov Block_Index,al


mov al,Y
mov Block_Row,al
mov bl,28
imul bl

mov Y,al

mov al,X
mov bl,4
imul bl
mov X,al

add Y,al
mov eax,0
mov al,Y

mov esi,offset level3_blocks_present
add esi,eax

mov ebx,[esi]

cmp ebx,0
je end_fun



cmp ebx,5
je Special_


cmp ebx,4
je Fixed_


cmp ebx,3
je Adjust_

cmp ebx,2
je Made_Gray
jmp Remove_



Special_:
mov xVelocity,-1
invoke Special_Block,Block_Index,Block_Row
jmp end_fun


Fixed_:
mov xVelocity,-1
jmp end_fun


Adjust_:
mov xVelocity,-1
dec ebx
mov [esi],ebx
invoke Upon_One_Hit,Block_Index,Block_Row
jmp end_fun

Made_Gray:
mov xVelocity,-1
invoke Gray_block,offset level3_blocks_present,Block_Index,Block_Row
jmp end_fun

Remove_:
mov xVelocity,-1
Invoke remove_block,offset level3_blocks_present,Block_Index,Block_Row


end_fun:

ret

Collision_Block_Right_3 ENDP





























;------------------- Collision block left-------------------

Collision_Block_Left_3 PROC
local X:byte ,Y:byte,Block_Row:byte ,Block_Index:byte

mov al,xVelocity
cmp al,-1
jne end_fun
mov al,yPos
mov Y,al
cmp yPos,6
jge end_fun
cmp yPos,0
je end_fun


mov al,xPos
mov X,al

mov edx,0
dec X
mov bl,10
mov al,X
div bl

mov X,al
mov Block_Index,al


mov al,Y
mov Block_Row,al
mov bl,28
imul bl

mov Y,al

mov al,X
mov bl,4
imul bl
mov X,al

add Y,al
mov eax,0
mov al,Y

mov esi,offset level3_blocks_present
add esi,eax

mov ebx,[esi]
cmp ebx,0
je end_fun



cmp ebx,5
je Special_


cmp ebx,4
je Fixed_


cmp ebx,3
je Adjust_

cmp ebx,2
je Made_Gray
jmp Remove_



Special_:
mov xVelocity,1
invoke Special_Block,Block_Index,Block_Row
jmp end_fun


Fixed_:
mov xVelocity,1
jmp end_fun


Adjust_:
mov xVelocity,1
dec ebx
mov [esi],ebx
invoke Upon_One_Hit,Block_Index,Block_Row
jmp end_fun

Made_Gray:
mov xVelocity,1
invoke Gray_block,offset level3_blocks_present,Block_Index,Block_Row
jmp end_fun

Remove_:
mov xVelocity,1
Invoke remove_block,offset level3_blocks_present,Block_Index,Block_Row


end_fun:

ret

Collision_Block_Left_3 ENDP






;---------------------------------- Wining -----------------------------------------------------------

Check_Winner PROC 



mov esi,offset level3_blocks_present
mov eax,lengthof level3_blocks_present

mov ecx,6     ; For 7 rows 
imul ecx
mov ecx,eax


Outer_:

mov eax,[esi]

cmp eax,4                    ; Check if the unremovable block 
je Found_4


cmp eax,0                  ; zero means no block 
jne Not_Win


Re_:
add esi,4

loop Outer_



Win_:
mov Checker_,1
call you_won

jmp Finish_


Found_4:
jmp Re_


Not_Win:

mov Checker_,0


Finish_:
ret 
Check_Winner ENDP



;--------------------------------------------- Counting the removable blocks --------------------------------------------------------------------------

Check_Blocks_Destroying PROC,

mov eax,0
mov Demi_,eax


mov esi,offset level3_blocks_present
mov eax,lengthof level3_blocks_present

mov ecx,6    ; For 6 rows 
imul ecx
mov ecx,eax


Outer_:

mov eax,[esi]



cmp eax,0                  ; zero means no block 
jne Add_


Re_:
add esi,4
loop Outer_
jmp Finish_


Add_:
add Demi_,1
mov ebx,5
cmp Demi_,ebx
jge Finish_
jmp Re_


Finish_:
ret


Check_Blocks_Destroying ENDP





;-----------------------------------------------------------------------------------Menu screen handling-------------------------------------------------------------------------------


starting_screen PROC
call clrscr

mov dh,3
mov dl,0
call gotoxy
mov eax,yellow+(black*16)
call settextcolor


mov edx,offset title_1
call writestring

mov eax,green+(black*16)
call settextcolor


mov edx,offset title_2
call writestring

mov eax,cyan+(black*16)
call settextcolor

mov dl,37
mov dh,22
call gotoxy
mov edx,offset press_button
call writestring

mov eax,white+(black*16)
call settextcolor
INVOKE PlaySound, OFFSET starting_, NULL, 0
mov edx,0
call gotoxy
call readchar
call clrscr
ret
starting_screen ENDP

print_information PROC,POSITIONX:BYTE,POSITIONY:BYTE

mov dl,POSITIONX
add dl,9
mov dh,POSITIONY
call gotoxy
inc POSITIONY
mov edx,offset game_name
call writestring

mov dl,POSITIONX
mov dh,POSITIONY
call gotoxy
inc POSITIONY
mwrite "--------------------------------"

mov dl,POSITIONX
mov dh,POSITIONY
call gotoxy
inc POSITIONY
mov edx,offset made_by
call writestring
mov dl,POSITIONX
mov dh,POSITIONY
call gotoxy
inc POSITIONY
mwrite "--------------------------------"


mov dl,POSITIONX
mov dh,POSITIONY
add dl,7
call gotoxy
inc POSITIONY
mov edx,offset roll_numbers
call writestring
mov dl,POSITIONX
mov dh,POSITIONY
call gotoxy
inc POSITIONY
mwrite "--------------------------------"

mov edx,0
call gotoxy
ret
print_information ENDP

start_menu PROC

call print_menu
c_:

only_read:
call ReadChar


cmp al,'w'
je w
cmp al,'s'
je s
cmp al,'j'
je choose_
jmp only_read

w:
INVOKE PlaySound, OFFSET click, NULL, 0
cmp chosen,1
je only_read
dec chosen
call print_menu
jmp c_

s:
INVOKE PlaySound, OFFSET click, NULL, 0
cmp chosen,3
je only_read
inc chosen
call print_menu

jmp c_

choose_:
call clrscr

ret
start_menu ENDP



print_menu PROC

local start:byte,score:byte,ex:byte


mov edx,0
call gotoxy





mov start,yellow
mov score,yellow
mov ex,yellow
cmp chosen,1
je start_
cmp chosen,2
je score__
cmp chosen,3
je exit_

start_:
mov start,blue
jmp continue_
score__:
mov score,blue
jmp continue_
exit_:
mov ex,blue
jmp continue_


continue_:

movzx eax,start
call settextcolor
mov al,0ah
call writechar
mov al,0ah
call writechar


mov edx,offset start_button
call writestring
mov al,0ah
call writechar

mov al,0ah
call writechar
movzx eax,score
call settextcolor
mov edx,offset score_button
call writestring
mov al,0ah
call writechar
mov al,0ah
call writechar

movzx eax,ex
call settextcolor
mov edx,offset exit_button
call writestring

mov eax,white+(black*16)
call settextcolor
ret
print_menu ENDP


;---------------------------------------------------select level-----------------------------------------------
choose_level PROC


call clrscr

mov al,0ah
call writechar
mov eax,brown+(black*16)
call settextcolor
mov edx,offset level1_
call writestring

mov eax,green+(black*16)
call settextcolor
mov edx,offset level2_
call writestring


mov eax,blue+(black*16)
call settextcolor
mov edx,offset level3_
call writestring

mov eax,white+(black*16)
call settextcolor

iterator:

call readChar

cmp al,'1'
je end_fun
cmp al,'2'
je end_fun
cmp al,'3'
je end_fun


jmp iterator

end_fun:
sub al,'1'
add al,1
call clrscr
ret
choose_level ENDP



;------------------------------------------------------how to play the game
instructions PROC





;skip line
call crlf
call crlf
mwrite"-------------------------------------------------------INSTRUCTIONS-----------------------------------------------------"
call crlf
call crlf
call crlf
;--------------
mov eax,red+(black*16)
call settextcolor
mwrite"           In the Brickbreaker game, your goal is to destroy all the bricks on the screen by bouncing a ball off a "
call crlf
mwrite"                                                    slider you control."
call crlf
mov eax,brown+(black*16)
call settextcolor
call crlf
call crlf
mwrite"                                           -> In Level 1, bricks need one hit."
call crlf
mov eax,blue+(black*16)
call settextcolor
mwrite"                                           -> In Level 2, bricks need two hits."
call crlf
mov eax,yellow+(black*16)
call settextcolor
mwrite"                                           -> In Level 3, bricks need three hits."
call crlf
mov eax,cyan+(black*16)
call settextcolor
mwrite"                                          Special bricks destroy 5 random bricks."

call crlf
call crlf
call crlf
call crlf
call crlf
mov eax,green+(black*16)
call settextcolor
mwrite"                                           ________________Controls______________"
call crlf
mwrite"                                              Press J and K to move the slider."

call crlf

call crlf

call crlf
mov eax,brown+(black*16)
call settextcolor
mwrite"                                                         Go Back(B)              "
mov eax,white+(black*16)
call settextcolor

iterator:
call readchar
cmp al,'b'
je end_fun


jmp iterator

end_fun:
call clrscr
ret
instructions ENDP



;-------------------------------------------------------------------winning menu
you_won PROC
call clrscr

mov dh,9
mov dl,0
call gotoxy

mov eax,yellow+(black*16)
call settextcolor

MOV edx,offset won_
call writestring

call readchar
call clrscr
ret
you_won ENDP


;---------------------------------- Wining -----------------------------------------------------------

Check_Winner_Level_1 PROC 



mov esi,offset level1_blocks_present
mov eax,lengthof level1_blocks_present

mov ecx,3    ; For 3 rows 
imul ecx
mov ecx,eax


Outer_:

mov eax,[esi]

cmp eax,0                  ; zero means no block 
jne Not_Win
add esi,4
loop Outer_



Win_:
mov Checker_,1

jmp Finish_



Not_Win:
mov Checker_,0


Finish_:
ret 
Check_Winner_Level_1 ENDP

Check_Winner_Level_2 PROC 



mov esi,offset level2_blocks_present
mov eax,lengthof level2_blocks_present

mov ecx,6    ; For 6 rows 
imul ecx
mov ecx,eax


Outer_:

mov eax,[esi]

cmp eax,0                  ; zero means no block 
jne Not_Win
add esi,4
loop Outer_



Win_:
mov Checker_,1

jmp Finish_



Not_Win:
mov Checker_,0


Finish_:
ret 
Check_Winner_Level_2 ENDP

;----------------------------------------------------------------------------------------------- File Handling --------------------------------------------------------------------

;----------------------------------------------------------------------------------------------- File Handling --------------------------------------------------------------------

File_handling PROC

call Read_File 
  
    call crlf 



    mov eax,Score_
   
    mov pscore_,eax
    call Build_string 

    mov eax,0
    mov esi,offset buffer
    add esi,198
    mov al,[esi]
    sub al,48
    add ten_score,eax

    mov eax,0
    dec esi
    mov al,[esi]
    sub al,48
    mov ebx,10
    mul ebx
    add ten_score,eax

    mov eax,0
    dec esi
    mov al,[esi]
    sub al,48
    mov ebx,100
    mul ebx
    add ten_score,eax

    mov eax,pscore_
    cmp eax,ten_score
    jle dont
   


    mov eax,180

    mov edi,offset buffer
    add edi,eax

    mov esi,offset Demi_string
    mov ecx,20
    rep movsb

    call sort_strings  
   call Write_File
 
    dont:
       

    ; call Print_Score



ret
File_handling ENDP


sort_strings PROC
;declare local variable to store results
local sa:DWORD,tsa:DWORD,innerloop:DWORD,outerloop:DWORD
mov sa,offset buffer
mov innerloop,10
mov outerloop,10

outerloop_:
mov edx,sa
mov tsa,offset buffer
mov innerloop,10
innerloop_:
mov esi,edx
add esi,16
call converttoNumber
;convert to number
mov ebx,eax;put result in ebx
mov esi,tsa
add esi,16
call converttoNumber
;convert to number
;put result in eax
cmp eax,ebx
jg continue_
pushad
mov ecx,19
mov esi,tsa
mov edi,offset buffer2
;set direction from lower to higher
cld
rep movsb 

mov ecx,19
mov esi,edx
mov edi,tsa
cld 
rep movsb

mov ecx,19
mov esi,offset buffer2
mov edi,edx
cld 
rep movsb

popad



continue_:
add tsa,20
dec innerloop
cmp innerloop,0
jne innerloop_

dec outerloop
cmp outerloop,0
je end_
add sa,20
jmp outerloop_



end_:
ret
sort_strings ENDP

converttoNumber PROC
local temp:DWORD
pushad
;esi contains character 1 of 123
mov edi,esi
inc edi
mov ecx,edi
inc ecx
;esi contains 1 edi contains 2 ecx contains 3
mov eax,0
mov al,[esi]
sub al,48
mov ebx,100
mul ebx
mov temp,eax

mov eax,0
mov al,[edi]
sub al,48
mov ebx,10
mul ebx
add temp,eax

mov eax,0
mov al,[ecx]
sub al,48
add temp,eax

popad
mov eax,temp
ret
converttoNumber ENDP





Read_File PROC

; Open the input file (filename) for reading
    mov edx, offset filename
    call OpeninputFile  ; Open the file for reading
    mov filehandle, eax  ; Store the returned file handle


    ; Read the file into the buffer
    mov edx, offset buffer  ; Load buffer address
    
    mov ecx,200
        
    mov edx, offset buffer; Maximum number of bytes to read
    mov eax, filehandle     ; Load the file handle
    call ReadfromFile           ; Read data from the file into the buffer
  
  
    mov eax,filehandle
    ; Close the file
    call CloseFile  


    ret 

Read_File ENDP




Write_File PROC



;-------------- Writing into file ---------------




Write_:

     


mov edx,offset filename
call createoutputfile
mov filehandle,eax



mov edx,offset filename
mov eax,filehandle
call openinputfile



 mov ecx,200    
    mov edx, offset buffer


mov eax,filehandle
call writetofile
mov eax,filehandle
mov edx,offset filename
call closefile


ret 

Write_File ENDP



;------------------------------------------------------------------ Printing the High Scores  ---------------------------------------------------------------------------------

Print_File PROC


call File_handling
mwrite "Names         L Score "
call crlf
mov esi,offset buffer
mov ecx,200




Inner_:

mov al,[esi]
inc esi 
call writechar
loop Inner_


Finish_:
ret 


Print_File ENDP




;--------------------------------------------------------------- Making the string ----------------------------------------------------------------

Build_String PROC

local Demi_Score:DWORD
mov eax,Score_
mov Demi_Score,eax



cld 
mov edi,offset Demi_string
mov esi,offset Name_

Assign_:
mov al,[esi]
cmp al,0
je Move_Ahead_

mov [edi],al
inc esi
inc edi

jmp Assign_

Move_Ahead_:
mov edi,offset Demi_string
add edi,13

inc edi
mov al,Level_
add al,48
mov [edi],al
 
inc edi
mov al,' '
mov [edi],al
 
inc edi




mov eax,Score_


;--------------------------------------------------- Converting Score into string ----------------------------------------------------------

mov ecx,3
mov ebx,100

Iterate_:
mov eax,Demi_Score
mov edx,0
idiv ebx
add al,48   
mov [edi],al
inc edi 
sub al,48
imul ebx

sub Demi_Score,eax
mov eax,ebx
mov ebx,10
mov edx,0
idiv ebx 
mov ebx,eax

loop Iterate_


ret 

Build_String ENDP
;

;


;--------------------------------------------------------------------------- Restting the arrays --------------------------------------


reset PROC,ad:PTR BYTE,blocks:DWORD,to_replace:DWORD
mov eax,to_replace
mov ecx,blocks
mov esi,ad
reset_loop:
mov [esi],eax
add esi,4
loop reset_loop
ret
reset ENDP


reset_3 PROC,ad:PTR byte,blocks:DWORD,to_replace:DWORD
mov eax,to_replace
mov ecx,blocks
mov esi,ad
reset_loop:
mov [esi],eax
add esi,4
loop reset_loop

;-------------------------------------------------------------------------------------
mov esi,ad
add esi,140
mov eax,4
mov [esi],eax
add esi,4
mov eax,5
mov [esi],eax
mov eax,4
add esi,8
mov [esi],eax

ret
reset_3 ENDP


END main