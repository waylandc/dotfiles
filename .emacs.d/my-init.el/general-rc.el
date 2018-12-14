;;==================== General setup================================

;; C-x C-f open files always changes the directory. This prevents that
(add-hook 'find-file-hook
          (lambda ()
            (setq default-directory command-line-default-directory)))

;; turn off annoying backup files
(setq make-backup-files nil)
;; disable auto save
(setq auto-save-default nil)

;; abbreviate yes/no in prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;; close braces as soon as you open them
(rc/require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers

;; configure auto-complete
;; (ac-config-default)

