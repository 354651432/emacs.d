(set-face-font 'default (font-spec :family "Source Code Pro" :size 22) )

(unless  (package-installed-p 'use-package)
  (package-install 'use-package))

(use-package doom-modeline
  :ensure t
  :config (doom-modeline-mode 1))

(use-package shell-pop
  :ensure t
  :bind ("C-`" . shell-pop)
  :custom
  (shell-pop-window-position "buttom")
  (shell-pop-full-span t))

(defvar dual-ro-map
  (let ((map (make-keymap))
        (keybindings '(
                       ("n" . next-line)
                       ("p" . previous-line)
                       ("a" . move-beginning-of-line)
                       ("e" . move-end-of-line)
                       ("f" . forward-char)
                       ("b" . backward-char)
                       ("v" . scroll-up)
                       )))
    (suppress-keymap map)
    (dolist (it keybindings map)
      (define-key map (car it) (cdr it)))))

(define-advice read-only-mode (:after (&rest _) ro-adv)
  (use-local-map (if buffer-read-only dual-ro-map nil)))

(global-set-key (kbd "C-x x") 'recentf-open-files)
(global-hl-line-mode t)

(use-package web-mode
  :ensure t
  :mode "\\.blade.php\\'")

(use-package emmet-mode
  :ensure t
  :hook (web-mode css-mode scss-mode sgml-mode rjsx-mode)
  :config
  (add-hook 'emmet-mode-hook (lambda ()
                               (setq emmet-indent-after-insert t))))

(use-package rjsx-mode
  :ensure t
  :mode ("\\.jsx")
  :bind ("C-j" . emmet-expand-line)
  :hook (rjsx-mode . (lambda ()
                       (setq-local emmet-expand-jsx-className? t))))

(use-package react-snippets
  :ensure t)
(add-hook 'rjsx-mode-hook #'setup-tide-mode)

(use-package  mode-local
  :ensure t
  :config
  (setq-mode-local rjsx-mode emmet-expand-jsx-className? t)
  (setq-mode-local web-mode emmet-expand-jsx-className? nil))

(use-package tide
  :load-path "/home/dual/code/purcel/.emacs.d/site-lisp/tide"
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifer-mode)
         (rjsx-mode . tide-setup)
         (before-save . tide-format-before-save)))

(use-package multiple-cursors
  :ensure t
  :bind (
         ("M-3" . mc/mark-next-like-this-word)
         ("M-4" . mc/mark-previous-like-this-word)
         :map ctl-x-map
         ("\C-m" . mc/mark-all-dwim)
         ("<return>" . mule-keymap)))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode)
  (use-package yasnippet-snippets :ensure t))

(use-package js2-mode
  :ensure t
  :mode (("\\.js\\'" . js2-mode)
         ("\\.json\\'" . javascript-mode))
  :init
  (setq-default js2-basic-offset 4)
  (setq-default js2-global-externs '(
                                     "module"
                                     "require"
                                     "assert"
                                     "setInterval"
                                     "console"
                                     "__dirname__")))

(defun setup-tide-mode ()
  "setup tide mode for other mode."
  (interactive)
  (message "setup tide mode")
  (tide-setup)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1) )

(add-hook 'js2-mode-hook #'setup-tide-mode)

(use-package prettier-js
  :ensure t
  :hook ((js2-mode . prettier-js-mode)))

(use-package http-mode
  :load-path "/home/dual/code/purcel/.emacs.d/site-lisp/http-mode"
  :mode "\\.http\\'")

(provide 'init-local)
