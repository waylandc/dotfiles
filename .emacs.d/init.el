;; package.el
(require 'package)
(require 'cl)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
;; (package-refresh-contents)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(load "C:/Users/Wayland/.emacs.d/my-init/general-rc.el")
(load "C:/Users/Wayland/.emacs.d/my-init/appearance.el")
(load "C:/Users/Wayland/.emacs.d/my-init/company-rc.el")
(load "C:/Users/Wayland/.emacs.d/my-init/go.el")
(load "C:/Users/Wayland/.emacs.d/my-init/magit-rc.el")
(load "C:/Users/Wayland/.emacs.d/my-init/protobuf-rc.el")
;;(load "C:/Users/Wayland/.emacs.d/my-init/vuejs-rc.el")
;;(load "C:/Users/Wayland/.emacs.d/my-init/web-mode-rc.el")
(load "C:/Users/Wayland/.emacs.d/my-init/js2-mode-rc.el")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(auto-complete-config go-snippets go-guru company-go go-mode use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
