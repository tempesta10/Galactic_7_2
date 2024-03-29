CRoom_CreateRoom            proto :DWORD
CRoom_VirtualAlloc          proto
CRoom_VirtualFree           proto
;----------------------------------------------
CRoom_LoadBackground        proto :DWORD,:DWORD
;----------------------------------------------
CRoom_onLoop                proto
CRoom_onRender              proto
CRoom_onEvent               proto :DWORD
CRoom_onQuit                proto
CRoom_onKeyDown             proto :DWORD,:DWORD
CRoom_onExit                proto
CRoom_onKeyEnter            proto :DWORD
;----------------------------------------------
CRoom_move_camera           proto :DWORD
CRoom_set_camera            proto :DWORD,:DWORD,:DWORD,:DWORD
;----------------------------------------------
CGameRoom_onLoop            proto
CGameRoom_onKeyDown         proto :DWORD,:DWORD
CGameRoom_onEvent           proto :DWORD
CGameRoom_onRender          proto
CGameRoom_DrawTextMain      proto :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
CGameRoom_DrawText          proto :DWORD
CGameRoom_DrawHighScore     proto :DWORD
CGameRoom_DrawScore         proto
CTitleRoom_onRender         proto
CCompletedRoom_onRender     proto
;----------------------------------------------
.const
LEVEL_BONUS         equ 2000

.data
lpvBase             dd 0
background          dd 0
camera              RECT <0,0,ROOM_WIDTH,ROOM_HEIGHT>
hspeed              dd 0
vspeed              dd 0
completed           dd 0
failed              dd 0
ticks               dd 0
;----------------------------------------------
szFontSeas          db "SeasideResortNF",0
szFailed            db "Missin Failed!",0
szCompleted         db "Mission Completed!",0
szCongratz          db "Congratz! You've delivered all the mail!",0
szEnter             db "Press key Enter to continue.",0
szAnyKey            db "Press  Any key to continue",0
;----------------------------------------------
;fRoomRender         dd offset CRoom_onRender
;fRoomLoop           dd offset CRoom_onLoop
;fRoomEvent          dd offset CRoom_onEvent
;fRoomQuit           dd offset CRoom_onQuit
;fRoomOnKeyDown      dd offset CRoom_onKeyDown



.code
CRoom_VirtualFree proc uses ebx esi edi

    fn VirtualFree,lpvBase,0,MEM_RELEASE

	ret
CRoom_VirtualFree endp
;**************************************************************
CRoom_VirtualAlloc proc uses ebx esi edi
   LOCAL sSysInfo:SYSTEM_INFO

   fn GetSystemInfo,addr sSysInfo
   ;-----------------------------
   fn VirtualAlloc,0,sSysInfo.dwPageSize,MEM_COMMIT,PAGE_READWRITE
   ;-----------------------------
   mov dword ptr[lpvBase],eax
   or eax,eax
   jne @F
   ;-----------------------------
   fn MessageBox,0,"Failed Allocate Memory","Error!",MB_ICONERROR
   fn ExitProcess,EXIT_FAILURE
   
 @@:
   mov dword ptr[eax],offset CRoom_onRender
   mov dword ptr[eax+4],offset CRoom_onLoop
   mov dword ptr[eax+8],offset CRoom_onEvent
   mov dword ptr[eax+12],offset CRoom_onQuit
   mov dword ptr[eax+16],offset CRoom_onKeyDown

	ret
