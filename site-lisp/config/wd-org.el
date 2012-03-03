;;
;; org-mode
;;

;; (setq org-agenda-files '("~/org"))
(setq org-agenda-files (file-expand-wildcards "~/org/*.org"))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(add-hook 'org-mode-hook
  (lambda ()
    (define-key org-mode-map "\C-a" 'move-beginning-of-line)
    (define-key org-mode-map "\C-e" 'move-end-of-line)
    (setq truncate-lines nil)
))

(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
          (lambda ()
            ;; yasnippet (using the new org-cycle hooks)
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)))

;; (defun wd-move-done-task-to-done-cats ( task-pos )
;;   "auto move done task to *DONE cats"
;;   (message (format "from is TODO, to is DONE, pos %s" task-pos))
;;   (let ((entry (org-get-entry)))
;;     (message (format "entry is : %s" entry))
;;   ))

;; (defun wd-track-task-status ( changes-plist )
;;    "auto move done tasks to *DONE cats"
;;    (interactive)
;;    (let ((type (plist-get change-plist :type))
;;           (pos (plist-get change-plist :position))
;;           (from (plist-get change-plist :from))
;;           (to (plist-get change-plist :to)))
;;      ;; (org-log-done nil) ; IMPROTANT!: no logging during automatic trigger!
;;      (if (and (string= from "TODO")
;;               (string= to "DONE"))
;;          (wd-move-done-task-to-done-cats pos)
;;        )
;;      (message (format "type:%s  pos:%s  from:%s  to:%s" type pos from to))
;;    )
;; )

;; (add-hook 'org-trigger-hook 'wd-track-task-status)


(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))


(setq org-default-notes-file "~/org/todo.org")
(setq org-agenda-ndays 10
      org-deadline-warning-days 14
      org-agenda-show-all-dates t)



;; ;;;  Load Org Remember Stuff
;; (require 'remember)
;; (org-remember-insinuate)

;; ;; Start clock in a remember buffer and switch back to previous clocking task on save
;; ;; (add-hook 'remember-mode-hook 'org-clock-in 'append)
;; ;; (add-hook 'org-remember-before-finalize-hook 'bh/clock-in-interrupted-task)

;; I use C-M-r to start org-remember
;; (global-set-key (kbd "C-c m r") 'org-remember)
(global-set-key (kbd "C-c m r") 'org-capture)
;; (define-key global-map "\C-cr" 'org-remember)

;; ;; Keep clocks running
;; (setq org-remember-clock-out-on-exit nil)

;; C-c C-c stores the note immediately
;; (setq org-remember-store-without-prompt t)

;; I don't use this -- but set it in case I forget to specify a location in a future template
;; (setq org-remember-default-headline "Tasks")

;; 3 remember templates for TODO tasks, Notes, and Phone calls
;; (setq org-remember-templates (quote (("todo" ?t "** TODO %?\nCREATED: %U" nil nil nil)
;;                                      ;; ("note" ?n "* %?                                                                            :NOTE:\n  %U\n  %a\n  :CLOCK:\n  :END:" nil bottom nil)
;;                                      ;; ("appointment" ?a "* %?\n  %U" "~/git/org/todo.org" "Appointments" nil)
;;                                      ;; ("org-protocol" ?w "* TODO Review %c%!\n  %U" nil bottom nil))))
;;                                      )))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
         "* TODO %?\nCREATED: %U")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

;; ;; (defvar org-my-archive-expiry-days 1
;; ;;   "The number of days after which a completed task should be auto-archived.
;; ;; This can be 0 for immediate, or a floating point value.")

;; ;; (defconst org-my-ts-regexp "[[<]\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\} [^]>\r\n]*?\\)[]>]"
;; ;;   "Regular expression for fast inactive time stamp matching.")

;; ;; (defun org-my-closing-time ()
;; ;;   (let* ((state-regexp
;; ;; (concat "- State \"\\(?:" (regexp-opt org-done-keywords)
;; ;; "\\)\"\\s-*\\[\\([^]\n]+\\)\\]"))
;; ;; (regexp (concat "\\(" state-regexp "\\|" org-my-ts-regexp "\\)"))
;; ;; (end (save-excursion
;; ;; (outline-next-heading)
;; ;; (point)))
;; ;; begin
;; ;; end-time)
;; ;;     (goto-char (line-beginning-position))
;; ;;     (while (re-search-forward regexp end t)
;; ;;       (let ((moment (org-parse-time-string (match-string 1))))
;; ;; (if (or (not end-time)
;; ;; (time-less-p (apply #'encode-time end-time)
;; ;; (apply #'encode-time moment)))
;; ;; (setq end-time moment))))
;; ;;     (goto-char end)
;; ;;     end-time))

;; ;; (defun org-my-archive-done-tasks ()
;; ;;   (interactive)
;; ;;   (save-excursion
;; ;;     (goto-char (point-min))
;; ;;     (let ((done-regexp
;; ;; (concat "^\\*\\* \\(" (regexp-opt org-done-keywords) "\\) ")))
;; ;;       (while (re-search-forward done-regexp nil t)
;; ;; (if (>= (time-to-number-of-days
;; ;; (time-subtract (current-time)
;; ;; (apply #'encode-time (org-my-closing-time))))
;; ;; org-my-archive-expiry-days)
;; ;; (org-archive-subtree))))
;; ;;     (save-buffer)))

;; ;; (defalias 'archive-done-tasks 'org-my-archive-done-tasks)


;; ;; (defvar org-my-archive-expiry-days 2
;; ;;   "The number of days after which a completed task should be auto-archived.
;; ;; This can be 0 for immediate, or a floating point value.")

;; ;; (defun org-my-archive-done-tasks ()
;; ;;   (interactive)
;; ;;   (save-excursion
;; ;;     (goto-char (point-min))
;; ;;     (let ((done-regexp
;; ;;            (concat "\\* \\(" (regexp-opt org-done-keywords) "\\) "))
;; ;;           (state-regexp
;; ;;            (concat "- State \"\\(" (regexp-opt org-done-keywords)
;; ;;                    "\\)\"\\s-*\\[\\([^]\n]+\\)\\]")))
;; ;;       (while (re-search-forward done-regexp nil t)
;; ;;         (let ((end (save-excursion
;; ;;                      (outline-next-heading)
;; ;;                      (point)))
;; ;;               begin)
;; ;;           (goto-char (line-beginning-position))
;; ;;           (setq begin (point))
;; ;;           (when (re-search-forward state-regexp end t)
;; ;;             (let* ((time-string (match-string 2))
;; ;;                    (when-closed (org-parse-time-string time-string)))
;; ;;               (if (>= (time-to-number-of-days
;; ;;                        (time-subtract (current-time)
;; ;;                                       (apply #'encode-time when-closed)))
;; ;;                       org-my-archive-expiry-days)
;; ;;                   (org-archive-subtree)))))))))

;; ;; (defalias 'archive-done-tasks 'org-my-archive-done-tasks)

;; (add-hook 'org-mode-hook 'soft-wrap-lines)


(defun soft-wrap-lines ()
  "Make lines wrap at window edge and on word boundary,
in current buffer."
  (interactive)
  (setq truncate-lines nil)
  (setq word-wrap t)
  )

(setq org-src-fontify-natively t)

;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/todo.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")

(defun my-org-convert-incoming-items ()
  (interactive)
  (with-current-buffer (find-file-noselect org-mobile-inbox-for-pull)
    (goto-char (point-min))
    (while (re-search-forward "^\\* " nil t)
      (goto-char (match-beginning 0))
      (insert ?*)
      (forward-char 2)
      (insert "TODO ")
      (goto-char (line-beginning-position))
      (forward-line)
      (insert
       (format
        " SCHEDULED: %s
:PROPERTIES:
:ID: %s :END:
"
        (with-temp-buffer (org-insert-time-stamp (current-time)))
        (shell-command-to-string "uuidgen"))))
    (let ((tasks (buffer-string)))
      (erase-buffer)
      (save-buffer)
      (kill-buffer (current-buffer))
      (with-current-buffer (find-file-noselect "~/org/todo.org")
        (save-excursion
          (goto-char (point-min))
          (search-forward "* Tasks")
          (goto-char (match-beginning 0))
          (insert tasks))))))
 
;; (add-hook 'org-mobile-post-pull-hook 'my-org-convert-incoming-items)

(provide 'wd-org)
