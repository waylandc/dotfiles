
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)

;; skip the splash screen and goto scratch buffer immediately
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; turn off scroll bars, menu and tool bars
;; (desktop-save-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(display-time-mode 1)
(global-display-line-numbers-mode)
;; Highlight current line
(global-hl-line-mode 1)

(use-package powerline :ensure t)
(powerline-default-theme)
(use-package subatomic256-theme :ensure t)
(load-theme 'subatomic256 t)

;; Setup font
(when (equal system-type 'windows-nt)
	(set-frame-font "Source Code Pro-12"))
(when (equal system-type 'gnu-linux)
	(set-frame-font "Consolas-13"))
(when (equal system-type 'darwin)
	(set-frame-font "Roboto Mono for Powerline-14"))

(when (equal system-type 'windows-nt)
  (set-face-attribute 'default nil :family "Consolas" :height 110))

;; Set default window size and location 
(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 128) ; chars
              (height . 80) ; lines
              (left . 2260)
              (top . 0)))
      (setq default-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 106)
              (height . 60)
              (left . 50)
              (top . 50))))
  (progn
    (setq initial-frame-alist '( (tool-bar-lines . 0)))
    (setq default-frame-alist '( (tool-bar-lines . 0)))))

