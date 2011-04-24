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
            (org-set-local 'yas/trigger-key [tab])
            (define-key yas/keymap [tab] 'yas/next-field-group)))

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



;;;  Load Org Remember Stuff
(require 'remember)
(org-remember-insinuate)

;; Start clock in a remember buffer and switch back to previous clocking task on save
;; (add-hook 'remember-mode-hook 'org-clock-in 'append)
;; (add-hook 'org-remember-before-finalize-hook 'bh/clock-in-interrupted-task)

;; I use C-M-r to start org-remember
(global-set-key (kbd "C-c m r") 'org-remember)
;; (define-key global-map "\C-cr" 'org-remember)

;; Keep clocks running
(setq org-remember-clock-out-on-exit nil)

;; C-c C-c stores the note immediately
(setq org-remember-store-without-prompt t)

;; I don't use this -- but set it in case I forget to specify a location in a future template
(setq org-remember-default-headline "Tasks")

;; 3 remember templates for TODO tasks, Notes, and Phone calls
(setq org-remember-templates (quote (("todo" ?t "** TODO %?\nCREATED: %U" nil nil nil)
                                     ;; ("note" ?n "* %?                                                                            :NOTE:\n  %U\n  %a\n  :CLOCK:\n  :END:" nil bottom nil)
                                     ;; ("appointment" ?a "* %?\n  %U" "~/git/org/todo.org" "Appointments" nil)
                                     ;; ("org-protocol" ?w "* TODO Review %c%!\n  %U" nil bottom nil))))
                                     )))

;; (defvar org-my-archive-expiry-days 1
;;   "The number of days after which a completed task should be auto-archived.
;; This can be 0 for immediate, or a floating point value.")

;; (defconst org-my-ts-regexp "[[<]\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\} [^]>\r\n]*?\\)[]>]"
;;   "Regular expression for fast inactive time stamp matching.")

;; (defun org-my-closing-time ()
;;   (let* ((state-regexp
;; (concat "- State \"\\(?:" (regexp-opt org-done-keywords)
;; "\\)\"\\s-*\\[\\([^]\n]+\\)\\]"))
;; (regexp (concat "\\(" state-regexp "\\|" org-my-ts-regexp "\\)"))
;; (end (save-excursion
;; (outline-next-heading)
;; (point)))
;; begin
;; end-time)
;;     (goto-char (line-beginning-position))
;;     (while (re-search-forward regexp end t)
;;       (let ((moment (org-parse-time-string (match-string 1))))
;; (if (or (not end-time)
;; (time-less-p (apply #'encode-time end-time)
;; (apply #'encode-time moment)))
;; (setq end-time moment))))
;;     (goto-char end)
;;     end-time))

;; (defun org-my-archive-done-tasks ()
;;   (interactive)
;;   (save-excursion
;;     (goto-char (point-min))
;;     (let ((done-regexp
;; (concat "^\\*\\* \\(" (regexp-opt org-done-keywords) "\\) ")))
;;       (while (re-search-forward done-regexp nil t)
;; (if (>= (time-to-number-of-days
;; (time-subtract (current-time)
;; (apply #'encode-time (org-my-closing-time))))
;; org-my-archive-expiry-days)
;; (org-archive-subtree))))
;;     (save-buffer)))

;; (defalias 'archive-done-tasks 'org-my-archive-done-tasks)


;; (defvar org-my-archive-expiry-days 2
;;   "The number of days after which a completed task should be auto-archived.
;; This can be 0 for immediate, or a floating point value.")

;; (defun org-my-archive-done-tasks ()
;;   (interactive)
;;   (save-excursion
;;     (goto-char (point-min))
;;     (let ((done-regexp
;;            (concat "\\* \\(" (regexp-opt org-done-keywords) "\\) "))
;;           (state-regexp
;;            (concat "- State \"\\(" (regexp-opt org-done-keywords)
;;                    "\\)\"\\s-*\\[\\([^]\n]+\\)\\]")))
;;       (while (re-search-forward done-regexp nil t)
;;         (let ((end (save-excursion
;;                      (outline-next-heading)
;;                      (point)))
;;               begin)
;;           (goto-char (line-beginning-position))
;;           (setq begin (point))
;;           (when (re-search-forward state-regexp end t)
;;             (let* ((time-string (match-string 2))
;;                    (when-closed (org-parse-time-string time-string)))
;;               (if (>= (time-to-number-of-days
;;                        (time-subtract (current-time)
;;                                       (apply #'encode-time when-closed)))
;;                       org-my-archive-expiry-days)
;;                   (org-archive-subtree)))))))))

;; (defalias 'archive-done-tasks 'org-my-archive-done-tasks)


(provide 'wd-org)