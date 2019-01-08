(use-package company :ensure t)

;;(setq company-minimum-prefex-length 3)

;; do I need this? tsoding
;;(global-company-mode)

(setq company-tooltip-limit 20)                      ; bigger popup window

(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
;; (setq company-idle-delay nil)					;; no auto popup
;; bind key if no auto popup
;; (global-set-key (kbd "C-c M-n") 'company-complete)
;; (global-set-key (kbd "C-c C-n") 'company-complete)
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

