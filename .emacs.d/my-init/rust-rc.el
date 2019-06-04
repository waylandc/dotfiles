(use-package rust-mode :ensure t)
(use-package flycheck-rust :ensure t)
(use-package racer :ensure t)

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
;;(add-hook 'racer-mode-hook #'company-mode)
(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)
(setq rust-format-on-save t)
;; change M-x compile for rust
(setq compile-command "cargo build")