CRoom_VirtualAlloc endp
;**************************************************************
CRoom_CreateRoom  proc uses ebx esi edi idRoom:DWORD

   mov dword ptr[completed],0
   mov dword ptr[failed],0
   mov dword ptr[ticks],30
   ;-------------------------
   switch idRoom
       
       case STATE_TITLE
            
            fn CEntity_Create,ASTEROID,183,10,50,50,272,32
            fn CEntity_Create,ASTEROID,183,10,50,50,16,96
            fn CEntity_Create,ASTEROID,183,10,50,50,240,256
            fn CEntity_Create,ASTEROID,183,10,50,50,496,368
            ;---------------------------------------
            fn CEntity_Create,ID_TITLE,1,0,500,300,80,96
            ;---------------------------------------
            fn CEntity_Create,MOON,8,0,64,64,496,64
            fn CEntity_Create,MOON,8,0,64,64,80,272
            fn CEntity_Create,MOON,8,0,64,64,256,352
            fn CEntity_Create,MOON,8,0,64,64,512,272
            fn CEntity_Create,MOON,8,0,64,64,240,192
            ;---------------------------------------
            mov eax,lpvBase
            mov dword ptr[eax],offset CTitleRoom_onRender
            
       case STATE_ROOM_FIRST
       
            fn CScore_ResetScore,1000
            ;---------------------------------------
            fn CEntity_Create,ASTEROID,183,10,50,50,272,32
            fn CEntity_Create,ASTEROID,183,10,50,50,16,96
            fn CEntity_Create,ASTEROID,183,10,50,50,240,256
            fn CEntity_Create,ASTEROID,183,10,50,50,496,368
            ;---------------------------------------
            fn CEntity_Create,MOON,8,0,64,64,496,64
            fn CEntity_Create,MOON,8,0,64,64,80,272
            fn CEntity_Create,MOON,8,0,64,64,256,352
            fn CEntity_Create,MOON,8,0,64,64,512,272
            fn CEntity_Create,BASE_MOON,8,0,64,64,240,192
            ;---------------------------------------
            fn CEntity_Create,PLAYER,72,10,48,48,10,10
            ;---------------------------------------
            mov eax,lpvBase
            mov dword ptr[eax],offset CGameRoom_onRender
            mov dword ptr[eax+4],offset CGameRoom_onLoop
            mov dword ptr[eax+8],offset CGameRoom_onEvent
            mov dword ptr[eax+16],offset CGameRoom_onKeyDown
            
       case STATE_ROOM_SECOND
       
            fn CScore_ResetScore,1000
            ;---------------------------------------
            fn CEntity_Create,ASTEROID,183,10,50,50,272,32
            fn CEntity_Create,ASTEROID,183,10,50,50,16,96
            fn CEntity_Create,ASTEROID,183,10,50,50,240,256
            fn CEntity_Create,ASTEROID,183,10,50,50,496,368
            fn CEntity_Create,ASTEROID,183,10,50,50,64,368
            fn CEntity_Create,ASTEROID,183,10,50,50,128,368
            ;---------------------------------------
            fn CEntity_Create,MOON,8,0,64,64,496,64
            fn CEntity_Create,MOON,8,0,64,64,80,272
            fn CEntity_Create,MOON,8,0,64,64,256,352
            fn CEntity_Create,MOON,8,0,64,64,512,272
            fn CEntity_Create,MOON,8,0,64,64,128,64
            fn CEntity_Create,BASE_MOON,8,0,64,64,240,192
            ;---------------------------------------
            fn CEntity_Create,PLAYER,72,10,48,48,10,10
            ;---------------------------------------
            mov eax,lpvBase
            mov dword ptr[eax],offset CGameRoom_onRender
            mov dword ptr[eax+4],offset CGameRoom_onLoop
            mov dword ptr[eax+8],offset CGameRoom_onEvent
            mov dword ptr[eax+16],offset CGameRoom_onKeyDown
            
            

       case STATE_ROOM_THIRD
            
            fn CScore_ResetScore,1000
            ;---------------------------------------
            fn CEntity_Create,ASTEROID,183,10,50,50,272,32
            fn CEntity_Create,ASTEROID,183,10,50,50,16,96
            fn CEntity_Create,ASTEROID,183,10,50,50,240,256
            fn CEntity_Create,ASTEROID,183,10,50,50,496,368
            fn CEntity_Create,ASTEROID,183,10,50,50,64,368
            fn CEntity_Create,ASTEROID,183,10,50,50,128,368
            fn CEntity_Create,ASTEROID,183,10,50,50,383,332
            fn CEntity_Create,ASTEROID,183,10,50,50,128,160
            ;---------------------------------------
            fn CEntity_Create,MOON,8,0,64,64,496,64
            fn CEntity_Create,MOON,8,0,64,64,80,272
            fn CEntity_Create,MOON,8,0,64,64,256,352
            fn CEntity_Create,MOON,8,0,64,64,512,272
            fn CEntity_Create,MOON,8,0,64,64,128,64
            fn CEntity_Create,BASE_MOON,8,0,64,64,240,192
            ;---------------------------------------
            fn CEntity_Create,PLAYER,72,10,48,48,10,10
            ;---------------------------------------
            mov eax,lpvBase
            mov dword ptr[eax],offset CGameRoom_onRender
            mov dword ptr[eax+4],offset CGameRoom_onLoop
            mov dword ptr[eax+8],offset CGameRoom_onEvent
            mov dword ptr[eax+16],offset CGameRoom_onKeyDown
            
       case STATE_ROOM_COMPLETED
            
            fn CScore_ResetScore,2000
            ;---------------------------------------
            fn CEntity_Create,ASTEROID,183,10,50,50,272,32
            fn CEntity_Create,ASTEROID,183,10,50,50,16,96
            fn CEntity_Create,ASTEROID,183,10,50,50,240,256
            fn CEntity_Create,ASTEROID,183,10,50,50,496,368
            ;---------------------------------------
            mov eax,lpvBase
            mov dword ptr[eax],offset CCompletedRoom_onRender
            mov dword ptr[eax+4],offset CRoom_onLoop
            mov dword ptr[eax+8],offset CRoom_onEvent
            mov dword ptr[eax+16],offset CRoom_onKeyDown
    endsw


	ret
