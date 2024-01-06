(let ((packages '("project/c/"
                  "project/c/pigeon/"
                  "project/c/ppp/")))
  (loop for p in packages
        do (let ((path (merge-pathnames  p (user-homedir-pathname))))
          (pushnew path asdf:*central-registry* :test #'equal))))

