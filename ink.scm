#!/usr/local/bin/csi -s

(use fmt)

(define *mL-per-oz* 29.5735295625) 
(define (oz->mL oz) (* oz *mL-per-oz*))
(define (mL->oz mL) (* mL (/ *mL-per-oz*)))

(define-record bottle
			   brand
			   volume unit
			   price)

(define (ink-price-printer ink)
  (let ((norm-volume (if (equal? (bottle-unit ink) 'ml)
					   (bottle-volume ink)
					   (oz->mL (bottle-volume ink)))))

	(fmt #t (bottle-brand ink) " is $" (fix 3 (/ (bottle-price ink) norm-volume)) " per mL" nl)))


(define noodlers (make-bottle
				   "Noodler's"
				   3 'oz
				   12.50))

(define diamine (make-bottle
				  "Diamine"
				  80 'ml
				  14.95))

(define montblanc (make-bottle
					"Montblanc"
					60 'ml
					19.00))

(define edelstein (make-bottle
					"Pelikan Edelstein"
					50 'ml
					28.00))

(define edelstein-sale (make-bottle
					"Pelikan Edelstein (on sale)"
					50 'ml
					(* .85 25.20)))

(ink-price-printer noodlers)
(ink-price-printer diamine)
(ink-price-printer montblanc)
(ink-price-printer edelstein)
(ink-price-printer edelstein-sale)
