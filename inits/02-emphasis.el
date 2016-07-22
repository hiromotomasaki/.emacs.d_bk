;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 強調についての標準設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 任意のシンボルをハイライトする
;; C+F3 : カーソルが乗っているシンボルをハイライトする. もう一度C+F3を押すと解除
;; ハイライトの状態で
;; F3 : 次のハイライトしているシンボルへ移動する
;; Shift-F3 : 前のハイライトしているシンボルへ移動する
;; Alt-F3 : ハイライトしているシンボルを置換する
(el-get-bundle elpa:highlight-symbol)
(use-package highlight-symbol
  :config
  (global-set-key [(control f3)] 'highlight-symbol-at-point)
  (global-set-key [f3] 'highlight-symbol-next)
  (global-set-key [(shift f3)] 'highlight-symbol-prev)
  (global-set-key [(meta f3)] 'highlight-symbol-query-replace)
  )

