CApp_onStart           proto

.code
CApp_onStart proc uses ebx esi edi

    fn crt_time,0
    fn crt_rand,eax
    ;---------------------------------------
    mov dword ptr[id_state],STATE_TITLE
    ;---------------------------------------
    fn CRoom_LoadBackground,hInstance,IDI_BACKGROUND
    fn CRoom_VirtualAlloc
    ;---------------------------------------
    ; Load Music
    ;---------------------------------------
    fn CRoom_CreateRoom,STATE_TITLE

	ret
CApp_onStart endp