(in-package :ppp/test)

(test test-whitespace
  (is (@eq (parse (whitespace) " 123")
           (result:ok '(" " "123"))))

  (is-false (result:ok? (parse (whitespace) "123")))
  )
;; (run! 'test-whitespace)


(test test-whitespaces
  (is (@eq (parse (whitespaces) "  123")
           (result:ok '((" " " ") "123"))))
  (is-true (result:ok? (parse (whitespaces) "123"))))

;; (run! 'test-whitespaces)
