;======================================================================================
; GAMEPAD DATA FLAGS
; 76543210
; ||||||||
; |||||||+--> A Button
; ||||||+---> B Button
; |||||+----> SELECT Button
; ||||+-----> START Button
; |||+------> UP Direction
; ||+-------> DOWN Direction
; |+--------> LEFT Direction
; +---------> RIGHT Direction
;======================================================================================

; These are the bit flags the are used by the vars
.define PRESS_A        #%00000001
.define PRESS_B        #%00000010
.define PRESS_SELECT   #%00000100
.define PRESS_START    #%00001000
.define PRESS_UP       #%00010000
.define PRESS_DOWN     #%00100000
.define PRESS_LEFT     #%01000000
.define PRESS_RIGHT    #%10000000

.segment "ZEROPAGE"
    gamepad_press: .res 1
    gamepad_last_press: .res 1
    gamepad_new_press: .res 1
    gamepad_release: .res 1

.segment "CODE"

GAMEPAD_REGISTER = $4016

; initialize the gamepad.  this is called from the set_gamepad
.proc gamepad_init
    set gamepad_last_press, gamepad_press       ; save gamepad_press to gamepad_last_press

    ; Setup the gamepad register so we can start pulling gamepad data
    set  GAMEPAD_REGISTER, #1
    set  GAMEPAD_REGISTER, #0

    ; the prior set call set the A register to #0, so no need to load it again
    sta gamepad_press ; clear out our gamepad press byte

    rts 
.endproc

; use this macro to figure out if a specific button was pressed
.macro button_press_check button
    .local @not_pressed
    lda GAMEPAD_REGISTER
    and #%00000001
    beq @not_pressed    ; beq key not pressed
        lda button
        ora gamepad_press
        sta gamepad_press
    @not_pressed:   ; key not pressed
.endmacro

; initialize and set the gamepad values
.proc set_gamepad

    jsr gamepad_init ; prepare the gamepad register to pull data serially

    gamepad_a:
        lda GAMEPAD_REGISTER
        and #%00000001
        sta gamepad_press

    gamepad_b:
        button_press_check PRESS_B

    gamepad_select:
        button_press_check PRESS_SELECT

    gamepad_start:
        button_press_check PRESS_START

    gamepad_up:
        button_press_check PRESS_UP

    gamepad_down:
        button_press_check PRESS_DOWN

    gamepad_left:
        button_press_check PRESS_LEFT

    gamepad_right:
        button_press_check PRESS_RIGHT
    
    ; to find out if this is a newly pressed button, load the last buttons pressed, and 
    ; flipp all the bits with an eor #$ff.  Then you can AND the results with current
    ; gamepad pressed.  This will give you what wasn't pressed previously, but what is
    ; pressed now.  Then store that value in the gamepad_new_press
    lda gamepad_last_press 
    eor #$ff
    and gamepad_press

    sta gamepad_new_press ; all these buttons are new presses and not existing presses

    ; in order to find what buttons were just released, we load and flip the buttons that
    ; are currently pressed  and and it with what was pressed the last time.
    ; that will give us a button that is not pressed now, but was pressed previously
    lda gamepad_press       ; reload original gamepad_press flags
    eor #$ff                ; flip the bits so we have 1 everywhere a button is released

    ; anding with last press shows buttons that were pressed previously and not pressed now
    and gamepad_last_press  

    ; then store the results in gamepad_release
    sta gamepad_release  ; a 1 flag in a button position means a button was just released
    rts
.endproc

.proc randomize_on_btn_press_0
    pha
        get_random_a
        and #%00001111
        cmp #0
        jmp_eq print_00
        cmp #1
        jmp_eq print_01
        cmp #2
        jmp_eq print_02
        cmp #3
        jmp_eq print_03
        cmp #4
        jmp_eq print_04
        cmp #5
        jmp_eq print_05
        cmp #6
        jmp_eq print_06
        cmp #7
        jmp_eq print_07
        cmp #8
        jmp_eq print_08
        cmp #9
        jmp_eq print_09


        cmp #10
        jmp_eq print_10
        cmp #11
        jmp_eq print_11
        cmp #12
        jmp_eq print_12
        cmp #13
        jmp_eq print_13
        cmp #14
        jmp_eq print_14
        cmp #15
        jmp_eq print_15


        print_00:
            printf_nmi "00", 80, 32
            jmp end_print
        print_01:
            printf_nmi "01", 80, 32
            jmp end_print
        print_02:
            printf_nmi "02", 80, 32
            jmp end_print
        print_03:
            printf_nmi "03", 80, 32
            jmp end_print
        print_04:
            printf_nmi "04", 80, 32
            jmp end_print
        print_05:
            printf_nmi "05", 80, 32
            jmp end_print
        print_06:
            printf_nmi "06", 80, 32
            jmp end_print
        print_07:
            printf_nmi "07", 80, 32
            jmp end_print
        print_08:
            printf_nmi "08", 80, 32
            jmp end_print
        print_09:
            printf_nmi "09", 80, 32
            jmp end_print


        print_10:
            printf_nmi "10", 80, 32
            jmp end_print
        print_11:
            printf_nmi "11", 80, 32
            jmp end_print
        print_12:
            printf_nmi "12", 80, 32
            jmp end_print
        print_13:
            printf_nmi "13", 80, 32
            jmp end_print
        print_14:
            printf_nmi "14", 80, 32
            jmp end_print
        print_15:
            printf_nmi "15", 80, 32
            jmp end_print
        end_print:

    pla
    rts
