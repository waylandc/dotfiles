;; package.el
(require 'package)
(require 'cl)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "https://marmalade-repo.org/packages/") t)
(package-initialize)

(setq my-init-dir
    (file-name-directory
        (or load-file-name (buffer-file-name))))

(cond ((eq system-type 'windows-nt)
       (load "C:/Users/Wayland/.emacs.d/my-init.el/rc.el")

       (load "C:/Users/Wayland/.emacs.d/my-init.el/general-rc.el")
       (load "C:/Users/Wayland/.emacs.d/my-init.el/appearance-rc.el")
       (load "C:/Users/Wayland/.emacs.d/my-init.el/company-rc.el")
       (load "C:/Users/Wayland/.emacs.d/my-init.el/protobuf-mode.el")
       (load "C:/Users/Wayland/.emacs.d/my-init.el/golang-rc.el")
       (load "C:/Users/Wayland/.emacs.d/my-init.el/magit-rc.el")
       (load "C:/Users/Wayland/.emacs.d/my-init.el/js2-mode-rc.el")
       (load "C:/Users/Wayland/.emacs.d/my-init.el/typescript-rc.el")
       )
    ((eq system-type 'darwin)
       (load "~/.emacs.d/my-init.el/rc.el")

       (load "~/.emacs.d/my-init.el/general-rc.el")
       (load "~/.emacs.d/my-init.el/appearance-rc.el")
       (load "~/.emacs.d/my-init.el/company-rc.el")
       (load "~/.emacs.d/my-init.el/golang-rc.el")
       (load "~/.emacs.d/my-init.el/protobuf-mode.el")
       (load "~/.emacs.d/my-init.el/magit-rc.el")
       (load "~/.emacs.d/my-init.el/js2-mode-rc.el")
       (load "~/.emacs.d/my-init.el/web-mode-rc.el")
       (load "~/.emacs.d/my-init.el/fzf-rc.el")
       ;;(load "C:/Users/Wayland/.emacs.d/my-init.el/typescript-rc.el")
       )
)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auto-complete-config subatomic256-theme typescript-mode dash-functional web-mode shrink-path protobuf-mode powerline magit json-mode js2-mode gotest go-eldoc go-autocomplete flycheck eldoc-eval company-go autopair))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
