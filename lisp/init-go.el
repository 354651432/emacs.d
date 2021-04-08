(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :hook (go-mode . 'lsp-deferred)
  :custom
  (compile-command "go build && ./demo")
  (tab-width 4)
  (company-idle-delay 0.3)
  :bind ("C-c C-c" . 'recompile))

(add-hook 'go-mode-hook 'lsp-deferred)

(provide 'init-go)
