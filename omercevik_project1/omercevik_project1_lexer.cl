;		CSE 341 Programming Languages
;				  Project 1
;		  G++ Programming Language
;			  Lexical Analyzer
;			     Omer CEVIK
;			     161044004

(setf OPERATORS #(  #\+				; OPERATORS Vector
					#\-
					#\/
					#\)
					#\(
					#\* 
				)
)

(setf KEYWORDS #(  and 				; KEYWORDS Vector
				   or
				   not
				   equal
				   append
				   concat
				   set
				   deffun
				   for
				   while
				   if
				   exit
				)
)

(setf TERMINALS #( true false ))

(setq SPACE 32)				; SPACE ASCII

(defun lexer(filename)		; Main Function
	(setq text (coerce (read-file filename) 'string))		; Reading file.
	(Scanner text)			; Analyze.
)

(defun Scanner(content)		; Analyzer Function
	(setq tokens (list))			; Return list.
	(setq size (length content))	; Readed text length.
	(setq flag t)

	(let ((i 0))
		(loop while (< i size) do 				; Main Loop
			(setq ContentChar (char content i))	; Each character of readed text.

			(cond ((or (alpha_control ContentChar) (digit_control ContentChar))		; DFA step 1: digit or alphabetical character control.
				(setq temp (string ""))
				(let ((j i))
					(loop while (or (alpha_control ContentChar) (digit_control ContentChar)) do 	; Saving the all characters or digits.
						(setq temp (concatenate 'string temp (string ContentChar)))
						(setq j (+ j 1))
						(setq i (+ i 1))
						(setq ContentChar (char content j))
					)
				)
				(cond 																; DFA step 2: Keyword or terminal or non-terminal control. 
					((keyword_control temp) (push (cons "keyword" (list temp)) tokens))	; if the word is keyword, push it.
					((or (string-equal temp "true") (string-equal temp "false")) (push (cons "boolean" (list temp)) tokens)) ; if the word is boolean, push it.
					((digit_control (char temp 0)) (push (cons "integer" (list temp)) tokens)) ; if the word is integer, push it.
					(t (push (cons "identifier" (list temp)) tokens))					; if it is identifier, push it.
				))
			)
			(if (find ContentChar OPERATORS)		; DFA step 3: operator control.
				(cond 
					((and (equal ContentChar #\*)(equal (char content (+ i 1)) #\*))	; if the operator is "**".
						(push (cons "operator" (list "**")) tokens)
						(setq flag nil) (setq i (+ i 1))
					)
					(flag (push (cons "operator" (list (string ContentChar))) tokens)) ; if it is operator, push it.
					(t (setq flag t))
				)
			)
			(setq i (+ i 1))
		)
	)
	(reverse tokens)	; Returning the list.
)

(defun keyword_control(key)	; Keyword Control Function
	(setq flag1 nil)
	(let ((i 0))
		(loop while (< i (length KEYWORDS)) do
			(if (string-equal key (svref KEYWORDS i))
				(setq flag1 t)
			)
			(setq i (+ i 1))
		)
	)
	flag1	; if it is keyword returns true.
)

(defun read-file(filename)		; Read File Function
	(with-open-file (file filename)
		(let ((chars (make-string (file-length file))))
			(read-sequence chars file) chars
		)
	)
)

(defun alpha_control(alpha)		; Alpha Control Function
	(if (or (and (> (char-int alpha) 64) (< (char-int alpha) 91))
			(and (> (char-int alpha) 96) (< (char-int alpha) 123))
		)
		t
		nil
	)
)

(defun digit_control(digit)		; Digit Control Function
	(if (and (> (char-int digit) 47) (< (char-int digit) 58))
		t
		nil
	)
)