;; 辞書を引いて文字列の自動補完
(el-get-bundle auto-complete)
(use-package auto-complete
  :config
  ;; auto-completeが辞書として使うファイルが保存されているパスの登録
  ;; もし自分で辞書を作成したらadd-to-listでそのファイルがおいてあるパスを示す。
  ;; ファイルの例は~/.emacs.d/elisp/auto-complete/dictを参考にする
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/auto-complete/dict")
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/dict"))


;; ;; 辞書を引いて関数の自動補完
(el-get-bundle yasnippet)
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :bind (:map yas-minor-mode-map
             ("C-x i i" . yas-insert-snippet)
             ("C-x i n" . yas-new-snippet)
             ("C-x i v" . yas-visit-snippet-file)
             ("C-x i l" . yas-describe-tables)
             ("C-x i g" . yas-reload-all)
             )
  :config
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets" ;; 作成するスニペットの保存先
	  yas-installed-snippets-dir ;; package に最初から含まれるスニペット
	  ))
  (yas-global-mode 1)
  (setq yas-prompt-functions '(yas-ido-prompt))
)

;; ヘッダーの自動補完
(el-get-bundle auto-complete-c-headers)
(use-package auto-complete-c-headers
  :init
  (add-hook 'c++-mode-hook (lambda () 
            '(setq ac-sources (append ac-sources '(ac-source-c-headers)))))
  (add-hook 'c-mode-hook (lambda () 
			   '(setq ac-sources (append ac-sources '(ac-source-c-headers))))))
;; インクルード先の追加部分は時間があるときに後で書く;; ヘッダーの自動補完
(el-get-bundle auto-complete-c-headers)
(use-package auto-complete-c-headers
  :init
  (add-hook 'c++-mode-hook (lambda () 
            '(setq ac-sources (append ac-sources '(ac-source-c-headers)))))
  (add-hook 'c-mode-hook (lambda () 
			   '(setq ac-sources (append ac-sources '(ac-source-c-headers))))))
;; インクルード先の追加部分は時間があるときに後で書く

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 翻訳
;; C-c tで翻訳できる
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(el-get-bundle popwin)
(el-get-bundle google-translate)

(autoload 'google-translate-translate "google-translate" "" t)
(defvar google-translate-english-chars "[:ascii:]"
  "これらの文字が含まれているときは英語とみなす")
(defun google-translate-enja-or-jaen (&optional string)
  "regionか、現在のセンテンスを言語自動判別でGoogle翻訳する。"
  (interactive)
  (setq string
        (cond ((stringp string) string)
              (current-prefix-arg
               (read-string "Google Translate: "))
              ((use-region-p)
               (buffer-substring (region-beginning) (region-end)))
              (t
               (save-excursion
                 (let (s)
                   (forward-char 1)
                   (backward-sentence)
                   (setq s (point))
                   (forward-sentence)
                   (buffer-substring s (point)))))))
  (let* ((asciip (string-match
                  (format "\\`[%s]+\\'" google-translate-english-chars)
                  string)))
    (run-at-time 0.1 nil 'deactivate-mark)
    (google-translate-translate
     (if asciip "en" "ja")
     (if asciip "ja" "en")
     string)))
(global-set-key (kbd "C-c t") 'google-translate-enja-or-jaen)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Aspell
;; 静的なスペルチェッカー
;; http://www.aise.ics.saitama-u.ac.jp/~gotoh/WritingEnvironmentOnUbuntu1404ja.html#toc9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; For Aspell
(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
  '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; タブや半角スペースを表示する設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package whitespace
  :config
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
;;                         empty          ; 先頭/末尾の空行
                         space-mark     ; 表示のマッピング
                         tab-mark
                         ))

(setq whitespace-display-mappings
      '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

(global-whitespace-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; google検索と英辞郎検索（firefox）
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(el-get-bundle tomoya/search-web.el)
(defun search-web-dwim (&optional arg-engine)
  "transient-mark-mode がオンの時はリージョンを，
オフの時はカーソル位置の単語を検索する．"
  (interactive)
  (cond
   ((transient-region-active-p)
    (search-web-region arg-engine))
   (t
    (search-web-at-point arg-engine))))

(require 'search-web)

(define-prefix-command 'search-web-map)
(global-set-key (kbd "M-i") 'search-web-map)
(global-set-key (kbd "M-i g") (lambda () (interactive) (search-web-dwim "google")))
(global-set-key (kbd "M-i e") (lambda () (interactive) (search-web-dwim "eijiro")))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; 折りたたみ機能
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'c++-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'c-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'scheme-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'python-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'xml-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))

;; key-bind
 (define-key global-map (kbd "C-^") 'hs-toggle-hiding)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'autoinsert)

;; テンプレートのディレクトリ
(setq auto-insert-directory "~/Templates/insert/")

;; 各ファイルによってテンプレートを切り替える
(setq auto-insert-alist
      (nconc '(
               ("\\.cpp$" . ["template.cpp" my-template])
               ("\\.h$"   . ["template.h" my-template])
               ) auto-insert-alist))
(require 'cl)

;; ここが腕の見せ所
(defvar template-replacements-alists
  '(("%file%"             . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ("%include-guard%"    . (lambda () (format "__SCHEME_%s__" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))))

(defun my-template ()
  (time-stamp)
  (mapc #'(lambda(c)
        (progn
          (goto-char (point-min))
          (replace-string (car c) (funcall (cdr c)) nil)))
    template-replacements-alists)
  (goto-char (point-max))
  (message "done."))
(add-hook 'find-file-not-found-hooks 'auto-insert)



