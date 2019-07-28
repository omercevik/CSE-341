(load "csv-parser.lisp")
(in-package :csv-parser)

;; (read-from-string STRING)
;; This function converts the input STRING to a lisp object.
;; In this code, I use this function to convert lists (in string format) from csv file to real lists.

;; (nth INDEX LIST)
;; This function allows us to access value at INDEX of LIST.
;; Example: (nth 0 '(a b c)) => a

;; !!! VERY VERY VERY IMPORTANT NOTE !!!
;; FOR EACH ARGUMENT IN CSV FILE
;; USE THE CODE (read-from-string (nth ARGUMENT-INDEX line))
;; Example: (mypart1-funct (read-from-string (nth 0 line)) (read-from-string (nth 1 line)))

;; DEFINE YOUR FUNCTION(S) HERE

; CSE 341 HW 0 Part 1
; OMER CEVIK 161044004
; That programme returns a list which doesn't have nested lists.
(defun list-leveller(liste)	; Our function gets a list parameter.
	(cond 					; I use cond condition.
		((null liste) nil)	; We check if our list is empty then returns nil.
    	((atom liste) (list liste))	; We check if list has nested list, then we make it atomic lists.
    	(t (append (list-leveller (car liste)) (list-leveller (cdr liste)))) ; Then we append first list element into the list cdr of list recursively.
    )
)

;; MAIN FUNCTION
(defun main ()
  (with-open-file (stream #p"input_part1.csv")
    (loop :for line := (read-csv-line stream) :while line :collect
      (format t "~a~%"
      ;; CALL YOUR (MAIN) FUNCTION HERE
      	(list-leveller (read-from-string (nth 0 line)))
      )
    )
  )
)

;; CALL MAIN FUNCTION
(main)