.endproc

.proc randomize_on_btn_press_1
    pha
        get_random_a
        and #%00001111
        cmp #0
        jmp_eq print_00
        cmp #1
        jmp_eq print_01
        cmp #2
        jmp_eq print_02
        cmp #3
        jmp_eq print_03
        cmp #4
        jmp_eq print_04
        cmp #5
        jmp_eq print_05
        cmp #6
        jmp_eq print_06
        cmp #7
        jmp_eq print_07
        cmp #8
        jmp_eq print_08
        cmp #9
        jmp_eq print_09


        cmp #10
        jmp_eq print_10
        cmp #11
        jmp_eq print_11
        cmp #12
        jmp_eq print_12
        cmp #13
        jmp_eq print_13
        cmp #14
        jmp_eq print_14
        cmp #15
        jmp_eq print_15


        print_00:
            printf_nmi "00", 80, 48
            jmp end_print
        print_01:
            printf_nmi "01", 80, 48
            jmp end_print
        print_02:
            printf_nmi "02", 80, 48
            jmp end_print
        print_03:
            printf_nmi "03", 80, 48
            jmp end_print
        print_04:
            printf_nmi "04", 80, 48
            jmp end_print
        print_05:
            printf_nmi "05", 80, 48
            jmp end_print
        print_06:
            printf_nmi "06", 80, 48
            jmp end_print
        print_07:
            printf_nmi "07", 80, 48
            jmp end_print
        print_08:
            printf_nmi "08", 80, 48
            jmp end_print
        print_09:
            printf_nmi "09", 80, 48
            jmp end_print


        print_10:
            printf_nmi "10", 80, 48
            jmp end_print
        print_11:
            printf_nmi "11", 80, 48
            jmp end_print
        print_12:
            printf_nmi "12", 80, 48
            jmp end_print
        print_13:
            printf_nmi "13", 80, 48
            jmp end_print
        print_14:
            printf_nmi "14", 80, 48
            jmp end_print
        print_15:
            printf_nmi "15", 80, 48
            jmp end_print
        end_print:

    pla
    rts
.endproc

.proc randomize_on_btn_press_2
    pha
        get_random_a
        and #%00001111
        cmp #0
        jmp_eq print_00
        cmp #1
        jmp_eq print_01
        cmp #2
        jmp_eq print_02
        cmp #3
        jmp_eq print_03
        cmp #4
        jmp_eq print_04
        cmp #5
        jmp_eq print_05
        cmp #6
        jmp_eq print_06
        cmp #7
        jmp_eq print_07
        cmp #8
        jmp_eq print_08
        cmp #9
        jmp_eq print_09


        cmp #10
        jmp_eq print_10
        cmp #11
        jmp_eq print_11
        cmp #12
        jmp_eq print_12
        cmp #13
        jmp_eq print_13
        cmp #14
        jmp_eq print_14
        cmp #15
        jmp_eq print_15


        print_00:
            printf_nmi "00", 80, 64
            jmp end_print
        print_01:
            printf_nmi "01", 80, 64
            jmp end_print
        print_02:
            printf_nmi "02", 80, 64
            jmp end_print
        print_03:
            printf_nmi "03", 80, 64
            jmp end_print
        print_04:
            printf_nmi "04", 80, 64
            jmp end_print
        print_05:
            printf_nmi "05", 80, 64
            jmp end_print
        print_06:
            printf_nmi "06", 80, 64
            jmp end_print
        print_07:
            printf_nmi "07", 80, 64
            jmp end_print
        print_08:
            printf_nmi "08", 80, 64
            jmp end_print
        print_09:
            printf_nmi "09", 80, 64
            jmp end_print


        print_10:
            printf_nmi "10", 80, 64
            jmp end_print
        print_11:
            printf_nmi "11", 80, 64
            jmp end_print
        print_12:
            printf_nmi "12", 80, 64
            jmp end_print
        print_13:
            printf_nmi "13", 80, 64
            jmp end_print
        print_14:
            printf_nmi "14", 80, 64
            jmp end_print
        print_15:
            printf_nmi "15", 80, 64
            jmp end_print
        end_print:

    pla
    rts
