document.addEventListener("DOMContentLoaded", () => {
  // 全てのトースト要素を取得
  const toasts = document.querySelectorAll(".toast");

  toasts.forEach((toast) => {
    // 4秒後にトーストをフェードアウト
    setTimeout(() => {
      toast.classList.add("fade-out"); // フェードアウト用のクラスを追加

      // フェードアウトアニメーションが完了した後に要素を削除
      toast.addEventListener("transitionend", () => {
        if (toast.parentNode) {
          toast.parentNode.removeChild(toast); // 親ノードから削除
        }
      });
    }, 4000); // 4秒後にフェードアウト開始
  });
});