CRoom_CreateRoom endp
;*************************************************************
CRoom_onExit proc

    mov eax,STATE_EXIT

	ret
CRoom_onExit endp
;**************************************************************
CRoom_onKeyDown proc uses ebx esi edi dwKey:DWORD,idState:DWORD
    LOCAL dwReturnValue:DWORD
    
    mov dword ptr[dwReturnValue],STATE_NULL
    ;--------------------------------------
    mov eax,dword ptr[dwKey]
    or eax,eax
    je @@Ret
    ;--------------------------------------
    mov eax,dword ptr[idState]
    inc eax
    cmp eax,STATE_ROOM_COMPLETED
    ;--------------------------------------
    jg @F
    mov dword ptr[dwReturnValue],eax
    jmp @@Ret
@@:
    mov dword ptr[dwReturnValue],STATE_TITLE
    ;---------------------------------------
@@Ret:
    ;---------------------------------------
    mov eax,dword ptr[dwReturnValue]

	ret
CRoom_onKeyDown endp
;**************************************************************
CRoom_onKeyEnter proc uses ebx esi edi idState:DWORD
    LOCAL dwReturnValue:DWORD

    mov dword ptr[dwReturnValue],0
    ;---------------------------
    cmp dword ptr[failed],0
    je @F
    ;-------------------------------
    mov ebx,dword ptr[idState]
    mov dword ptr[dwReturnValue],ebx
    jmp @@Ret
    ;-------------------------------
@@:
    cmp dword ptr[completed],0
    je @@Ret
    ;-------------------------------
    mov ebx,dword ptr[idState]
    inc ebx
    mov dword ptr[dwReturnValue],ebx

@@Ret:
    ;---------------------------
    mov eax,dword ptr[dwReturnValue]
	ret
CRoom_onKeyEnter endp
;**************************************************************
CGameRoom_onKeyDown proc uses ebx esi edi dwKey:DWORD,idState:DWORD
     LOCAL dwReturnValue:DWORD
    
    mov dword ptr[dwReturnValue],0
    ;------------------------------
    switch dwKey


        case LEFT_ARROW
        
            fn CPlayer_onKeyLeft
        
        case RIGHT_ARROW
            
            fn CPlayer_onKeyRight
            
        case VK_SPACE
        
            fn CPlayer_onKeySpace
            
        case VK_RETURN
        
            fn CRoom_onKeyEnter,idState
            mov dword ptr[dwReturnValue],eax
            
        case 'n'
        
           mov ebx,dword ptr[idState]
           inc ebx
           mov dword ptr[dwReturnValue],ebx
           
    endsw

    ;------------------------------
    mov eax,dword ptr[dwReturnValue]
	ret
CGameRoom_onKeyDown endp
;**************************************************************
CRoom_onQuit proc uses ebx esi edi

    mov eax,dword ptr[pEntity]
    or eax,eax
    je @@Ret
    ;-------------------------
    xor ebx,ebx
    mov esi,pEntity
    assume esi:PTR ENTITY
    jmp @@For
    ;-------------------------
@@In:  
    mov eax,dword ptr[esi].sprite
    fn DeleteObject,eax
    ;-------------------------
    add esi,sizeof ENTITY
    inc ebx
    
