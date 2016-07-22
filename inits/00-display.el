;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 画面についての標準設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ダーク系のテーマ
(el-get-bundle elpa:hc-zenburn-theme)
(use-package hc-zenburn-theme
  :config
  (load-theme 'hc-zenburn t)
  )

;; 起動時の画面はいらない
(setq inhibit-startup-message t)

;; 初期フレームの設定
(setq default-frame-alist
      (append (list '(width . 120)
		    '(height . 45)
 		    '(top . 100)
 		    '(left . 100))
 	      default-frame-alist))

;; Window を透過させる
(set-frame-parameter nil 'alpha 100)

;; ファイルを開いている時はタイトルにファイル名を表示
(setq frame-title-format '(:eval (if (buffer-file-name)
      (format "%s - Emacs@%s" (buffer-file-name) (system-name))
      (format "Emacs@%s" (system-name)))))

;; 左側に行数を表示して現在の行を示してくれる
(el-get-bundle elpa:hlinum)
(use-package hc-zenburn-theme
  :config
  (custom-set-faces '(linum-highlight-face ((t (:foreground "black" :background "red")))))
  ;; 常にlinim-modeを有効にする
  (custom-set-variables '(global-linum-mode t))
  )

;; メニューバーを消す
(menu-bar-mode -1)
;; ツールバーを消す
(tool-bar-mode -1)
