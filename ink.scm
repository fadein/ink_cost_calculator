#!/usr/local/bin/csi -s

(use fmt)

(define *mL-per-oz* 29.5735295625) 
(define (oz->mL oz) (* oz *mL-per-oz*))
(define (mL->oz mL) (* mL (/ *mL-per-oz*)))

(define-record bottle
			   brand
			   volume unit
			   price)

(define (normalize-volume ink output-unit)
  (cond
	((equal? (bottle-unit ink) output-unit)
	 (bottle-volume ink))
	((equal? output-unit 'mL)
	 (oz->mL (bottle-volume ink)))
	(else
	  (mL->oz (bottle-volume ink)))))

(define (price-per ink #!optional (output-unit 'mL))
  (/ (bottle-price ink) (normalize-volume ink output-unit)))

(define (ink-price-printer ink #!optional (output-unit 'mL))
  (fmt #t (bottle-brand ink) " is $"
	   (fix 2 (/ (bottle-price ink) (normalize-volume ink output-unit)))
	   " per " output-unit nl))


(define (compare-per-vol left right rel)
  (rel (/ (bottle-price left) (normalize-volume left 'mL))
	 (/ (bottle-price right) (normalize-volume right 'mL))))

(define (cheapest-per-vol left right)
  (compare-per-vol left right <))

(define (most-expensive-per-vol left right)
  (compare-per-vol left right >))


(let ((unit 'mL))
  (for-each (lambda (ink) (ink-price-printer ink unit))
			(sort
			  (list

				(make-bottle
				  "Noodler's"
				  3 'oz
				  12.50)

				(make-bottle
				  "Noodler's 1 oz"
				  1 'oz
				  13.50)

				(make-bottle
				  "Diamine Registrars"
				  30 'mL
				  16.95)

				(make-bottle
				  "Diamine Registrars 100mL"
				  100 'mL
				  33.95)


				(make-bottle
				  "Diamine"
				  80 'mL
				  14.95)

				(make-bottle
				  "Montblanc"
				  60 'mL
				  19.00)

				(make-bottle
				  "Pelikan Edelstein"
				  50 'mL
				  24.00)

				#;(make-bottle
				  "Pelikan Edelstein (on sale)"
				  50 'mL
				  (* .85 25.20))

				(make-bottle
				  "Pelikan 4001"
				  2 'oz
				  13.00)

				(make-bottle
				  "Platinum Mix-Free"
				  60 'mL
				  20.00)

				(make-bottle
				  "Rohrer & Klingner"
				  50 'mL
				  11.95)

				(make-bottle
				  "Shaeffer"
				  50 'mL
				  9.00)

				(make-bottle
				  "Stipula"
				  70 'mL
				  25.00)

				(make-bottle
				  "Visconti"
				  40 'mL
				  17.50)

				(make-bottle
				  "Waterman"
				  50 'mL
				  12.00)

				(make-bottle
				  "LAMY"
				  50 'mL
				  10.50)

				(make-bottle
				  "Montegrappa"
				  42 'mL
				  20.00)

				(make-bottle
				  "Monteverde"
				  90 'mL
				  12.50)

				(make-bottle
				  "Parker Quink"
				  2 'oz
				  12.00)

				(make-bottle
				  "De Atramentis"
				  35 'mL
				  12.95)

				(make-bottle
				  "De Atramentis Document Ink"
				  35 'mL
				  19.95)

				(make-bottle
				  "Caran D'Ache"
				  50 'mL
				  33.20)

				(make-bottle
				  "J. Herbin 30mL"
				  30 'mL
				  11.00)

				(make-bottle
				  "J. Herbin 50mL"
				  50 'mL
				  26.00)

				(make-bottle
				  "J. Herbin 100mL"
				  100 'mL
				  22.00)

				(make-bottle
				  "Omas"
				  62 'mL
				  15.50)

				(make-bottle
				  "Faber-Castell"
				  75 'mL
				  30.00)

				(make-bottle
				  "Kaweco"
				  30 'mL
				  14.00)

				(make-bottle
				  "Pilot Namiki"
				  60 'mL
				  12.00)

				(make-bottle
				  "Pilot Iroshizuku"
				  50 'mL
				  28.00)

				(make-bottle
				  "Aurora"
				  45 'mL
				  18.00)

				(make-bottle
				  "Private Reserve"
				  66 'mL
				  11.00)
				)

			  most-expensive-per-vol
			  )))
