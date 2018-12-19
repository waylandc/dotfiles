
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)

;; skip the splash screen and goto scratch buffer immediately
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; turn off scroll bars, menu and tool bars
(desktop-save-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(display-time-mode 1)
(global-display-line-numbers-mode)
;; Highlight current line
(global-hl-line-mode 1)

;; Theme
(rc/require 'powerline)
(powerline-default-theme)
(rc/require 'subatomic256-theme)
(load-theme 'subatomic256 t)


;; Setup font
(cond
   ((eq system-type 'windows-nt) (set-frame-font "Source Code Pro-12"))
;; ((eq system-type 'windows-nt) (add-to-list 'default-frame-alist
;;		    '(font . "-outline-Source Code Pro-normal-normal-normal-mono-20-*-*-*-c-*-iso8859-1")))
;;						   "Source Code Pro-12")))
   ((eq system-type 'gnu/linux) (set-frame-font "Consolas-13"))
   ((eq system-type 'darwin) (set-frame-font "Roboto Mono for Powerline-14"))
)


;;(defun rc/get-default-font ()
;;  (cond
   ;((eq system-type 'windows-nt) "Consolas-12")
;;((eq system-type 'gnu/linux) "Consolas-16")))

;;(add-to-list 'default-frame-alist `(font . ,(rc/get-default-font)))

;;(when (display-graphic-p)
;;  (set-face-attribute 'fixed-pitch nil :family (rc/get-default-font)))


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