@@For:
    cmp ebx,entity_num
    jl @@In
    ;-------------------------
    assume esi:nothing
    ;-------------------------
    fn LocalFree,pEntity
    mov dword ptr[pEntity],0
    ;-------------------------
    mov dword ptr[entity_num],0
@@Ret:
	ret
CRoom_onQuit endp
;***************************************************************
CRoom_onEvent proc uses ebx esi edi idState:DWORD
   LOCAL dwReturnValue:DWORD
    
    mov dword ptr[dwReturnValue],STATE_NULL
    ;----------------------
    fn Keyboard_check
    ;----------------------
    .if eax == VK_ESCAPE
    
       fn CRoom_onExit
       mov dword ptr[dwReturnValue],eax
       
    .else
    
       push dword ptr[idState]
       push eax
       ;call dword ptr[fRoomOnKeyDown]
       mov eax,lpvBase
       call dword ptr[eax+16]
       ;-------------------
       mov dword ptr[dwReturnValue],eax
       
    .endif
    ;----------------------
    mov eax,dword ptr[dwReturnValue]
    
	ret
CRoom_onEvent endp
CGameRoom_onEvent proc uses ebx esi edi idState:DWORD

    cmp dword ptr[completed],1
    je @@Ret
    ;----------------------
    fn CEntity_IsEntityExist,MOON
    or eax,eax
    jne @@Next
    ;----------------------
    fn CEntity_GetEntity,PLAYER
    or eax,eax
    je @F
    ;----------------------
    mov dword ptr[eax+17],PLAYER_COMPLETED
    ;----------------------
 @@:
    dec dword ptr[ticks]
    cmp dword ptr[ticks],0
    jg @@Ret
    ;----------------------
    mov dword ptr[completed],1
    add dword ptr[score],LEVEL_BONUS
    ;----------------------
    jmp @@Ret
    ;----------------------
@@Next:
    cmp dword ptr[failed],1
    je @@Ret
    ;----------------------
    fn CEntity_IsEntityExist,EXPLOSION
    or eax,eax
    je @@Ret
    ;----------------------
    dec dword ptr[ticks]
    cmp dword ptr[ticks],0
    jg @@Ret
    ;----------------------
    mov dword ptr[failed],1
    ;----------------------
@@Ret:
    fn CRoom_onEvent,idState
	ret
CGameRoom_onEvent endp
;****************************************************************
CRoom_onLoop proc uses ebx esi edi

   xor ebx,ebx
   jmp @@For
   ;-------------------------------
@@In:
   mov esi,pEntity
   mov eax,sizeof ENTITY
   mul ebx
   add esi,eax
   
   mov eax,dword ptr[esi+17] ;id
   
   .if eax != ID_NONE
   
       mov eax,dword ptr[esi+65]   ;fLoop
       push esi
       call eax
   
   .endif
   ;-------------------------------
   inc ebx

@@For:
   cmp ebx,entity_num
   jl @@In

	ret
CRoom_onLoop endp
;*****************************************************************
CRoom_onRender proc uses ebx esi edi

   fn CIMG_DrawBMP,background,screen,camera.left,camera.top,camera.right,camera.bottom
   ;--------------------------------
   mov esi,pEntity
   xor ebx,ebx
   assume esi:PTR ENTITY
   jmp @@For
   ;-------------------------------
@@In:
   mov eax,dword ptr[esi].id
   
   .if eax != ID_NONE
   
       mov eax,dword ptr[esi].fRender
       push esi
       call eax
   
   .endif
   ;-------------------------------
   inc ebx
   add esi,sizeof ENTITY
@@For:
   cmp ebx,entity_num
   jl @@In
   ;------------------------------
   assume esi:nothing
	ret
CRoom_onRender endp
;******************************************************************
CGameRoom_onLoop proc uses ebx esi edi

    fn CRoom_onLoop
    ;------------------------------
    xor ebx,ebx
    mov edi,pEntity
    assume edi:PTR ENTITY
    jmp @@For
  @@In:
    mov eax,dword ptr[edi].id
    
    .if eax == PLAYER || eax == PLAYER_COMPLETED
       

       .if dword ptr[edi].sprite == 0
       
           ;fn MessageBox,0,"Player Load",0,0
           fn CEntity_LoadSprite,hInstance,IDI_PLAYER
           ;------------------------------
           mov dword ptr[edi].sprite,eax
          
       .endif
       
       jmp @@Ret
    .endif
    ;------------------
    add edi,sizeof ENTITY
    inc ebx
  @@For:
    cmp ebx,entity_num
    jl @@In
    
