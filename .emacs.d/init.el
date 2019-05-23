;; package.el
(require 'package)
(require 'cl)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
;; (package-refresh-contents)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(when (equal system-type 'windows-nt)
  (setq init-file-dir "C:/Users/Wayland/.emacs.d"))
(when (equal system-type 'gnu-linux)
  (setq init-file-dir "~/.emacs.d"))
(when (equal system-type 'darwin)
  (setq init-file-dir "~/.emacs.d"))
(load (concat init-file-dir "/my-init/general-rc.el"))
(load (concat init-file-dir "/my-init/appearance.el"))
(load (concat init-file-dir "/my-init/company-rc.el"))
(load (concat init-file-dir "/my-init/go.el"))
(load (concat init-file-dir "/my-init/magit-rc.el"))
(load (concat init-file-dir "/my-init/tidy-web-rc.el"))
;; (load (concat init-file-dir "/my-init/web-mode-rc.el"))
(load (concat init-file-dir "/my-init/vuejs-rc.el"))
;;(load (concat init-file-dir "/my-init/js2-mode-rc.el"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("ecba61c2239fbef776a72b65295b88e5534e458dfe3e6d7d9f9cb353448a569e" "fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "bf798e9e8ff00d4bf2512597f36e5a135ce48e477ce88a0764cfb5d8104e8163" "8dce5b23232d0a490f16d62112d3abff6babeef86ae3853241a85856f9b0a6e7" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(package-selected-packages
   (quote
	(flymake-go twilight-bright-theme solarized-theme auto-complete-config go-snippets go-guru company-go go-mode use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
