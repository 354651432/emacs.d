(use-package company-go
  :ensure t
  :hook (go-mode . (lambda ()
                     (set (make-local-variable 'company-backends) '((company-files company-go)))))
  :custom
  (company-tooltip-limimt 20)
  (company-idle-delay 0.3)
  (company-echo-delay 0)
  (compile-command "go build && ./demo")
  :bind ("C-c C-c" . recompile))


(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :hook (before-save . gofmt-before-save)
  :custom
  (gofmt-command "goimports")
  (tab-width 4))

(use-package lsp-mode
  :ensure t
  :hook (go-mode . 'lsp-deferred))

(provide 'init-go)
