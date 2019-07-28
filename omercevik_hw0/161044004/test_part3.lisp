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

; CSE 341 HW 0 Part 3
; OMER CEVIK 161044004
; That programme returns a list added a new member in an index.
(defun insert-n(liste number index)	 ; Our function gets list, value and the index.
	(if (member number liste)		 ; We check if there is a same value in the list.
		(write "There is  already same number in the list!")		; If in the list we have already same value then we import it. 
		(append (subseq liste 0 index) (list number) (subseq liste index))  ; If it is a new value then we add it into list.
	)
)

;; MAIN FUNCTION
(defun main ()
  (with-open-file (stream #p"input_part3.csv")
    (loop :for line := (read-csv-line stream) :while line :collect
      (format t "~a~%"
      ;; CALL YOUR (MAIN) FUNCTION HERE
      	(insert-n (read-from-string (nth 0 line)) (read-from-string (nth 1 line)) (read-from-string (nth 2 line)))
      )
    )
  )
)

;; CALL MAIN FUNCTION
(main)
