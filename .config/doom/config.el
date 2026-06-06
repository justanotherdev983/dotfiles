;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Disable visual tab/indentation guides
(after! highlight-indent-guides
  (setq highlight-indent-guides-method nil)
  (remove-hook 'prog-mode-hook #'highlight-indent-guides-mode))

;; Disable whitespace visualization
(after! whitespace
  (setq whitespace-style '())
  (global-whitespace-mode -1))

;; Set these globally without hooks
(setq-default indicate-empty-lines nil
              show-trailing-whitespace nil)

;; Wayland clipboard support
(when (getenv "WAYLAND_DISPLAY")
  (setq select-enable-clipboard t)
  (setq select-enable-primary t)
  (setq wl-copy-process nil))

;; Use wl-copy/wl-paste for clipboard operations on Wayland
(when (and (getenv "WAYLAND_DISPLAY")
           (executable-find "wl-copy")
           (executable-find "wl-paste"))
  (setq interprogram-cut-function
        (lambda (text)
          (setq wl-copy-process (make-process :name "wl-copy"
                                              :buffer nil
                                              :command '("wl-copy" "-f" "-n")
                                              :connection-type 'pipe))
          (process-send-string wl-copy-process text)
          (process-send-eof wl-copy-process)))
  (setq interprogram-paste-function
        (lambda ()
          (when (and (executable-find "wl-paste")
                     (zerop (call-process "wl-paste" nil nil nil "-l")))
            (shell-command-to-string "wl-paste -n")))))
(setq which-key-idle-delay 0.3)

;; vterm performance optimizations
(after! vterm
  (setq vterm-max-scrollback 5000)  ; Reduce from default 100000
  (setq vterm-buffer-name-string "vterm %s")
  (setq vterm-timer-delay 0.01)  ; Lower delay for faster updates
  (setq vterm-kill-buffer-on-exit t))  ; Clean up buffers automatically

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Comic Mono" :size 24 :weight 'regular))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-rose-pine) 
(custom-theme-set-faces! 'doom-rose-pine
  ;; --- TYPES ---
  ;; int, char, void -> Foam (Light Blue)
  `(font-lock-type-face :foreground "#9ccfd8")
  `(font-lock-builtin-face :foreground "#9ccfd8") 

  ;; --- FUNCTIONS ---
  ;; Definitions (main) -> Rose (Muted Pink)
  `(font-lock-function-name-face :foreground "#ebbcba")
  ;; Calls (printf, generic_func) -> Rose (Muted Pink)
  ;; This fixes the "function calls are white" issue
  `(font-lock-function-call-face :foreground "#ebbcba")

  ;; --- VARIABLES ---
  ;; Definition (int x) -> Text (White)
  ;; This fixes the "vars are purple" issue (Doom defaults this to Purple)
  `(font-lock-variable-name-face :foreground "#e0def4")
  ;; Usage (x = 1) -> Text (White)
  `(font-lock-variable-use-face :foreground "#e0def4")
  
  ;; --- KEYWORDS & CONTROL ---
  ;; if, else, return -> Pine (Dark Green/Teal)
  `(font-lock-keyword-face :foreground "#31748f")
  
  ;; --- PREPROCESSOR ---
  ;; #include, #define -> Iris (Purple)
  `(font-lock-preprocessor-face :foreground "#c4a7e7")
  
  ;; --- NUMBERS & CONSTANTS ---
  ;; 123, 0xFF -> Gold
  `(font-lock-number-face :foreground "#f6c177")
  `(font-lock-constant-face :foreground "#f6c177")
  )


(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default evil-shift-width 4)

;; Make TAB key behave like vim
(map! :after evil
      :nv "TAB" #'evil-jump-item) ; % behavior in vim

;; Ensure tabs insert actual indentation
(setq-default c-basic-offset 4)
(setq-default tab-always-indent t)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq display-line-numbers-current-absolute t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq-default indent-tabs-mode nil)

;; Set the default indentation width (in spaces)
(setq-default tab-width 4)
(after! evil
  (map! :nv "TAB" #'evil-jump-item))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; Force disable visual indicators (run last)

;; Nuclear option: disable all visual whitespace everywhere
(add-hook! 'after-change-major-mode-hook
  (whitespace-mode -1)
  (setq indicate-empty-lines nil)
  (setq show-trailing-whitespace nil))

;; Specifically for C/C++ modes
(add-hook! '(c-mode-hook c++-mode-hook)
  (whitespace-mode -1)
  (setq show-trailing-whitespace nil))

;; Auto-reload files when they change on disk (e.g., after git checkout)
(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)  ; Don't spam messages

;;(setq xref-show-definitions-function #'xref-show-definitions-completing-read)

;; Jump directly to definition like Neovim (no xref prompts)
(after! evil
  ;; Override gd to jump directly without prompts
  (map! :map (c-mode-map c++-mode-map)
        :n "gd" #'+lookup/definition))

;; Make +lookup/definition not show xref buffer
(after! lookup
  (setq +lookup-definition-functions
        '(+lookup-xref-definitions-backend-fn
          +lookup-dumb-jump-backend-fn
          +lookup-project-search-backend-fn
          +lookup-evil-goto-definition-backend-fn))
  
  ;; Force xref to jump directly
  (setq xref-show-definitions-function
        (lambda (fetcher alist)
          (let* ((xrefs (funcall fetcher))
                 (xref (car xrefs)))
            (if xref
                (xref-pop-to-location xref
                                      (assoc-default 'display-action alist))
              (user-error "No definitions found")))))
  
  ;; Also handle xref-show-xrefs (for references)
  (setq xref-show-xrefs-function
        (lambda (fetcher alist)
          (let* ((xrefs (funcall fetcher))
                 (xref (car xrefs)))
            (if xref
                (xref-pop-to-location xref
                                      (assoc-default 'display-action alist))
              (user-error "No references found"))))))

(after! lsp-mode
  (setq lsp-enable-file-watchers nil  ; Faster on huge repos
        lsp-idle-delay 0.5
        lsp-log-io nil
        lsp-enable-folding nil
        lsp-enable-snippet nil
        lsp-enable-symbol-highlighting nil))

;; clangd for kernel/LLVM work
(after! lsp-clangd
  (setq lsp-clients-clangd-args 
        '("--background-index"
          "--clang-tidy=false"  ; Disable for kernel
          "--completion-style=detailed"
          "--header-insertion=never"
          "--query-driver=/usr/bin/gcc,/usr/bin/g++,/usr/bin/clang*"
          "--enable-config"
          "-j=4"
          "--log=error"
          "--pch-storage=memory")))

(setq treesit-language-source-alist
      '((c "https://github.com/tree-sitter/tree-sitter-c" "v0.21.3")
        (cpp "https://github.com/tree-sitter/tree-sitter-cpp" "v0.22.0")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (bash "https://github.com/tree-sitter/tree-sitter-bash")
        (cmake "https://github.com/uyha/tree-sitter-cmake")))

(defun my/install-tree-sitter-grammars ()
  "Install tree-sitter grammars if they are missing."
  (interactive)
  (dolist (lang '(c cpp))
    (unless (treesit-language-available-p lang)
      (treesit-install-language-grammar lang))))

;;; Git/Magit Configuration

(after! magit
  ;; Better diffs
  (setq magit-diff-refine-hunk 'all
        magit-diff-paint-whitespace t
        magit-diff-refine-ignore-whitespace t)
  
  ;; Performance for huge repos
  (setq magit-refresh-status-buffer nil
        magit-revision-insert-related-refs nil)
  (add-to-list 'magit-commit-arguments "--signoff"))
  
  ;; Kernel commit style
  (setq git-commit-summary-max-length 50
        git-commit-fill-column 75
        git-commit-signoff t))  ; Auto sign-off

;; Git commit template
(setq git-commit-template "~/.gitmessage")

;; Git commit style checks
(setq git-commit-style-convention-checks
      '(non-empty-second-line
        overlong-summary-line))

;;; Email (mu4e) for LKML patches

(after! mu4e
  (setq mu4e-sent-folder "/Sent"
        mu4e-drafts-folder "/Drafts"
        mu4e-trash-folder "/Trash"
        mu4e-get-mail-command "mbsync -a"
        mu4e-update-interval 300
        mu4e-compose-format-flowed nil  ; CRITICAL for patches
        mu4e-compose-dont-reply-to-self t
        mu4e-view-prefer-html nil)
  
  ;; NO line wrapping for patches
  (add-hook 'mu4e-compose-mode-hook
            (lambda ()
              (turn-off-auto-fill)
              (visual-line-mode -1)
              (setq-local fill-column 999999)))
  
  ;; Send via msmtp
  (setq message-send-mail-function 'message-send-mail-with-sendmail
        sendmail-program "/usr/bin/msmtp"
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-sendmail-f-is-evil t)
  
  ;; Citation style for patch replies
  (setq message-citation-line-function 'message-insert-formatted-citation-line
        message-citation-line-format "On %a, %b %d %Y, %N wrote:"))

;;; Org-mode Configuration

(setq org-directory "~/code/emacs/org/")

(after! org
  (setq org-default-notes-file "~/code/emacs/org/notes.org"
        org-agenda-files '("~/code/emacs/org/"))
  
  ;; TODO states for patch workflow
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "SENT(s)" "REVIEW(r)" "|" "MERGED(m)" "DONE(d)" "CANCELLED(c)")))
  
  ;; Capture templates
  (setq org-capture-templates
        '(("t" "TODO" entry
           (file+headline "~/code/emacs/org/tasks.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
          
          ("p" "Kernel Patch" entry
           (file+headline "~/code/emacs.org/kernel.org" "Patches")
           "* TODO [PATCH] %?\n  :PROPERTIES:\n  :Subsystem: \n  :Maintainer: \n  :Sent: %U\n  :END:\n  \n** Status\n  \n** Links\n")
          
          ("b" "Bug/Issue" entry
           (file+headline "~/code/emacs/org/bugs.org" "Bugs")
           "* TODO %?\n  :PROPERTIES:\n  :Project: \n  :Found: %U\n  :END:\n  \n** Description\n  \n** Reproduce\n"))))

;;; Custom Functions

(defun my/run-build ()
  "Run build command in vterm"
  (interactive)
  (let ((cmd (read-string "Build command: " "make -j$(nproc)")))
    (+vterm/run cmd)))

(defun my/format-patch-series ()
  "Format patch series with cover letter"
  (interactive)
  (magit-format-patch 
   (read-string "Base commit: " "HEAD~1")
   (list "--cover-letter" "--signoff")))

;;; Keybindings

(map! :leader
      ;; Files and projects
      :desc "Find file in project" "SPC" #'projectile-find-file
      :desc "Switch buffer" "," #'switch-to-buffer
      :desc "Recent files" "f r" #'recentf-open-files
      :desc "Switch project" "p p" #'projectile-switch-project
      :desc "Search in project" "/" #'projectile-ripgrep
      
      ;; Git/Magit
      (:prefix ("g" . "git")
       :desc "Magit status" "g" #'magit-status
       :desc "Magit blame" "b" #'magit-blame
       :desc "Magit log" "l" #'magit-log-current
       :desc "Format patch" "p" #'my/format-patch-series)
      
      ;; Compile/Build
      (:prefix ("c" . "code")
       :desc "Compile" "c" #'compile
       :desc "Recompile" "C" #'recompile
       :desc "Run build" "b" #'my/run-build
       :desc "Format buffer" "f" #'+format/buffer)
      
      ;; Org-mode
      (:prefix ("n" . "notes")
       :desc "Org capture" "n" #'org-capture
       :desc "Org agenda" "a" #'org-agenda
       :desc "Org todo list" "t" #'org-todo-list)
      
      ;; Terminal
      (:prefix ("o" . "open")
       :desc "Toggle vterm" "t" #'+vterm/toggle
       :desc "Vterm here" "T" #'+vterm/here
       :desc "Open mu4e" "m" #'mu4e)
      
      ;; Help/Docs
      (:prefix ("h" . "help")
       :desc "Man page" "m" #'man)
      
      ;; Scratch
      :desc "Scratch buffer" "x" #'doom/open-scratch-buffer
      :desc "Project scratch" "X" #'doom/open-project-scratch-buffer)

;; C-mode specific
(map! :mode c-mode
      :localleader
      :desc "Man page at point" "h" 
      (lambda () (interactive) 
        (man (thing-at-point 'symbol))))


;;; Mouse Configuration

;; Click to move cursor
(setq mouse-1-click-follows-link nil)  ; Don't follow links on single click
(global-set-key [mouse-1] 'mouse-set-point)  ; Left click moves cursor

;; Scroll with mouse wheel (moves screen, not cursor)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)  ; Don't accelerate scrolling
(setq mouse-wheel-follow-mouse t)  ; Scroll window under mouse

;; Smooth scrolling
(setq scroll-step 1
      scroll-conservatively 10000
      scroll-margin 8
      scroll-preserve-screen-position t)  ; Don't move cursor when scrolling

;; Disable Evil's cursor movement on scroll
(after! evil
  (setq evil-scroll-count 0)
  (define-key evil-normal-state-map [mouse-1] 'mouse-set-point)
  (define-key evil-insert-state-map [mouse-1] 'mouse-set-point)
  (define-key evil-visual-state-map [mouse-1] 'mouse-set-point))

;; Pixel-perfect smooth scrolling (Emacs 29+)
(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode 1))
