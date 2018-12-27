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

;; by default tabs are already used for indentation but just set here for clarity
;; note - setq-default sets  values only in buffers that do not have their own
;; local value of the variable
(setq-default indent-tabs-mode t)
;; make our default tab width 4.
(setq-default tab-width 4)
;; to override tab width in a mode hook use (setq tab-width 2)

