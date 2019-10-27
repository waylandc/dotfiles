
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

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Setup font by checking if it exists on this system first
;; List them in order of preference as it'll use the first one found
(defun font-exists-p (font) "check if font exists" (if (null(x-list-fonts font)) nil t))
(cond
  ((if (font-exists-p "Hack Nerd Font") (set-face-attribute 'default nil :font "Hack Nerd Font-14")))
  ((if (font-exists-p "Helvetica Neue") (set-face-attribute 'default nil :font "Helvetica Neue-14")))
  ((if (font-exists-p "Optima") (set-face-attribute 'default nil :font "Optima-14")))
  ((if (font-exists-p "Roboto") (set-face-attribute 'default nil :font "Roboto Mono-12")))
  ((if (font-exists-p "Source Code Pro") (set-face-attribute 'default nil :font "Source Code Pro-12")))
  ((if (font-exists-p "Consolas") (set-face-attribute 'default nil :family "Consolas" :height 110))))

;(set-frame-width (selected-frame) 110)
;(set-frame-height (selected-frame) 70)
(setq initial-frame-alist
      '(
        (tool-bar-lines . 0)
        (width . 110) ; chars
        (height . 70) ; lines
        (left . 0)
        (top . 0)))
(setq default-frame-alist
      '(							
        (tool-bar-lines . 0)
        (width . 110)
        (height . 70)
        (left . 0)
        (top . 0)))

