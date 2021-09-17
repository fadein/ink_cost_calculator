#!/usr/local/bin/csi -s

(import
  fmt
  (chicken sort))

(define (help)
(print #<<USAGE

This message can be repeated with `(help)`

Unit conversions:
  `oz->mL`
  `mL->oz`

Inks are represented as `bottle` records, with accessors:
  `bottle-brand`
  `bottle-volume`
  `bottle-unit`
  `bottle-price`

The inks I know about are in the list `inks`
`sort-inks` will render this list readable, sorted along various lines, such as
  `cheapest-per-vol`
  `most-expensive-per-vol`


USAGE
))
(help)

;; utility functions to convert milliliters to ounces and vice-versa
(define oz->mL #f)
(define mL->oz #f)
(let ((mL-per-oz 29.5735295625))
  (set! oz->mL (lambda (oz) (* oz mL-per-oz)))
  (set! mL->oz (lambda (mL) (* mL (/ mL-per-oz)))))

;; Record type (aka struct) for a bottle of liquid
(define-record bottle
			   brand            ;; String
			   volume unit      ;; Number and a symbol, either mL or oz
			   price)           ;; Number

;; Express a bottle's volume in the user's preferred units, regardless
;; of how the volume is stored.  I suppose I could have normalized the volume
;; through a setter function at the time of the record's creation...
(define (normalize-volume ink output-unit)
  (cond
	((equal? (bottle-unit ink) output-unit)
	 (bottle-volume ink))
	((equal? output-unit 'mL)
	 (oz->mL (bottle-volume ink)))
	(else
	  (mL->oz (bottle-volume ink)))))

;; Given a bottle, print it's name and its price-per-unit-volume
;; Defaults to milliliters
(define (ink-price-printer ink #!optional (output-unit 'mL))
  (fmt #t
       (bottle-brand ink)
       " ("
       (bottle-volume ink)
       (bottle-unit ink)
       ") is $"
	   (fix 2 (/ (bottle-price ink) (normalize-volume ink output-unit)))
	   " per "
       output-unit))

(set-record-printer! bottle
                     (lambda (bottle out) (ink-price-printer bottle)))

;; A generic comparator - the user supplies the relation
(define (compare-per-vol left right rel)
  (rel (/ (bottle-price left) (normalize-volume left 'mL))
	 (/ (bottle-price right) (normalize-volume right 'mL))))

;; comparator Curried with less-than relation
(define (cheapest-per-vol left right)
  (compare-per-vol left right <))

;; comparator Curried with greater-than relation
(define (most-expensive-per-vol left right)
  (compare-per-vol left right >))

;; Compute the cost of the bottle per unit volume
;; Defaults to milliliters
(define (price-per ink #!optional (output-unit 'mL))
  (/ (bottle-price ink) (normalize-volume ink output-unit)))


;; Now that we have the utilities out of the way, let's run some data through it
(define (sorted-inks inks #!key (sorted-by most-expensive-per-vol))
  (sort inks sorted-by))

(define (print-sorted-inks inks #!key (sorted-by most-expensive-per-vol))
  (for-each print (sorted-inks inks sorted-by)))


(define inks
  (list
    (make-bottle
      "De Atramentis Johann Sebastian Bach"
      45 'mL
      14.00)

    (make-bottle
      "De Atramentis Document Ink"
      45 'mL
      19.95)

    (make-bottle
      "De Atramentis Lavender Scented"
      45 'mL
      15.00)


    (make-bottle
      "Diamine"
      30 'mL
      7.50)

    (make-bottle
      "Diamine"
      50 'mL
      20.00)

    (make-bottle
      "Diamine"
      80 'mL
      14.95)


    (make-bottle
      "Noodler's"
      4.5 'oz
      19.00)

    (make-bottle
      "Noodler's"
      3 'oz
      12.50)

    (make-bottle
      "Noodler's"
      1 'oz
      13.50)


    #;(make-bottle
      "Montblanc"
      60 'mL
      19.00)


    (make-bottle
      "Pelikan Edelstein"
      50 'mL
      28.00)

    (make-bottle
      "Pelikan 4001"
      2 'oz
      15.00)


    (make-bottle
      "Pilot Iroshizuku"
      50 'mL
      22.40)

    (make-bottle
      "Pilot Namiki Blue"
      60 'mL
      12.00)


    (make-bottle
      "Platinum Carbon Black"
      60 'mL
      30.00)

    (make-bottle
      "Platinum Blue-Black"
      60 'mL
      25.00)


    (make-bottle
      "Rohrer & Klingner"
      50 'mL
      11.95)

    #;(make-bottle
      "Shaeffer"
      50 'mL
      9.00)

    #;(make-bottle
      "Stipula"
      70 'mL
      25.00)

    #;(make-bottle
      "Visconti"
      40 'mL
      17.50)

    #;(make-bottle
      "Waterman"
      50 'mL
      12.00)

    (make-bottle
      "LAMY"
      50 'mL
      10.50)

    #;(make-bottle
      "Montegrappa"
      42 'mL
      20.00)

    #;(make-bottle
      "Monteverde"
      90 'mL
      12.50)

    #;(make-bottle
      "Parker Quink"
      2 'oz
      12.00)

    (make-bottle
      "Caran D'Ache"
      50 'mL
      33.20)

    (make-bottle
      "J. Herbin"
      30 'mL
      11.00)

    (make-bottle
      "J. Herbin"
      50 'mL
      26.00)

    (make-bottle
      "J. Herbin"
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
      20.00)

    (make-bottle
      "Private Reserve - Black Cherry"
      60 'mL
      15.00)

    (make-bottle
      "Private Reserve - Sherwood Gren"
      60 'mL
      18.00)

    (make-bottle
      "Robert Oster"
      50 'mL
      17.00)

    (make-bottle
      "Robert Oster - Silver Fire & Ice"
      50 'mL
      24.00)

    (make-bottle
      "Sailor Ink Studio 767"
      20 'mL
      18.00)

    (make-bottle
      "Sailor Manyo Ukikusa"
      50 'mL
      24.00)
    ))


(define sailor
  (list
    (make-bottle
      "Sailor Ink Studio 767 - Goulet"
      20 'mL
      18.00)

    (make-bottle
      "Sailor Manyo Ukikusa - Goulet"
      50 'mL
      24.00)

    (make-bottle
      "Sailor Ink Studio 224 - eBay"
      0.7 'oz
      16.26)

    ))

(define green
  (list
    (make-bottle
      "Pelikan Edelstein Olivine"
      50 'mL
      28)

    (make-bottle
      "Rohrer & Klingner Alt-Goldgrun"
      50 'mL
      11.95)

    (make-bottle
      "De Atramentis Edgar Allan Poe"
      45 'mL
      14)

    (make-bottle
      "Pilot Iroshizuku Shin-ryoku"
      50 'mL
      22.40)

    (make-bottle
      "Sailor Ink Studio 967"
      20 'mL
      18)

    (make-bottle
      "Sailor Waka-uguisu"
      20 'mL
      15)

    (make-bottle
      "Platinum Classic Forest Black"
      60 'mL
      30)
    ))
