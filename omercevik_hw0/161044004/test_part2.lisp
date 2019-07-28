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

; CSE 341 HW 0 Part 2
; OMER CEVIK 161044004
; That programme returns a list that two lists are merged.
(defun merge-list(firstlist secondlist)		  ; It's our merge-list function gets two list parameter.
	(if (null firstlist)					  ; We check if our base case if firstlist is empty.
		(cons secondlist nil)				  ; If first list is at end then we are done with secondlist.
		(cons (car firstlist) (merge-list (cdr firstlist) secondlist)) ; We add secondlist into firstlist recursively.
	)
)

;; MAIN FUNCTION
(defun main ()
  (with-open-file (stream #p"input_part2.csv")
    (loop :for line := (read-csv-line stream) :while line :collect
      (format t "~a~%"
      ;; CALL YOUR (MAIN) FUNCTION HERE
      	(merge-list (read-from-string (nth 0 line)) (read-from-string (nth 1 line)))
      )
    )
  )
)

;; CALL MAIN FUNCTION
(main)
