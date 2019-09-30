(use-package lsp-mode
  :ensure t
  :defer t
  :config (progn
	    (require 'lsp-flycheck)
	    ;(add-hook 'python-mode-hook 'lsp-mode)
	    (add-hook 'rust-mode-hook #'lsp)
	    (set-face-attribute 'lsp-face-highlight-textual nil
				:background "#666" :foreground "#ffffff"
				)
	    ))
(use-package lsp-python
  :ensure t
  :config(progn
	   (add-hook 'python-mode-hook 'lsp-python-enable)
	   ))
(use-package lsp-rust
  :ensure t
  :config (progn
	    (require 'lsp-flycheck)
	    (require 'lsp-mode)
	    (add-hook 'rust-mode-hook 'lsp-rust-enable)
	    (add-hook 'rust-mode-hook 'flycheck-mode)
	    ))
			