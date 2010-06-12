;;
;; sql-mode
;;
(autoload 'Sql-mode "sql-mode" "SQL Mode." t)
(add-to-list 'auto-mode-alist '("\\.sql\\'" . sql-mode))
;; (require 'plsql)

;; (setq auto-mode-alist
;;       (append
;;        '(("\\.\\(p\\(?:k[bg]\\|ls\\)\\|sql\\)\\'" . plsql-mode))
;;        auto-mode-alist))


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


(setq sql-mysql-options '("-A"))

(defadvice sql-connect-mysql (around sql-mysql-port activate)
  "Add support for connecting to MySQL on other ports"
  (let ((sql-mysql-options (or (and (boundp 'sql-port) sql-port (cons (concat "-P " (or (and (numberp sql-port) (number-to-string sql-port)) sql-port)) sql-mysql-options)) sql-mysql-options)))
    ad-do-it))

(load "~/.emacs.d/sql-servers")

(defun sql-connect-preset (name)
  "Connect to a predefined SQL connection listed in `sql-connection-alist'"
  (eval `(let ,(cdr (assoc name sql-connection-alist))
    (flet ((sql-get-login (&rest what)))
      (sql-product-interactive sql-product)))))

(defun sql-pool-a ()
  (interactive)
  (sql-connect-preset 'pool-a))


(defun sql-tidy-region (beg end)
  "Beautify SQL in region between beg and END."
  (interactive "r")
  (save-excursion
    (shell-command-on-region beg end "sqltidy")))

(defun sql-tidy-buffer ()
 "Beautify SQL in buffer."
 (interactive)
 (sql-tidy-region (point-min) (point-max)))


(provide 'wd-sql)
