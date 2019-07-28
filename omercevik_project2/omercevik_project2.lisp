;		CSE 341 Programming Languages
;				  Project 2
;		  G++ Programming Language
;			  	   Parser
;			     Omer CEVIK
;			     161044004

(load "lexer.cl")

(defun parser(liste)
	(with-open-file (stream "161044004.tree"
                     :direction :output
                     :if-exists :supersede
                     :if-does-not-exist :create)

	(format stream "; DIRECTIVE: parse tree~%~%START~%")
	(format stream "~aINPUT~%" #\Tab)

	(cond
		((or (string-equal (caadr liste) "identifier" )(string-equal (second (cadr liste)) "+" )(string-equal (second (cadr liste)) "-" )
			 (string-equal (second (cadr liste)) "*" )(string-equal (second (cadr liste)) "/" )(string-equal (second (cadr liste)) "while" )
			 (string-equal (second (cadr liste)) "deffun" )(string-equal (second (cadr liste)) "set" )(string-equal (second (cadr liste)) "defvar" )
			 (string-equal (second (cadr liste)) "integer" )(string-equal (second (cadr liste)) "if" )
			 (string-equal (second (cadr liste)) "for" )) (format stream "~a~aEXPI~%" #\Tab #\Tab) )
		(t (format stream "~a~aEXPLISTI~%" #\Tab #\Tab))
	)

	(parserLoop liste 2 stream)

	(close stream))
)

(defun parserLoop(liste counter stream)
	(cond (liste 
		(cond ((string-equal (second (car liste)) "(" ) (setq counter (+ counter 1))))

  		(setq tempCounter counter)

  		(TabPrinter tempCounter stream)

  		(cond
			((or (string-equal (second (cadr liste)) "+" )(string-equal (second (cadr liste)) "-" )
				 (string-equal (second (cadr liste)) "*" )(string-equal (second (cadr liste)) "/" )
				 (string-equal (second (cadr liste)) "set" )(string-equal (second (cadr liste)) "defvar" )
				 (string-equal (second (cadr liste)) "while" )(string-equal (second (cadr liste)) "for" ))
				 (format stream "EXPI~%") (TabPrinter tempCounter stream))
		)

		(cond
			((or (and (string-equal (caar liste) "keyword")(string-equal (second (cadr liste)) "null" ))
				 (and (string-equal (caar liste) "keyword")(string-equal (second (cadr liste)) "'()" ))
				 (and (string-equal (caar liste) "keyword")(string-equal (second (cadr liste)) "'(" ))
				 (and (string-equal (caar liste) "keyword")(string-equal (second (cadr liste)) "concat" ))
				 (and (string-equal (caar liste) "keyword")(string-equal (second (cadr liste)) "append" )))
				 (format stream "EXPLISTI~%") (TabPrinter tempCounter stream))
		)

  		(cond
			((and (string-equal (caar liste) "identifier") (string-equal (caar (cdr liste)) "identifier"))
			(format stream "IDLIST~%")(TabPrinter (+ 1 tempCounter) stream))
			((and (string-equal (caar liste) "identifier") (string-equal (second (car (cdr liste))) ")"))
			(format stream "IDLIST~%")(TabPrinter (+ 1 tempCounter) stream))
  		)

  		(cond
			((string-equal (caar liste) "identifier") (format stream "ID~%") (TabPrinter (+ 1 tempCounter) stream))
		)

		(cond
			((string-equal (caar liste) "integer")
			(format stream "EXPI~%") (TabPrinter (+ 1 tempCounter) stream)
			(format stream "VALUES~%") (TabPrinter (+ 2 tempCounter) stream)
			(format stream "IntegerValue~%") (TabPrinter (+ 3 tempCounter) stream))
			((string-equal (caar liste) "boolean") (format stream "EXPB~%")
			(TabPrinter (+ 1 tempCounter) stream)(format stream "BinaryValue~%") (TabPrinter tempCounter stream))
		)

		(format stream "~a~%" (second (car liste)))

		(cond
  			((or (string-equal (second (car liste)) "+") (string-equal (second (car liste)) "-") (string-equal (second (car liste)) "*")
  				(string-equal (second (car liste)) "/")) (TabPrinter tempCounter stream)(format stream "EXPI~%"))
  		)

		(cond 
			((and (string-equal (second (car liste)) "equal") (string-equal (caadr liste) "identifier"))
				(TabPrinter tempCounter stream)(format stream "EXPI~%")(TabPrinter 1 stream))
			((string-equal (second (car liste)) "equal") (TabPrinter tempCounter stream)(format stream "EXPB~%"))
		)
		
		(cond 
			((or (string-equal (second (car liste)) "and" ) (string-equal (second (car liste)) "or" ) (string-equal (second (car liste)) "not" ) 
				 (string-equal (second (car liste)) "if" ))(TabPrinter tempCounter stream)(format stream "EXPB~%") )
		)
		
		(cond
			((and (string-equal (caar liste) "identifier") (string-equal (second (car (cdr liste))) "("))
			(TabPrinter tempCounter stream) (format stream "IDLIST~%") )
		)

		(cond ((and (string-equal (second (car liste)) ")") (string-equal (second (car (cdr liste))) "(")
			(or (string-equal (second (car (cddr liste))) "if")(string-equal (second (car (cddr liste))) "concat")))
  			(TabPrinter (- tempCounter 1) stream)(format stream "EXPLISTI~%"))
			((and (string-equal (second (car liste)) ")") (string-equal (second (car (cdr liste))) "("))
  			(TabPrinter (- tempCounter 1) stream)(format stream "EXPB~%"))
  		)

  		(cond ((and (string-equal (second (car liste)) ")") (string-equal (caar (cdr liste)) "integer"))
  			(TabPrinter (- tempCounter 1) stream)(format stream "EXPLISTI~%"))
  		)

  		(cond ((and (string-equal (caar liste) "integer") (string-equal (caar (cdr liste)) "integer"))
  			(TabPrinter counter stream)(format stream "EXPLISTI~%"))
  		)

		(cond ((string-equal (second (car liste)) ")") (setq counter (- counter 1))))

		(parserLoop (cdr liste) counter stream)
	  )
	)
)

(defun TabPrinter(counter stream)
	(cond ((> counter 0) (format stream "~a" #\Tab) (TabPrinter (- counter 1) stream)))
)