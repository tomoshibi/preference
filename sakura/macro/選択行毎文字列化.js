//選択中のテキスト取得
var str = Editor.GetSelectedString(0);

//改行文字列で選択範囲を分割
var lines = str.split(/\r\n|\n/);

//分割した文字列を行ごとに処理
var r = "";
for (var i = 0; i < lines.length; i++) {
    //行毎にコメントを挿入する。
    if (i == lines.length - 1) {
        r += "'" + lines[i] + "'";
    } else {
        r += "'" + lines[i] + "',\r\n";
    }
}
Editor.InsText(r);