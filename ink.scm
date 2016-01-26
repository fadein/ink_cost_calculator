#!/usr/local/bin/csi -s

(use fmt)

(define *mL-per-oz* 29.5735295625) 
(define (oz->mL oz) (* oz *mL-per-oz*))
(define (mL->oz mL) (* mL (/ *mL-per-oz*)))

(define-record bottle
			   brand
			   volume unit
			   price)

(define (ink-price-printer ink #!optional (output-unit 'mL))
  (let ((norm-volume (cond
					   ((equal? (bottle-unit ink) output-unit)
						(bottle-volume ink))
					   ((equal? output-unit 'mL)
						(oz->mL (bottle-volume ink)))
					   (else
						 (mL->oz (bottle-volume ink))))))

	(fmt #t (bottle-brand ink) " is $" (fix 3 (/ (bottle-price ink) norm-volume)) " per " output-unit nl)))


(define noodlers (make-bottle
				   "Noodler's"
				   3 'oz
				   12.50))

(define diamine (make-bottle
				  "Diamine"
				  80 'mL
				  14.95))

(define montblanc (make-bottle
					"Montblanc"
					60 'mL
					19.00))

(define edelstein (make-bottle
					"Pelikan Edelstein"
					50 'mL
					28.00))

(define edelstein-sale (make-bottle
					"Pelikan Edelstein (on sale)"
					50 'mL
					(* .85 25.20)))

(define deatrimentis (make-bottle
					   "De Atramentis"
					   35 'mL
					   12.95))

(let ((unit 'mL))
  (ink-price-printer noodlers unit)
  (ink-price-printer diamine unit)
  (ink-price-printer montblanc unit)
  (ink-price-printer edelstein unit)
  (ink-price-printer edelstein-sale unit)
  (ink-price-printer deatrimentis unit))
