;; package.el
(require 'package)
(require 'cl)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(setq my-init-dir
    (file-name-directory
        (or load-file-name (buffer-file-name))))

(load "C:/Users/Wayland/.emacs.d/my-init.el/rc.el")

(load "C:/Users/Wayland/.emacs.d/my-init.el/appearance-rc.el")
(load "C:/Users/Wayland/.emacs.d/my-init.el/company-rc.el")
(load "C:/Users/Wayland/.emacs.d/my-init.el/golang-rc.el")
(load "C:/Users/Wayland/.emacs.d/my-init.el/magit-rc.el")
(load "C:/Users/Wayland/.emacs.d/my-init.el/js2-mode-rc.el")
;;(load "C:/Users/Wayland/.emacs.d/my-init.el/typescript-rc.el")

;; configure auto-complete
;; (ac-config-default)

;;==================== General setup================================

;; turn off annoying backup files
(setq make-backup-files nil)

;; abbreviate yes/no in prompts
(defalias 'yes-or-no-p 'y-or-n-p)

;; close braces as soon as you open them
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (typescript-mode dash-functional web-mode shrink-path protobuf-mode powerline material-theme magit kaolin-themes json-mode js2-mode gotest go-eldoc go-autocomplete flycheck eldoc-eval doom-themes company-go autopair))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