.endproc

.proc randomize_on_btn_press_3
    pha
        get_random_a
        and #%00001111
        cmp #0
        jmp_eq print_00
        cmp #1
        jmp_eq print_01
        cmp #2
        jmp_eq print_02
        cmp #3
        jmp_eq print_03
        cmp #4
        jmp_eq print_04
        cmp #5
        jmp_eq print_05
        cmp #6
        jmp_eq print_06
        cmp #7
        jmp_eq print_07
        cmp #8
        jmp_eq print_08
        cmp #9
        jmp_eq print_09


        cmp #10
        jmp_eq print_10
        cmp #11
        jmp_eq print_11
        cmp #12
        jmp_eq print_12
        cmp #13
        jmp_eq print_13
        cmp #14
        jmp_eq print_14
        cmp #15
        jmp_eq print_15


        print_00:
            printf_nmi "00", 80, 80
            jmp end_print
        print_01:
            printf_nmi "01", 80, 80
            jmp end_print
        print_02:
            printf_nmi "02", 80, 80
            jmp end_print
        print_03:
            printf_nmi "03", 80, 80
            jmp end_print
        print_04:
            printf_nmi "04", 80, 80
            jmp end_print
        print_05:
            printf_nmi "05", 80, 80
            jmp end_print
        print_06:
            printf_nmi "06", 80, 80
            jmp end_print
        print_07:
            printf_nmi "07", 80, 80
            jmp end_print
        print_08:
            printf_nmi "08", 80, 80
            jmp end_print
        print_09:
            printf_nmi "09", 80, 80
            jmp end_print


        print_10:
            printf_nmi "10", 80, 80
            jmp end_print
        print_11:
            printf_nmi "11", 80, 80
            jmp end_print
        print_12:
            printf_nmi "12", 80, 80
            jmp end_print
        print_13:
            printf_nmi "13", 80, 80
            jmp end_print
        print_14:
            printf_nmi "14", 80, 80
            jmp end_print
        print_15:
            printf_nmi "15", 80, 80
            jmp end_print
        end_print:

    pla
    rts
.endproc

.proc randomize_on_btn_press_4
    pha
        get_random_a
        and #%00001111
        cmp #0
        jmp_eq print_00
        cmp #1
        jmp_eq print_01
        cmp #2
        jmp_eq print_02
        cmp #3
        jmp_eq print_03
        cmp #4
        jmp_eq print_04
        cmp #5
        jmp_eq print_05
        cmp #6
        jmp_eq print_06
        cmp #7
        jmp_eq print_07
        cmp #8
        jmp_eq print_08
        cmp #9
        jmp_eq print_09


        cmp #10
        jmp_eq print_10
        cmp #11
        jmp_eq print_11
        cmp #12
        jmp_eq print_12
        cmp #13
        jmp_eq print_13
        cmp #14
        jmp_eq print_14
        cmp #15
        jmp_eq print_15


        print_00:
            printf_nmi "00", 80, 96
            jmp end_print
        print_01:
            printf_nmi "01", 80, 96
            jmp end_print
        print_02:
            printf_nmi "02", 80, 96
            jmp end_print
        print_03:
            printf_nmi "03", 80, 96
            jmp end_print
        print_04:
            printf_nmi "04", 80, 96
            jmp end_print
        print_05:
            printf_nmi "05", 80, 96
            jmp end_print
        print_06:
            printf_nmi "06", 80, 96
            jmp end_print
        print_07:
            printf_nmi "07", 80, 96
            jmp end_print
        print_08:
            printf_nmi "08", 80, 96
            jmp end_print
        print_09:
            printf_nmi "09", 80, 96
            jmp end_print


        print_10:
            printf_nmi "10", 80, 96
            jmp end_print
        print_11:
            printf_nmi "11", 80, 96
            jmp end_print
        print_12:
            printf_nmi "12", 80, 96
            jmp end_print
        print_13:
            printf_nmi "13", 80, 96
            jmp end_print
        print_14:
            printf_nmi "14", 80, 96
            jmp end_print
        print_15:
            printf_nmi "15", 80, 96
            jmp end_print
        end_print:

    pla
    rts
.endproc

