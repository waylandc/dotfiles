
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

;; Setup font
(when (equal system-type 'windows-nt)
	(set-frame-font "Source Code Pro-12"))
(when (equal system-type 'gnu/linux)
	(set-frame-font "Roboto Mono-8"))
;;	(set-frame-font "San Francisco Display-9"))
(when (equal system-type 'darwin)
	(set-frame-font "Roboto Mono for Powerline-14"))

(when (equal system-type 'windows-nt)
  (set-face-attribute 'default nil :family "Consolas" :height 110))

;; Set default window size and location
(setq my-res-width (nth 3 (nth 1 (car (display-monitor-attributes-list)))))
;; work 2560x1440
;; left was 1180
(if (eq my-res-width 2560)
    (progn
      (setq initial-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 140) ; chars
              (height . 80) ; lines
              (left . 0)
              (top . 0)))
      (setq default-frame-alist
            '(							
              (tool-bar-lines . 0)
              (width . 140)
              (height . 80)
              (left . 0)
              (top . 0))))
 )

;; rMBP More Space 1680x1050
(if (eq my-res-width 1680)
    (progn
      (setq initial-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 100) ; chars
              (height . 60) ; lines
              (left . 880)
              (top . 0)))
      (setq default-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 100)
              (height . 60)
              (left . 880)
              (top . 0))))
)

;; rMBP Default 1440x900
(if (eq my-res-width 1440)
    (progn
      (setq initial-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 100) ; chars
              (height . 50) ; lines
              (left . 630)
              (top . 0)))
      (setq default-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 100)
              (height . 50)
              (left . 630)
              (top . 0))))
  )
;; home 
(if (eq my-res-width 3840)
    (progn
      (setq initial-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 190) ; chars
              (height . 85) ; lines
              (left . 1910)
              (top . 0)))
      (setq default-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 190)
              (height . 85)
              (left . 1910)
              (top . 0))))
)
