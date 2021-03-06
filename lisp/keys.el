;;
;; Keys configuration
;;

(require 'user-macros)
(require 'custom-functions)
(global-set-key "\C-xc" 'save-buffers-kill-emacs)

(global-set-key [pause] 'kill-this-buffer)
(global-set-key [(meta k)] 'kill-this-buffer)
(global-set-key [(control tab)] 'other-window)
(global-set-key [f6] 'switch-to-other-buffer)
;;(global-set-key [(control \`)] 'switch-to-other-buffer)
(global-set-key [(control shift iso-lefttab)] (lambda () (interactive) (other-window -1)))
(global-set-key [(control z)] 'undo)
(global-set-key [(meta u)] 'undo)
(global-set-key [(control b)] 'ido-switch-buffer)
(global-set-key [(meta \,)] 'ido-switch-buffer)
(global-set-key [(control f)] 'ido-find-file)
(global-set-key [(control o)] 'ido-switch-buffer-other-window)
(global-set-key [f2] 'new-shell)
(global-set-key [(control f2)] 'shell)
(global-set-key [f10] 'call-last-kbd-macro)
(global-set-key [f9] 'compile)
(global-set-key [(alt f9)] 'grep)
(global-set-key [(control f9)] 'grep-find)
(global-set-key [f4] 'next-error)
(global-set-key [f5] 'delete-other-windows)
(global-set-key [(shift f4)] 'previous-error)
(global-set-key [f11] 'kmacro-name-last-macro)
(global-set-key (kbd "<Scroll_Lock>") 'kill-this-buffer)

;; Buffer switching
(global-set-key (kbd "C-1") 'delete-other-windows)
(global-set-key (kbd "C-2") 'split-horizontally-change-other-window)
(global-set-key (kbd "C-3") 'split-vertically-change-other-window)
(global-set-key (kbd "C-0") 'delete-window)
; Let's see which key binding I'll use most...
(global-set-key (kbd "C-~") 'switch-windows)
; (global-set-key [(control f6)] 'switch-windows)

;; C-a is normally C-1, so here we override it
(global-set-key (kbd "C-a") 'beginning-of-line-nomark)

;; sexp switching/marks
(global-set-key [(meta left)] 'backward-sexp)
(global-set-key [(meta right)] 'forward-sexp)
(global-set-key [(meta \;)] 'backward-sexp)
(global-set-key [(meta \')] 'forward-sexp)
(global-set-key [(meta shift left)] 'backward-sexp-mark)
(global-set-key [(meta shift right)] 'forward-sexp-mark)
(global-set-key [(meta \:)] 'backward-sexp-mark)
(global-set-key [(meta \")] 'forward-sexp-mark)
(global-set-key [(meta backspace)] 'backward-kill-word)    ;; Don't deleting the entire sexp; too harmful...

(global-set-key [(control meta left)] 'next-buffer)
(global-set-key [(control meta right)] 'previous-buffer)
(global-set-key [(f1)] 'man)

(global-set-key (kbd "C-SPC") 'dabbrev-expand)

(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-1" 'magit-status)
(global-set-key [(control meta b)] 'toggle-truncate-lines)

;; Smarter shell completion
(define-key shell-mode-map [(control up)] 'comint-previous-matching-input-from-input)
(define-key shell-mode-map [(meta u)] 'comint-previous-matching-input-from-input)
(define-key shell-mode-map [(control down)] 'comint-next-matching-input-from-input)
(define-key shell-mode-map [(meta j)] 'comint-next-matching-input-from-input)

(global-set-key "\M-\\" 'shell-command-on-region-inplace)

(global-set-key (kbd "C-c s") 'search-in-internet)
(global-set-key (kbd "C-c b") 'browse-url)

(global-set-key (kbd "C-c r") 'revert-buffer)

(global-set-key (kbd "M-3") 'comment-region)
(global-set-key (kbd "M-2") 'uncomment-region)
(global-set-key (kbd "M-#") 'uncomment-region) ;; This is actually M-S-3
;; (fset 'post-review
;;    [?p ?o ?s ?t ?- ?r ?e  ?v ?i ?e ?w return ])
;; (global-set-key (kbd "M-r") 'post-review)

;; C-Mode - When pressing on Enter, the next line should be indented. Also, allow to make a newline without indendation.
(require 'cc-mode)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(define-key c-mode-base-map [(shift return)] 'newline)

(fset 'python-breakpoint
   [?i ?m ?p ?o ?r ?t ?  ?p ?d ?b ?\; ?  ?p ?d ?b ?. ?s ?e ?t ?_ ?t ?r ?a ?c ?e ?\( ?\) ])

(require 'python-mode)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
;; Undo the idiotic Python C-backspace, this will be set back to default
(define-key py-mode-map [(control backspace)] nil)
(define-key py-mode-map (kbd "C-p") 'python-breakpoint)

;; C-Scope keys
(define-key c-mode-base-map (kbd "C-c g") 'cscope-find-global-definition)
(define-key c-mode-base-map (kbd "C-c x") 'cscope-find-functions-calling-this-function)

(defun scroll-up-one-line()
  (interactive)
  (scroll-up 1))

(defun scroll-down-one-line()
  (interactive)
  (scroll-down 1))

(defun rackattack()
  (interactive)
  (setq command (read-from-minibuffer "Enter Command (port): " "/usr/bin/sshpass -p \'rackattack\' ssh -o ServerAliveInterval=5 -o ServerAliveCountMax=1 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -L 8083:influxdb.service.strato:8083 -L 8086:influxdb.service.strato:8086 -L 15672:rabbitmq-server.service.strato:15672 root@10.16.3.3 -p "))
  (ansi-term "/bin/bash")
  (term-send-raw-string (format "%s\n" command)))

(global-set-key (kbd "M-q") 'rackattack)

;; XXX overriding default emacs binding?
(global-set-key [(control meta up)] 'scroll-down-one-line)
(global-set-key [(control meta down)] 'scroll-up-one-line)
(global-set-key [(f12)] 'kill-this-buffer)
(global-set-key [(control 1)] 'revert-buffer)
(global-set-key [(control j)] 'bookmark-jump)
(global-set-key [(control /)] 'bookmark-set)
(global-set-key [(control d)] 'save-buffer)
(global-set-key [(control n)] 'rename-buffer)
(global-set-key [(meta \])] 'move-end-of-line)
(global-set-key [(meta \[)] 'move-beginning-of-line)
(global-set-key [(meta b)] 'magit-blame)
;; (global-set-key (kbd "M-q") 'py-autopep8)
(global-set-key (kbd "C-c .") 'jedi:goto-definition)
(global-set-key (kbd "M-.") 'jedi:goto-definition)
(global-set-key (kbd "M-/") 'jedi:goto-definition-pop-marker)
(global-set-key (kbd "M-?") 'jedi:show-doc)
(global-set-key (kbd "C-c ,") 'jedi:goto-definition-pop-marker)
(global-set-key (kbd "C-c /") 'jedi:show-doc)
(global-set-key (kbd "M-4") 'toggle-read-only)
(load "~/.emacs.d/floobits/floobits.el")
(provide 'keys)
