\# ws\_probe\_delphi



Windows 11 25H2 における Working Set / Page Fault の挙動を

Delphi (Win64) で実測するための検証コード。



\## 内容

\- VirtualAlloc による 512MB 匿名メモリ確保

\- ページ単位アクセス（Read / Read+Write）

\- 60秒保持 + 再アクセス

\- Working Set / Page Fault 観測

\- Memory Compression ON / OFF 切り替え用 PowerShell scripts



\## 実行例

```powershell

ws\_probe\_delphi.exe mem\_ro

ws\_probe\_delphi.exe mem\_rw


Windows 11 25H2 における Working Set は Memory Compression や Prefetch では決まらない｜キョウスケ
https://note.com/kyona_blog/n/n8b378a519219


