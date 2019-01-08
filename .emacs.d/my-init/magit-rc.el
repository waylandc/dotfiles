;; magit requres this lib, but it is not installed automatically on
;; Windows.
(use-package cl-lib)
(use-package magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)