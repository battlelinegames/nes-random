.segment "ZEROPAGE"
    nmi_ready: .res 1
    palette_init: .res 1
    scroll_y: .res 1

.segment "CODE"

nmi:
    pha             ; make sure we don't clobber the A register

    lda nmi_ready   ; check the nmi_ready flag
    bne nmi_go      ; if nmi_ready set to 1 we can execute the nmi code
        pla
        rti
    nmi_go:

    ; set the player metasprite with a proc
    ; call the oam dma with a macro
    jsr oam_dma
/*
    lda gamepad_press
    bne skip_hi
        printf_nmi "RAND", 80, 96
    skip_hi:
*/
    lda PPU_STATUS ; $2002

    set PPU_SCROLL, #0
    sta PPU_SCROLL
;    set PPU_SCROLL, scroll_y

    lda gamepad_release ;gamepad_press
    beq no_press
        jsr one_thru_four
        lda var_1_to_4

        cmp #1
        beq rand_1
        cmp #2
        beq rand_2
        cmp #3
        beq rand_3

        jsr randomize_on_btn_press_0
        jmp rand_end

        rand_1:
            jsr randomize_on_btn_press_1
            jmp rand_end

        rand_2:
            jsr randomize_on_btn_press_2
            jmp rand_end

        rand_3:
            jsr randomize_on_btn_press_3

        rand_end:
    no_press:

    set nmi_ready, #0

    pla
    rti

