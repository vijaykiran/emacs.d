;;
;; sql-mode
;;
(autoload 'Sql-mode "sql-mode" "SQL Mode." t)
(add-to-list 'auto-mode-alist '("\\.sql\\'" . sql-mode))

(eval-after-load "sql"
   (load-library "sql-indent"))
(setq sql-indent-offset 4)


(setq sql-indent-first-column-regexp
  (concat "^\\s-*" (regexp-opt '(
"select" "update" "insert" "delete" "create"
"union" "intersect" "drop" "grant"
"from" "where" "into" "group" "having" "order"
"set" "exists"
"--") t) "\\(\\b\\|\\s-\\)"))



;; following code steal from http://atomized.org/2008/10/enhancing-emacs%E2%80%99-sql-mode/
(defun sql-make-smart-buffer-name ()
  "Return a string that can be used to rename a SQLi buffer.

This is used to set `sql-alternate-buffer-name' within
`sql-interactive-mode'."
  (or (and (boundp 'sql-name) sql-name)
      (concat (if (not(string= "" sql-server))
                  (concat
                   (or (and (string-match "[0-9.]+" sql-server) sql-server)
                       (car (split-string sql-server "\\.")))
                   "/"))
              sql-database)))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (setq sql-alternate-buffer-name (sql-make-smart-buffer-name))
            (sql-rename-buffer)))


(defadvice sql-connect-mysql (around sql-mysql-port activate)
  "Add support for connecting to MySQL on other ports"
  (let ((sql-mysql-options (or (and (boundp 'sql-port) sql-port (cons (concat "-P " (or (and (numberp sql-port) (number-to-string sql-port)) sql-port)) sql-mysql-options)) sql-mysql-options)))
    ad-do-it))

(setq sql-connection-alist
      '((pool-a
         (sql-product 'mysql)
         (sql-server "l-log1.ops.cn1.qunar.com")
         (sql-user "root")
         (sql-password "server251@fangzhuang")
         (sql-database "logstat")
         (sql-port 3306))
        (pool-b
         (sql-product 'mysql)
         (sql-server "1.2.3.4")
         (sql-user "me")
         (sql-password "mypassword")
         (sql-database "thedb")
         (sql-port 3307))))

(defun sql-connect-preset (name)
  "Connect to a predefined SQL connection listed in `sql-connection-alist'"
  (eval `(let ,(cdr (assoc name sql-connection-alist))
    (flet ((sql-get-login (&rest what)))
      (sql-product-interactive sql-product)))))

(defun sql-pool-a ()
  (interactive)
  (sql-connect-preset 'pool-a))

(provide 'wd-sql)
