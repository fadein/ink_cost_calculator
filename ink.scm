(use fmt)


(define *mL-per-oz* 29.5735295625) 
(define (oz->mL oz) (* oz *mL-per-oz*))
(define (mL->oz mL) (* mL (/ *mL-per-oz*)))


(define *noodlers-bottle-cost* 12.50)
(define *noodlers-bottle-volume* (oz->mL 3))
(define noodlers-per-mL (/ *noodlers-bottle-cost* *noodlers-bottle-volume*))

(define *diamine-bottle-cost* 14.95)
(define *diamine-bottle-volume* 80)
(define diamine-per-mL (/ *diamine-bottle-cost* *diamine-bottle-volume*))

(define *montblanc-bottle-cost* 19.00)
(define *montblanc-bottle-volume* 60)
(define montblanc-per-mL (/ *montblanc-bottle-cost* *montblanc-bottle-volume*))

(define *pelikan-edelstein-cost-sale* (* .85 25.20))
(define *pelikan-edelstein-cost* 28)
(define *pelikan-edelstein-volume* 50)
(define edelstein-per-mL (/ *pelikan-edelstein-cost-sale* *pelikan-edelstein-volume*))

(fmt #t "Noodler's is $" (fix 3 noodlers-per-mL) " per mL" nl)
(fmt #t "Diamine   is $" (fix 3 diamine-per-mL ) " per mL" nl)
(fmt #t "Montblanc is $" (fix 3 montblanc-per-mL) " per mL" nl)
(fmt #t "Edelstein is $" (fix 3 (/ *pelikan-edelstein-cost-sale* *pelikan-edelstein-volume*)) " per mL on sale" nl)
(fmt #t "Edelstein is $" (fix 3 (/ *pelikan-edelstein-cost* *pelikan-edelstein-volume*)) " per mL regular" nl)
