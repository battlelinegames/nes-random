.segment "ZEROPAGE"

; variables for specific uses
random_ptr: .res 1
frame_counter: .res 1          ; this number will cycle from 0 - 255 incrementing each frame

; the random table contains a previously generated random sequence from 0-127
.segment "CODE"

random_table:
.byte $25,$3e,$76,$22,$4b,$56,$5d,$60
.byte $1c,$18,$6e,$06,$3c,$4f,$1b,$52
.byte $58,$15,$46,$55,$48,$7d,$3d,$38
.byte $67,$71,$57,$19,$26,$07,$7e,$40
.byte $0b,$36,$51,$6d,$1a,$7f,$5b,$32
.byte $3a,$21,$1d,$5f,$33,$5c,$1e,$47
.byte $2a,$63,$17,$4c,$00,$14,$77,$12
.byte $70,$42,$61,$66,$1f,$43,$3b,$0d
.byte $0f,$0e,$73,$10,$29,$68,$64,$6f
.byte $35,$6b,$0a,$2e,$11,$65,$23,$6a
.byte $7b,$4d,$01,$49,$4e,$50,$27,$24
.byte $3f,$08,$2c,$54,$5a,$03,$53,$7c
.byte $41,$28,$37,$2b,$59,$6c,$5e,$79
.byte $72,$69,$2f,$04,$31,$20,$4a,$74
.byte $7a,$0c,$30,$75,$09,$44,$62,$78
.byte $39,$2d,$16,$05,$45,$34,$02,$13


; this clobbers x register
.macro get_random_a 
    inc random_ptr
    advance_random_ptr
    tax
    lda random_table, x
.endmacro

; increment the pointer into our ramdom table based ont he current frame counter
.macro advance_random_ptr
    lda random_ptr
    adc frame_counter ; I don't really care if the carry byte is set for random jump
    and #%01111111
    sta random_ptr
.endmacro