@@Ret:
    assume edi:nothing

	ret
CGameRoom_onLoop endp
;******************************************************************
CGameRoom_onRender proc uses ebx esi edi 


    fn CRoom_onRender
    ;-------------------
    .if dword ptr[failed] == 1 || dword ptr[completed] == 1
    
         .if dword ptr[failed] == 1
    
               fn CGameRoom_DrawTextMain,IDF_SEAS,offset szFontSeas,28,00434DDh,offset szFailed
    
         .elseif dword ptr[completed] == 1
    
               fn CGameRoom_DrawTextMain,IDF_SEAS,offset szFontSeas,28,0080FF80h,offset szCompleted
         
         .endif
         
         fn CGameRoom_DrawHighScore,18
         ;------------------------------------
         fn CGameRoom_DrawText,offset szEnter
         
    .else
    
         fn CGameRoom_DrawScore
         
    .endif
    
	ret
CGameRoom_onRender endp
;******************************************************************
CTitleRoom_onRender proc uses ebx esi edi

    fn CRoom_onRender
    ;-------------------
    fn CGameRoom_DrawText,offset szAnyKey

	ret
CTitleRoom_onRender endp
;******************************************************************
CCompletedRoom_onRender proc uses ebx esi edi

    fn CRoom_onRender
    ;-------------------
    fn CGameRoom_DrawTextMain,IDF_SEAS,offset szFontSeas,14,0080FF80h,offset szCongratz
    ;-------------------
    fn CGameRoom_DrawHighScore,16
    ;-------------------
    fn CGameRoom_DrawText,offset szAnyKey

	ret
CCompletedRoom_onRender endp
;******************************************************************
CGameRoom_DrawTextMain proc uses ebx esi edi idFont:DWORD,lpFontName:DWORD,FontSize:DWORD,color:DWORD,lpText:DWORD
    LOCAL hRes:DWORD
    LOCAL hFont:DWORD
    LOCAL xt:DWORD
    
    ;-------------------------------------

    fn CTTF_LoadFontMem,hInstance,idFont
    mov dword ptr[hRes],eax
    ;-------------------------------------
    fn CTTF_CreateFont,screen,lpFontName,FontSize
    mov dword ptr[hFont],eax
    ;-------------------------------------
    or eax,eax
    je @@Ret
    ;-------------------------------------
    fn CTTF_GetTextWidth,screen,eax,lpText
    mov ebx,ROOM_WIDTH
    sub ebx,eax
    shr ebx,1
    mov dword ptr[xt],ebx
    ;-------------------------------------
    fn CTTF_GetTextHeight,screen,hFont,lpText
    ;-------------------------------------
    mov ebx,ROOM_HEIGHT
    shr ebx,1
    sub ebx,eax
    ;-------------------------------------
    fn CTTF_TextOut,screen,hFont,lpText,xt,ebx,color
    ;-------------------------------------
    fn CTTF_DeleteFont,hFont
    ;-------------------------------------
@@Ret:
    fn CTTF_UnloadFontMem,hRes
	ret
CGameRoom_DrawTextMain endp
;******************************************************************
CGameRoom_DrawText proc uses ebx esi edi lpText:DWORD
    LOCAL hRes:DWORD
    LOCAL hFont:DWORD
    LOCAL xt:DWORD
    
    szText szFontNameR,"Ranga"
    ;-------------------------------------
    mov esi,lpText
    ;-------------------------------------
    fn CTTF_LoadFontMem,hInstance,IDF_RANGA
    mov dword ptr[hRes],eax
    ;-------------------------------------
    fn CTTF_CreateFont,screen,offset szFontNameR,20
    mov dword ptr[hFont],eax
    ;-------------------------------------
    or eax,eax
    je @@Ret
    ;-------------------------------------
    fn CTTF_GetTextWidth,screen,eax,esi
    mov ebx,ROOM_WIDTH
    sub ebx,eax
    shr ebx,1
    mov dword ptr[xt],ebx
    ;-------------------------------------
    fn CTTF_GetTextHeight,screen,hFont,esi
    ;-------------------------------------
    mov ebx,ROOM_HEIGHT
    add eax,10
    sub ebx,eax
    ;-------------------------------------
    fn CTTF_TextOut,screen,hFont,esi,xt,ebx,0000FFFFh
    ;-------------------------------------
    fn CTTF_DeleteFont,hFont
    ;-------------------------------------
