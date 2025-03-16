
(setq native-comp-async-report-warnings-errors 'silent)

(require 'org)

(org-babel-load-file
  (expand-file-name "settings.org" user-emacs-directory)) 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil toml-mode magit rainbow-mode org-bullets which-key smart-mode-line golden-ratio doom-themes rainbow-delimiters all-the-icons vertico orderless marginalia diminish consult)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-tab ((t (:foreground "#636363")))))
