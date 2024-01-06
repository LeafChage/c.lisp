(in-package ppp/test)

(test |check|
  (is (@eq (parse (check (digit)
                        (lambda (v)(string= v "1") )) "1hello")
           (result:ok '("1" "hello"))))

  (is (@eq (parse (check (digit)
                  (lambda (v)(string= v "2") )) "1hello")
           (result:err "failed check")))

  (is-false (result:ok? (parse (check (letter)
                                      (lambda (v)(string= v "1") )) "1hello"))))

(run! '|check|)
;; (print (parse (check (digit)
;;                      (lambda (v) (string= v "2")))
;;               "235"))
;;
;; (print (parse (check (digit)
;;                      (lambda (v) (string= v "2")))
;;               "345"))
;;
;; (print (parse (check (digit)
;;                      (lambda (v) (string= v "2")))
;;               "hello"))
