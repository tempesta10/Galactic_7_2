
;************************ Public functions Class Score ***********************

CScore_SetScore                  proto
CScore_ResetScore                proto :DWORD
CScore_GetScore                  proto
CScore_GetHighScore              proto



.data
score        dd 0
score_ticks  dd 100
score_old    dd 0



.data?
szBuffer     db 32 dup(?)


.code
CScore_SetScore proc uses ebx esi edi

    fn GetTickCount
    ;--------------------------
    mov ebx,dword ptr[score_old]
    ;--------------------------
    add ebx,dword ptr[score_ticks]
    ;--------------------------
    cmp eax,ebx
    jle @@Ret
    ;--------------------------
    dec dword ptr[score]
    mov dword ptr[score_old],eax
    
@@Ret:
	ret
CScore_SetScore endp
;******************************************************************************
CScore_ResetScore proc uses ebx esi edi dwNum:DWORD

    mov ebx,dword ptr[dwNum]
    mov dword ptr[score],ebx
    ;---------------------------
    fn GetTickCount
    ;---------------------------
    mov dword ptr[score_old],eax
    ;---------------------------


	ret
CScore_ResetScore endp
;******************************************************************************
CScore_GetScore proc uses ebx esi edi

    szText szFrm,"Score: %d"

    fn wsprintf,offset szBuffer,offset szFrm,score
    ;------------------------------------
    mov eax,offset szBuffer

	ret
CScore_GetScore endp 
;******************************************************************************
CScore_GetHighScore proc uses ebx esi edi

    szText szHighFrm,"High Score: %d"

    fn wsprintf,offset szBuffer,offset szHighFrm,score
    ;------------------------------------
    mov eax,offset szBuffer

	ret
CScore_GetHighScore endp