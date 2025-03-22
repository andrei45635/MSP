; Exercise: Placement of wedding guests
; We have to assign chairs to three guests, called Alice, Bob, and Charlie
; There are three chairs in a row, called Left, Middle, and Right
; Alice does not want to sit on the leftmost chair
; Alice does not want to sit next to Charlie
; Bob does not want to sit to the right of Charlie
; Is it possible to assign our guests such that they are all happy?

; We introduce a variable XY to indicate that guest X sits in chair Y
(declare-const AL Bool)
(declare-const AM Bool)
(declare-const AR Bool)
(declare-const BL Bool)
(declare-const BM Bool)
(declare-const BR Bool)
(declare-const CL Bool)
(declare-const CM Bool)
(declare-const CR Bool)

; Alice does not want to sit on the leftmost chair
(assert (not AL))

; Alice does not want to sit next to Charlie
(assert 
    (and
        (=> (or AL AR) (not CM))
        (=> AM (and (not CL) (not CR)))
    )
)

; Bob does not want to sit to the right of Charlie
(assert
    (and
        (=> CL (not BM))
        (=> CM (not BR))
        BL
    )
)

; Each person gets a chair
(assert (or AL AM AR))
(assert (or BL BM BR))
(assert (or CL CM CR))

; Every person gets at most one chair
(assert (not (and AL AM)))
(assert (not (and AL AR)))
(assert (not (and AM AR)))

(assert (not (and BL BM)))
(assert (not (and BL BR)))
(assert (not (and BM BR)))

(assert (not (and CL CM)))
(assert (not (and CL CR)))
(assert (not (and CM CR)))

; Every chair gets at most one person
(assert (not (and AL BL)))
(assert (not (and AL CL)))
(assert (not (and BL CL)))

(assert (not (and AM BM)))
(assert (not (and AM CM)))
(assert (not (and BM CM)))

(assert (not (and AR BR)))
(assert (not (and AR CR)))
(assert (not (and BR CR)))

(check-sat)
;(get-model)