@@Ret:
    fn CTTF_UnloadFontMem,hRes


	ret
CGameRoom_DrawText endp
;******************************************************************
CGameRoom_DrawHighScore proc uses ebx esi edi FontSize:DWORD
    LOCAL hRes:DWORD
    LOCAL hFont:DWORD
    LOCAL xt:DWORD
    
    ;-------------------------------------

    fn CTTF_LoadFontMem,hInstance,IDF_SEAS
    mov dword ptr[hRes],eax
    ;-------------------------------------
    fn CTTF_CreateFont,screen,offset szFontSeas,FontSize
    mov dword ptr[hFont],eax
    ;-------------------------------------
    or eax,eax
    je @@Ret
    ;-------------------------------------
    fn CScore_GetHighScore
    mov esi,eax
    ;-------------------------------------
    fn CTTF_GetTextWidth,screen,hFont,esi
    mov ebx,ROOM_WIDTH
    sub ebx,eax
    shr ebx,1
    mov dword ptr[xt],ebx
    ;-------------------------------------
    fn CTTF_GetTextHeight,screen,hFont,esi
    ;-------------------------------------
    mov ebx,ROOM_HEIGHT
    shr ebx,1
    add ebx,eax
    ;-------------------------------------
    fn CTTF_TextOut,screen,hFont,esi,xt,ebx,0000FFFFh
    ;-------------------------------------
    fn CTTF_DeleteFont,hFont
    ;-------------------------------------
@@Ret:
    fn CTTF_UnloadFontMem,hRes

	ret
CGameRoom_DrawHighScore endp
;******************************************************************
CGameRoom_DrawScore proc uses ebx esi edi
    LOCAL hRes:DWORD
    LOCAL hFont:DWORD
    
    szText szFontNameSki,"SkiCargo"
    ;-------------------------------------

    fn CTTF_LoadFontMem,hInstance,IDF_SKI
    mov dword ptr[hRes],eax
    ;-------------------------------------
    fn CTTF_CreateFont,screen,offset szFontNameSki,20
    mov dword ptr[hFont],eax
    ;-------------------------------------
    or eax,eax
    je @@Ret
    ;-------------------------------------
    fn CScore_GetScore
    ;-------------------------------------
    mov ebx,ROOM_HEIGHT
    sub ebx,40
    ;-------------------------------------
    fn CTTF_TextOut,screen,hFont,eax,10,ebx,0000FFFFh
    ;-------------------------------------
    fn CTTF_DeleteFont,hFont
    ;-------------------------------------
@@Ret:
    fn CTTF_UnloadFontMem,hRes

	ret
CGameRoom_DrawScore endp
;******************************************************************
CRoom_LoadBackground proc uses ebx esi edi hInst:DWORD,idBmp:DWORD

    fn CIMG_LoadBMP,hInst,idBmp
    mov dword ptr[background],eax
    ;----------------------------
    or eax,eax
    jne @F
    ;----------------------------
    fn MessageBox,0,"Load Background Faild","Error!",MB_ICONERROR
    fn ExitProcess,EXIT_FAILURE
  @@:  
	ret
CRoom_LoadBackground endp
;*******************************************************************
CRoom_move_camera proc uses ebx esi edi lvlWidth:DWORD

    mov eax,dword ptr[hspeed]
    add dword ptr[camera.left],eax
    ;-------------------------
    mov eax,dword ptr[vspeed]
    add dword ptr[camera.top],eax
    ;-------------------------
    mov eax,dword ptr[camera.left]
    add eax,dword ptr[camera.right]
    cmp eax,dword ptr[lvlWidth]
    jge @F
    jmp @@Ret
    ;-------------------------
 @@:
    mov eax,dword ptr[lvlWidth]
    sub eax,dword ptr[camera.right]
    mov dword ptr[camera.left],eax
 
@@Ret:
	ret
CRoom_move_camera endp
;*******************************************************************
CRoom_set_camera proc uses ebx esi edi left:DWORD,top:DWORD,right:DWORD,bottom:DWORD

    fn SetRect,offset camera,left,top,right,bottom
    
	ret
CRoom_set_camera endp
