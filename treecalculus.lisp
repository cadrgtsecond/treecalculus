;;; Tree calculus

;;; The trees of tree calculus are here represented as lists of 0-3 elements. A 3-element
;;; list is a program, a 2-element list is data.
;;; If the list is a program, then the first element must be a list

(ql:quickload 'trivia)

(defun rewrite (term)
  (cond
    ((or (atom term) (atom (car term))) term)
    ((= (length term) 3)
      (trivia:match term
        ((list '() y z) y)
        ((list (list x) y z)
          (let ((z (rewrite z)))
            (rewrite `(,y ,z (,x ,z)))))
        ((list (list w x) y z) `(,z ,w ,x))))
    (t (mapcar 'rewrite term))))

#+nil
(rewrite '(() 10 20))

#+nil
(rewrite '((+) 10 20))
